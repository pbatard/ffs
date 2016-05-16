@echo off
setlocal enableextensions

set VERSION=0.9
set FILENAME=%~n1

rem *** Isolate the driver name e.g. "ntfs_x64.efi" -> "ntfs"
for /F "tokens=1,3 delims=_ " %%a in ("%FILENAME%") do set NAME=%%a

rem *** Capitalize the first letter of the driver name e.g. "ntfs" -> "Ntfs"
set L=%NAME:~0,1%
set MAP=a-A;b-B;c-C;d-D;e-E;f-F;g-G;h-H;i-I;j-J;k-K;l-L;m-M;n-N;o-O;p-P;q-Q;r-R;s-S;t-T;u-U;v-V;w-W;x-X;y-Y;z-Z
call set L=%%MAP:*%L%-=%%
SET L=%L:;=&rem.%
set NAME=%L%%NAME:~1%

rem *** Create a new GUID
echo set obj = CreateObject("Scriptlet.TypeLib") > genguid.vbs
echo WScript.StdOut.WriteLine Replace(Replace(obj.GUID,"{",""),"}","") >> genguid.vbs
for /f %%a in ('cscript //nologo genguid.vbs') do set "GUID=%%a"
del genguid.vbs

rem *** Create 3 sections: PE32, driver name (UI) and driver version
gensec -o pe32.sec %1 -S EFI_SECTION_PE32
gensec -o name.sec -S EFI_SECTION_USER_INTERFACE -n %NAME%
gensec -o ver.sec -S EFI_SECTION_VERSION -n %VERSION%

rem *** Combine all the sections into a driver module
genffs -d 1 -g %GUID% -o %FILENAME%.ffs -i pe32.sec -i name.sec -i ver.sec -t EFI_FV_FILETYPE_DRIVER
