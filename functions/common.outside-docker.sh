# This file is part of reproducible-rust. It is subject to the license terms in the COPYRIGHT file found in the top-level directory of this distribution and at https://raw.githubusercontent.com/lemonrock/reproducible-rust/master/COPYRIGHT. No part of reproducible-rust, including this file, may be copied, modified, propagated, or distributed except according to the terms contained in the COPYRIGHT file.
# Copyright © 2021 The developers of reproducible-rust. See the COPYRIGHT file in the top-level directory of this distribution and at https://raw.githubusercontent.com/lemonrock/reproducible-rust/master/COPYRIGHT.


set_paths()
{
	source_folder_path="$(pwd)"/source
	exit_if_folder_missing "$source_folder_path"
	
	output_folder_path="$(pwd)"/output
	
	temporary_folder_path="$(pwd)"/temporary
}
