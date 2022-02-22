LAMW Manager - Windows Port
===

### v0.3.1.6-beta ###

LAMW Manager is a command line tool to automate the **installation**, **configuration** and **upgrade** the framework<br/>[LAMW - Lazarus Android Module Wizard](https://github.com/jmpessoa/lazandroidmodulewizard)

What do you get?
---
A [Lazarus IDE ](http://www.lazarus-ide.org) ready to develop applications for Android !!

Linux user, please, get here [*LAMW Manager for Linux*](https://github.com/dosza/LAMWManager-linux)

LAMW Manager install the following tools and dependencies:
---

+	Third Part Tools¹
	+	Chocolatey Package Manager
		+	Msys2
+	Freepascal Compiler
	+	Build FPC **ARMv7/Android**
	+	Build FPC **AARCH64/Android**
+	Lazarus IDE
+	Android NDK
+	Android SDK
+	Android Platform API²
	+	Android Platform Tools²
	+ 	Android Build Tools
	+	Android Extras
		+	Android M2Repository
		+	Android APK Expansion
		+	Android Market License (Client Library)
		+	Google Play Services
+	Apache Ant
+	Gradle
+	LAMW framework
+	OpenJDK

**Notes**
1. LAMW Manager dependencies, read [*Third Part Tools*](https://github.com/dosza/LAMWManager-win/blob/master/lamw_manager/docs/third_party.md)
2. The minimum Android API and Build Tools required by LAMW and specified in [*package.json*](https://github.com/jmpessoa/lazandroidmodulewizard/blob/master/package.json) are installed 

Windows Supported
---
+	Windows 10

**Note:** LAMW Manager only supports **Windows 64 bits**.

Getting Started!
---
#### How to use LAMW Manager: ####

1)	First read this [*README.md*](https://github.com/dosza/LAMWManager-win) and [*Third Part Tools*](https://github.com/dosza/LAMWManager-win/blob/master/lamw_manager/docs/third_party.md) to understand the operation and limitations of this tool.
2)	Disable your antivirus(temporarily)
3)	[Click here to download *LAMW Manager Setup* ](https://raw.githubusercontent.com/dosza/LAMWManager-win/master/lamw_manager/lamw_manager_setup.exe) 
4)	Double-click to run **lamw_manager_setup.exe**
5)  If the *Windows Protected Your PC* dialog box appears
	1)	Click on *more information...*
	2)	Check *I understand the Risks and want to run this app*
	3)	Click on *run anyway* 
6)	Accept permission to run *lamw_manager_setup.exe* as *Admin*
7)  Select the destination folder for *lamw_manager* by clicking the *Browse...* 
8)	Click in *Next*, *Next*...
9)	Still check *Launch LAMW Manager* and click in *finish*
10) Wait *lamw_manager* install LAMW environment


**Note**: By default lamw_manager is installed in C:\lamw_manager !!


#### How to update LAMW Framework ####

1. Go to Powershell and open as Admin 
2. Go to lamw_manager install folder with command:
	```powershell
	cd c:\lamw_manager
	```
3. Run:
	```powershell
	.\lamw_manager.bat
	```
#### Upgrading all LAMW environment ####

If LAMW requires new Android APIs or new Gradle version, you must run [*lamw_manager_setup.exe*](https://raw.githubusercontent.com/dosza/LAMWManager-win/master/lamw_manager/lamw_manager_setup.exe) again

Read the [*Getting Started*](#getting-started)


Know Issues
---

#### Cannot Build LAMW Demos ####

By default LAMW Manager uses (Android) Crosscompile to **ARMv7+vFPV3**, but [*LAMW Demos*](https://github.com/jmpessoa/lazandroidmodulewizard/tree/master/demos) uses **ARMV6+Cfsoft**, you need apply this configuration:
1.	Open your LAMW Demo with LAMW4Windows
2.	On menu bar go to Project --> Project Options ... --> [LAMW] Android Project Options --> Build --> Chipset --> ARMV7a+FVPv3

#### LAMW Manager stills in same point for long time... ####
This error is not related to LAMW Manager, but to the windows command prompt.The [*Quick Edition*](https://stackoverflow.com/questions/13599822/command-prompt-gets-stuck-and-continues-on-enter-key-press) mode pauses the screen to copy the content to the clipboard. To continue LAMW install, follow this steps:
1. Check title of prompt command starts with: **Selected**
2. If the prompt title starts with **Selected**, press Enter to continue the process 

Releases Notes
---
For information on new features and bug fixes read the [*Release Notes*](https://github.com/dosza/LAMWManager-win/blob/v0.3.1/lamw_manager/docs/releases_notes.md#v0316-beta---feb-22-2022)

Congratulations!
---
You are now a Lazarus for Android developer!<br/>[Building Android application with **LAMW** is **RAD**](https://drive.google.com/open?id=1CeDDpuDfRwYrKpN7VHbossH6GfZUfqjm)<br/>

More information read [**LAMW Manager v0.3.1 Manual**](https://github.com/dosza/LAMWManager-win/blob/v0.3.1/lamw_manager/docs/man.md)

By Daniel Oliveira
