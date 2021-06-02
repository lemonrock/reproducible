# This file is part of reproducible-rust. It is subject to the license terms in the COPYRIGHT file found in the top-level directory of this distribution and at https://raw.githubusercontent.com/lemonrock/reproducible-rust/master/COPYRIGHT. No part of reproducible-rust, including this file, may be copied, modified, propagated, or distributed except according to the terms contained in the COPYRIGHT file.
# Copyright © 2021 The developers of reproducible-rust. See the COPYRIGHT file in the top-level directory of this distribution and at https://raw.githubusercontent.com/lemonrock/reproducible-rust/master/COPYRIGHT.


convert_target_platform()
{
	case "$TARGETPLATFORM" in

		'linux/amd64')
			architecture='x86_64'
		;;
		
		'linux/arm64')
			architecture='aarch64'
		;;
	
		'linux/riscv64')
			architecture='riscv64'
		;;
	
		'linux/ppc64le')
			architecture='powerpc64le'
		;;
	
		'linux/s390x')
			architecture='s390x'
		;;
		
		*)
			exit_configuration_message "Unsupported TARGETPLATFORM $TARGETPLATFORM"
		;;
		
	esac
}
