# This file is part of reproducible-rust. It is subject to the license terms in the COPYRIGHT file found in the top-level directory of this distribution and at https://raw.githubusercontent.com/lemonrock/reproducible-rust/master/COPYRIGHT. No part of reproducible-rust, including this file, may be copied, modified, propagated, or distributed except according to the terms contained in the COPYRIGHT file.
# Copyright © 2021 The developers of reproducible-rust. See the COPYRIGHT file in the top-level directory of this distribution and at https://raw.githubusercontent.com/lemonrock/reproducible-rust/master/COPYRIGHT.


validate_architecture()
{
	case "$architecture" in
		
		aarch64)
			docker_platform='linux/arm64'
		;;
		
		riscv64)
			docker_platform='linux/riscv64'
		;;
		
		powerpc64|powerpc64le)
			architecture='powerpc64le'
			docker_platform='linux/ppc64le'
		;;
		
		s390x)
			docker_platform='linux/s390x'
		;;
		
		x86_64)
			docker_platform='linux/amd64'
		;;
		
		*)
			exit_configuration_message "Architecture $architecture is not supported"
		;;
		
	esac
}

depends mkdir
set_image_output_paths()
{
	image_output_folder_path="$output_folder_path"/image/"$image"/"$architecture"
	mkdir -m 0700 -p "$image_output_folder_path"
	
	output_image_identifier_file_path="$image_output_folder_path"/image_identifier.value
	if [ -e "$output_image_identifier_file_path" ]; then
		exit_if_existing_file_missing "$output_image_identifier_file_path"
	fi
	
	git_describe_file_path="$image_output_folder_path"/git_describe.value
	if [ -e "$git_describe_file_path" ]; then
		exit_if_existing_file_missing "$git_describe_file_path"
		
		if [ ! -e "$output_image_identifier_file_path" ]; then
			exit_configuration_message "Missing $output_image_identifier_file_path file but $git_describe_file_path is present"
		fi
	fi
}
