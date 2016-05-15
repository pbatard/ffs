FFS
===

__FFS__, which stands for: '<b>F</b>or <b>F</b>@%k's <b>S</b>ake, IT'S A __MODULE__!!'
is a __convenient__ repackaging of the EDK2's `GenSec` and `GenFfs` utilities,
with the aim of easing up the generation of what intel/EDK calls `FFS`'s (whatever
that abbreviation means) which are __MODULES__ that can be integrated into a
regular UEFI firmware.

This can be useful if, for instance, you have UEFI driver executables, which you
want to make available in your UEFI "BIOS".

## License

BSD 2-Clause, as per the EDK2.

## Requirements

* [Visual Studio 2015](http://www.visualstudio.com/products/visual-studio-community-vs)

## Compilation

* Open the solution file in Visual Studio and select 'Build Solution'