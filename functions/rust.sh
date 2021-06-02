# This file is part of reproducible-rust. It is subject to the license terms in the COPYRIGHT file found in the top-level directory of this distribution and at https://raw.githubusercontent.com/lemonrock/reproducible-rust/master/COPYRIGHT. No part of reproducible-rust, including this file, may be copied, modified, propagated, or distributed except according to the terms contained in the COPYRIGHT file.
# Copyright © 2021 The developers of reproducible-rust. See the COPYRIGHT file in the top-level directory of this distribution and at https://raw.githubusercontent.com/lemonrock/reproducible-rust/master/COPYRIGHT.


fixed_configuration()
{
	distribution_server=static.rust-lang.org
	distribution_root_folder=dist
}

depends mkdir
set_download_rust_paths()
{
	local root_path="$1"
	
	configuration_folder_path="$root_path"/configuration
	exit_if_folder_missing "$configuration_folder_path"

	download_folder_path="$root_path"/downloads
	mkdir -m 0700 -p "$download_folder_path"
}

depends head
get_rustup_version()
{
	local rustup_version_file_path="$configuration_folder_path"/rustup-version
	
	rustup_version="$(head -n 1 "$rustup_version_file_path")"
	exit_if_configuration_file_missing "$rustup_version_file_path"
}

rust_common_initialize()
{
	local root_path="$1"
	
	fixed_configuration

	set_download_rust_paths "$root_path"

	get_rustup_version
}
