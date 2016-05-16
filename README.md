FFS
===

__FFS__, which stands for: '<b>F</b>or <b>F</b>@%k's <b>S</b>ake, IT'S CALLED A __MODULE__!!'
is a convenient repackaging of the EDK2's `GenSec` and `GenFfs` utilities, with the aim of
easing up the generation of what intel/EDK calls `FFS`'s (whatever that abbreviation means)
which are __MODULES__, that can be integrated into a regular UEFI firmware.

This can be useful if, for instance, you have UEFI driver executables, which you
want to make available in your UEFI "BIOS".

## License

[BSD 2-Clause](https://opensource.org/licenses/bsd-license.php), as per the EDK2.

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

## A brief breakdown of UEFI firmware __MODULES__

An UEFI firmware driver module (FFS) should be composed of the following:

* An FFS header
* A PE32 section containing the driver EFI executable
* A Driver Name ("User Interface") section
* A driver Version section

In practice, this could appear as follows:

```
Address Size  Designation
------- ----  -----------

EFI_FFS_FILE_HEADER:
0x0000  16    Name (EFI_GUID)
0x0010  1     IntegrityCheck.Header (Header Checksum)
0x0011  1     IntegrityCheck.File -> set to 0xAA (FFS_FIXED_CHECKSUM) and clear bit 0x40 of Attributes
0x0012  1     FileType -> 0x07 = EFI_FV_FILETYPE_DRIVER
0x0013  1     Attributes -> 0x00
0x0014  3     Size, including header and all other sections
0x0017  1     State (unused) -> 0X00

EFI_COMMON_SECTION_HEADER:
0x0000  3     Size, including this header
0x0003  1     Type -> 0x10 (EFI_SECTION_PE32)
0x0004  ####  <PE data>

EFI_COMMON_SECTION_HEADER:
0x0000  3     Size, including this header
0x0003  1     Type -> 0x15 (EFI_SECTION_USER_INTERFACE)
0x0004  ####  NUL terminated UTF-16 string (eg "FAT\0")

EFI_COMMON_SECTION_HEADER:
0x0000  3     Size, including this header
0x0003  1     Type -> 0x14 (EFI_SECTION_VERSION)
0x0004  ####  NUL terminated UTF-16 string (eg "1.0\0")
```

## Creating a driver UEFI firmware __MODULE__

From what was exposed above, and starting with an `ntfs_x64.efi` driver executable, the generation of
the relevant UEFI driver firmware __MODULE__ can be accomplished as follows (NB: you'll need to replace
the `1234...` GUID with your own):

```
GenSec -o pe32.sec ntfs_x64.efi -S EFI_SECTION_PE32
GenSec -o name.sec -S EFI_SECTION_USER_INTERFACE -n "NTFS"
GenSec -o ver.sec -S EFI_SECTION_VERSION -n "1.0"

GenFfs -d 1 -g "12341234-1234-1234-1234-123412341234" -o ntfs.ffs -i pe32.sec -i name.sec -i ver.sec -t EFI_FV_FILETYPE_DRIVER
```

Or you can also use the `GenMod` batch file under `Scripts`, which takes the driver executable and an optional GUID as parameters.