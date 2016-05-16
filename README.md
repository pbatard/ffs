FFS
===

__FFS__, which stands for: '<b>F</b>or <b>F</b>@%k's <b>S</b>ake, IT'S CALLED A __MODULE__!!'
is a __convenient__ repackaging of the EDK2's `GenSec` and `GenFfs` utilities,
with the aim of easing up the generation of what intel/EDK calls `FFS`'s (whatever
that abbreviation means) which are __MODULES__, that can be integrated into a
regular UEFI firmware.

This can be useful if, for instance, you have UEFI driver executables, which you
want to make available in your UEFI "BIOS".

## License

BSD 2-Clause, as per the EDK2.

## Sources

The sources included in this project are all unmodified versions of the same files
from the [`BaseTools/Source/C/`](https://github.com/tianocore/edk2/tree/master/BaseTools/Source/C)
repository of the EDK2.

The only elements added are the Visual Studio 2015 project files (__much__ more convenient
than whatever the EDK2 wants you to set up for recompilation) and some useful scripts.

## Requirements

* [Visual Studio 2015](http://www.visualstudio.com/products/visual-studio-community-vs)

## Compilation

* Open the solution file in Visual Studio and select 'Build Solution'