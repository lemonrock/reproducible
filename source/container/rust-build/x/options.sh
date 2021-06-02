# This file is part of reproducible-rust. It is subject to the license terms in the COPYRIGHT file found in the top-level directory of this distribution and at https://raw.githubusercontent.com/lemonrock/reproducible-rust/master/COPYRIGHT. No part of reproducible-rust, including this file, may be copied, modified, propagated, or distributed except according to the terms contained in the COPYRIGHT file.
# Copyright © 2021 The developers of reproducible-rust. See the COPYRIGHT file in the top-level directory of this distribution and at https://raw.githubusercontent.com/lemonrock/reproducible-rust/master/COPYRIGHT.


main()
{
	local architecture="$1"
	local context="$2"
	local container="$3"
	local container_configuration_folder_path="$4"

	cat <<-EOF
		--attach stdout
		
		--attach stdin

		--attach stderr
		
		--cpus 1
	EOF
}

main "$@"
