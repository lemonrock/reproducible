# This file is part of reproducible-rust. It is subject to the license terms in the COPYRIGHT file found in the top-level directory of this distribution and at https://raw.githubusercontent.com/lemonrock/reproducible-rust/master/COPYRIGHT. No part of reproducible-rust, including this file, may be copied, modified, propagated, or distributed except according to the terms contained in the COPYRIGHT file.
# Copyright © 2021 The developers of reproducible-rust. See the COPYRIGHT file in the top-level directory of this distribution and at https://raw.githubusercontent.com/lemonrock/reproducible-rust/master/COPYRIGHT.


_exit_message()
{
	local code="$1"
	local message="$2"
	printf "%s\n" "$message"
	exit $code
}

exit_help_message()
{
	_exit_message 0 "$1"
}

_exit_error_message()
{
	local code="$1"
	local message="$2"
	_exit_message $code "$1" 1>&2
}

exit_error_message()
{
	_exit_error_message 1 "$1"
}

# See https://man.openbsd.org/sysexits.3

exit_usage_message()
{
	local EX_USAGE=64
	_exit_error_message $EX_USAGE "$1"
}

exit_configuration_message()
{
	local EX_CONFIG=64
	_exit_error_message $EX_CONFIG "$1"
}

exit_system_file_message()
{
	local EX_OSFILE=71
	_exit_error_message $EX_OSFILE "$1"
}

exit_temporary_fail_message()
{
	local EX_TEMPFAIL=77
	_exit_error_message $EX_TEMPFAIL "$1"
}

exit_can_not_create_message()
{
	local EX_CANTCREAT=73
	_exit_error_message $EX_CANTCREAT "$1"
}

exit_permission_message()
{
	local EX_NOPERM=77
	_exit_error_message $EX_NOPERM "$1"
}

exit_if_folder_missing()
{
	local folder_path="$1"
	if [ ! -e "$folder_path" ]; then
		exit_configuration_message "folder $folder_path does not exist"
	fi
	if [ ! -r "$folder_path" ]; then
		exit_permission_message "folder $folder_path is not readable"
	fi
	if [ ! -d "$folder_path" ]; then
		exit_configuration_message "folder $folder_path is not a folder"
	fi
	if [ ! -x "$folder_path" ]; then
		exit_permission_message "folder $folder_path is not searchable"
	fi
}

exit_if_configuration_file_missing()
{
	local file_path="$1"
	if [ ! -e "$file_path" ]; then
		exit_configuration_message "configuration file $file_path does not exist"
	fi
	if [ ! -r "$file_path" ]; then
		exit_permission_message "configuration file $file_path is not readable"
	fi
	if [ ! -f "$file_path" ]; then
		exit_configuration_message "configuration file $file_path is not a file"
	fi
	if [ ! -s "$file_path" ]; then
		exit_configuration_message "configuration file $file_path is empty"
	fi
}

exit_if_existing_file_missing()
{
	local file_path="$1"
	if [ ! -r "$file_path" ]; then
		exit_permission_message "file $file_path is not readable"
	fi
	if [ ! -f "$file_path" ]; then
		exit_configuration_message "file $file_path is not a file"
	fi
	if [ ! -s "$file_path" ]; then
		exit_configuration_message "file $file_path is empty"
	fi
}

exit_if_character_device_missing()
{
	local character_device_path="$1"
	if [ ! -e "$character_device_path" ]; then
		exit_system_file_message "Character device $character_device_path does not exist"
	fi
	if [ ! -r "$character_device_path" ]; then
		exit_system_file_message "Character device $character_device_path is not readable"
	fi
	if [ ! -c "$character_device_path" ]; then
		exit_system_file_message "Character device $character_device_path is not a character device"
	fi
}

ensure_HOME_is_exported()
{	
	if [ -z ${HOME+unset} ]; then
		cd ~ 1>/dev/null 2>/dev/null
			export HOME="$(pwd)"
		cd - 1>/dev/null 2>/dev/null
	fi
}

ensure_TERM_is_exported()
{
	if [ -z ${TERM+unset} ]; then
		export TERM='dumb'
	fi
}

ensure_PATH_is_exported()
{
	export PATH='/usr/local/bin:/usr/bin:/bin'
}

depends()
{
	local binary
	for binary in "$@"
	do
		if ! $(command -v mkdir 1>/dev/null); then
			exit_error "Binary $binary is not present on the PATH ($PATH)"
		fi
	done
}

depends od head tr
insecure_32_bit_random_number()
{
	exit_if_character_device_missing /dev/urandom
	od -vAn -N4 -t u4 </dev/urandom | head -n 1 | tr -d ' '
}

depends mkdir rm
make_temporary_folder()
{
	mkdir -m 0700 -p "$temporary_folder_path"
	
	local random_number="$(insecure_32_bit_random_number)"
	
	export TMPDIR="$temporary_folder_path"/"$random_number"
	mkdir -m 0700 "$TMPDIR" || exit_can_not_create_message "Did someone else create our folder trying to hack us?"
	
	remove_temporary_directory()
	{
		rm -rf "$TMPDIR"
	}
	trap remove_temporary_directory EXIT
}

depends rm
clean_folder()
{
	local folder_path="$1"
	if [ -e "$folder_path" ]; then
		set +f
			rm -rf "$folder_path"/*
		set -f
	fi
}

# The binary `tac` exists on Linux but not MacOS and other BSDs
command_tac()
{
	if command -v tac 1>/dev/null 2>/dev/null; then
		tac "$@"
	# Darwin (MacOS), BSDs, etc, but not BusyBox.
	elif command -v tail 1>/dev/null 2>/dev/null; then
		tail -r -- "$@"
	else
		exit_system_file_message "Neither tac nor tail -r is on the PATH"
	fi
}

command_sha512sum()
{
	local file_path="$1"
	
	# BusyBox, GNU
	if command -v sha512sum 1>/dev/null 2>/dev/null; then
		sha512sum --binary "$file_path"
	# Mac OS X
	elif command -v shasum 1>/dev/null 2>/dev/null; then
		shasum --algorithm 512 --binary "$file_path"
	else
		exit_system_file_message "Neither sha512sum nor shasum is on the PATH"
	fi
}

common_initialization()
{
	ensure_HOME_is_exported
	ensure_TERM_is_exported
	ensure_PATH_is_exported
}

common_initialization "$@"
