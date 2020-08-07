Third Part Tools
===

<p>
	The installation of LAMW is challenging and the automation of this process requires the use of third party tools:
	<ol>
		<li><a href="https://chocolatey.org/">Chocolatey Package Manager</a>
			<ol>
				<li><a href="https://www.msys2.org">MSYS2</a></li>
			</ol>
		</li>
	</ol>
</p>

Why use third party tools?
---

<p>
	LAMW Manager is a command line tool originally designed for Linux and written in Shell script <a href="https://www.gnu.org/software/bash">(Bash)</a><br/>
	To make this tool compatible with Windows, the original scripts were adapted to run on MSYS2.<br/>
	MSYS2 provides utilities and libraries that allow the execution of UNIX / Linux commands.<br/>
	MSYS2 is automatically installed by Chocolatey Package Manager.
</p>

Notes
---

<p>
	<ol type="I">
		<li>Unfortunately, the <a href="https://chocolatey.org/docs/features-install-directory-override">free version</a> of Chocolatey Package Manager does not allow the choice of installation directory;</li>
		<li>By default, chocolatey is installed in $HOMEDRIVE/ProgramData/chocolatey;</li>
		<li>Items I, II will be resolved in a future version;</li>
		<li>MSYS2 is installed $HOMEDRIVE/tools/msys64 (for Windows 64 bits) or $HOMEDRIVE/tools/msys32 (for Windows 32 bit);</li>
		<li>$HOMEDRIVE (the famous C:\ drive) is a enviroment variable to  hardrive to root of <a href="https://support.microsoft.com/en-us/help/237566/homepath-homeshare-and-homedrive-variables-resolved-incorrectly">Microsoft Distributed File System (DFS)</a>.</li>
	</ol>
</p>