# LAMW Manager Releases Notes
This page contains information about new features and bug fixes.

Latest
---

### v0.3.1.10-beta ###

**News**
+ Prepare experimental support to 16 KB pages

v0.3.1.9, Feb, 2023
---
**News**
+	Upgrade Lazarus from 2.0.12 to 3.8

v0.3.1 Fixes, 2023
---
**Fixes**
+	 Get JDK requerement by *package.json*
+	**Warning:** from now on *lamw_manager_setup.exe* from [*raw download*](https://github.com/dosza/LAMWManager-win/tree/master/lamw_manager/lamw_manager_setup.exe) will not be available!

v0.3.1.6-beta - Feb 22, 2022
---
**Fixes**
+	Fix select branch bug in *git clone lazarus* 
+	Update *Getting Started.txt*

v0.3.1 Fixes, 2021
---
**News**
+	Get JDK8 by Zulu
+	Get LAMW/Android minimum requerement by [*package.json*](https://github.com/jmpessoa/lazandroidmodulewizard/blob/master/package.json) (backported from Linux)
+	News uses new *Android SDK Manager*
+	News implementation of *winCallfromPS*
+	Updates lazarus version, compiler, and FPC source code paths in ([PPC](https://wiki.lazarus.freepascal.org/Multiple_Lazarus)) *\$LAMW_IDE_HOME_CFG\\enviromentoptions.xml*
+	**New command:** *--update-lazarus* to upgrade Lazarus Sources from git
+	**Windows 8.1** is no longer supported by LAMW Manager,tests will only be done on windows 10 64 bit

**Fixed**
+	Remove deprecated code
+	Get FPC Sources from SourceForge (while FPC migrates to gitlab)
+	Remove Old LAMW4Windows Launcher
+	Dowgrade to lazarus 2.0.12

v0.3.1.1 - January, 2021
---
**FIXED:**
+	OpenJDK 8u282
+	Gradle 6.6.1
+	Android API 29
+	Android Build Tools 29.0.3


v0.3.1 Fixes - August 6, 2020
----
**FIXED**
+	Missing Android APIs
+	MSYS2 don't update

v0.3.1 - March, 25, 2020
---
**NEWS**
+	FPC 3.2.0 (beta)
+	Lazarus 2.0.6
+	Build Freepascal - 3.2.0 i386/Win32
+	Build Freepascal Cross-compile ARMv7(VFPv3)/Android
+	Build Freepascal Cross-compile ARM64/Android
+	Choose installation directory
+	**Windows 7 SP1** is no longer supported by LAMW Manager,tests will only be done on windows 8.1/10 64 bit

**FIXED**
+	Breakline Unix replaced to CRLF
+	Remove batch unnecessary calls