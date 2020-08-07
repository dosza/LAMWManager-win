**Third Part Tools**


<p>
	The installation of LAMW is challenging and the automation of this process requires the use of third party tools:
</p>

**Third Part Tools**
<ol>
	<li><a href="https://chocolatey.org/">Chocolatey Package Manager</a>
		<ol>
			<li><a href="https://www.msys2.org">MSYS2</a></li>
		</ol>
	</li>
</ol>

**Why use third party tools?**
Chocolatey Package Manager is used to install MSYS2.
LAMW Manager is a command line tool originally designed for Linux and written in shell script [\(BASH\)](https://www.gnu.org/software/bash)
To make this tool compatible with Windows, the original scripts were adapted to run on MSYS2.
MSYS2 provides utilities and libraries that allow the execution of UNIX / Linux commands.


**Notes**
I	Unfortunately, the [free version](https://chocolatey.org/docs/features-install-directory-override) of Chocolatey Package Manager does not allow the choice of installation directory;
II	By default, chocolatey is installed in $HOMEDRIVE/ProgramData/chocolatey;
III	Items I, II will be resolved in a future version.
MSYS2 is installed $HOMEDRIVE/tools/msys64 (for Windows 64 bits) or $HOMEDRIVE/tools/msys32 (for Windows 32 bit);
IV	$HOMEDRIVE is a enviroment variable to  hardrive to root of Microsoft Distributed File System [\(DFS\)](https://support.microsoft.com/en-us/help/237566/homepath-homeshare-and-homedrive-variables-resolved-incorrectly).