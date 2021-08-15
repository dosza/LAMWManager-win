# LAMW Manager Releases Notes
This page contains information about new features and bug fixes.

v0.3.1 Fixes - August, 2021
---
**News**
+	Get JDK8 by Zulu 
+	Lazarus Trunk
+	Get LAMW/Android minimum requerement by [*package.json*](https://github.com/jmpessoa/lazandroidmodulewizard/blob/master/package.json) (backported from Linux)
+	News uses new *Android SDK Manager*
+	News implementation of *winCallfromPS*
+	Updates lazarus version, compiler, and FPC source code paths in ([PPC](https://wiki.lazarus.freepascal.org/Multiple_Lazarus)) *\$LAMW_IDE_HOME_CFG\\enviromentoptions.xml*
+	**New command:** *--update-lazarus* to upgrade Lazarus Sources from git

**Fixed**
+	Remove deprecated code
+	Get FPC Sources from SourceForge (while FPC migrates to gitlab)
+	LAMW4Windows Launcher old data

v0.3.1.1 - January, 2021
---
<p>
	<strong>FIXED:</strong>
	<ul>
		<li>OpenJDK 8u282</li>
		<li>Gradle 6.6.1</li>
		<li>Android API 29</li>
		<li>Android Build Tools 29.0.3</li>
	</ul>
</p>

v0.3.1 Fixes - August 6, 2020
----
<p>
	<strong>FIXED</strong>
	<ul>
		<li>Missing Android APIs</li>
		<li>MSYS2 don't update</li>
	</ul>
</p>

v0.3.1 - March, 25, 2020
-----------------------------
<p>
	<strong>NEWS</strong>
	<ul>
		<li>FPC 3.2.0 (beta)</li>
		<li>Lazarus 2.0.6</li>
		<li>Build Freepascal - 3.2.0 i386/Win32</li>
		<li>Build Freepascal Cross-compile ARMv7(VFPv3)/Android</li>
		<li>Build Freepascal Cross-compile ARM64/Android</li>
		<li>Choose installation directory</li>
	</ul>
	<strong>FIXED</strong>
	<ul>
		<li>Breakline Unix replaced to CRLF</li>
		<li>Remove batch unnecessary calls</li>
	</ul>
</p>
