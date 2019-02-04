# **LAMW Manager v0.3.0**

LAMW Manager is  **"APT"** to LAMW framework
LAMW Manager is powerfull   command line tool like *APT* to install, configure and Update LAMW Framework IDE
to distro linux like *GNU/debian* or *Windows 7 SP1/8.1/10*


**This tool make:**
<ul>
	<li>Get Apache Ant</li>
	<li>Get Gradle</li>
	<li>Get Freepascal Compiler</li>
	<li>Get Lazarus IDE Sources</li>
	<li>Get Android NDK</li>
	<li>Get Android SDK</li>
	<li>Get OpenJDK</li>
	<li>Get LAMW framework</li>
	<li>Build Freepascal Cross-compile to <strong>arm-android</strong></li>
	<li>Build Lazarus IDE</li>
	<li>Install LAMW framework</li>
	<li>Create launcher to menu</li>
	<li>Register <strong>MIME</strong> </li>
</ul>


**Windows Supported (32 e 64 bit):**

<ul>
	<li>Windows 7</li>
	<li>Windows 8.1</li>
	<li>Windows 10</li>
</ul>		

**Requerements:**
<p>
	You must <strong>first install</strong> Laz4Android available: <a href="https://ufpr.dl.sourceforge.net/project/laz4android/laz4android1.8.0-FPC3.0.4.exe"> Laz4Android</a> 
	<br>And <strong>install in c: \ laz4android1.8</strong></br>
</p>

**Windows 7 Requeriments**
<p>
	<strong>Note:</strong> Extended windows 7 support will end on January 14, 2020
	<ol>
	<li>Windows 7 Service Pack 1 (avaliable in Windows Update)</li>
	<li>PowerShell v3.0  <a href="https://www.microsoft.com/en-us/download/details.aspx?id=34595">  Click here to Download of Windows Management Framework 3.0 </a>
	<pre>
		If windows architecture is 64 bit mark: Windows6.1-KB2506143-x64.msu and click next to download file
		If windows architecture is 32 bit mark: Windows6.1-KB2506143-x86.msu and click next to download file
	</pre>
	<li>Install Microsoft .Net Framework v4+  : <a href="https://dotnet.microsoft.com/download/thank-you/net472"> Click here to Download  .Net Framework 4.7.2</a>
	</ol>
</p>


**commands:**
<p>
	<ul>
		<li>preinstall-win32.bat</li>
		<li>preinstall-win64.bat</li>
		<li>lamw_manager.bat</li>
		<li>bash simple-lamw-install.sh**</li>
	</ul>
</p>
*Note: you need run this tool without root privileges!*


<p>
	<strong>Simple Example of Standard Installation (with Android SDK Tools r25.2.5)</strong>
	<ol>
	<li>Get and Run setup.exe <a href="https://raw.githubusercontent.com/DanielTimelord/Laz4LAMW-win-installer/master/LAMWAutoRunScripts-master/setup.exe">Click here to Download of LAMW Manager Win Installer</a></li>
	<li>Open  with explorer.exe c:\lamw_manager </li>
	<li>right-click on lamw_manager.bat</li>
	<li>Then click Run as administrator</li>
	</ol>
	<strong>Note:</strong>To update LAMW simply redo the steps: 2,3 and 4!
	<br><strong>Note:</strong>Read the requesitos section!</br>
	<br><strong>Warning:</strong>Windows 7 has specific requirements, read the requirements section of windows 7</br>
</p>

<strong>Example Advanced of installation:</strong>
<pre>
	Run setup.exe avaliable in yourpath\LazLazlAMW-Win-Installer\LAMWAutoRunScripts or in <a href="https://raw.githubusercontent.com/DanielTimelord/Laz4LAMW-win-installer/master/LAMWAutoRunScripts-master/setup.exe">Setup</a>
To install LAMW completely the <strong>first time</strong> with <strong><em>default option</em></strong>:
	<strong>bash simple-lamw-install.sh</strong>
			or:
	<strong>bash simple-lamw-install.sh</strong>        <em>install_default</em>

<br>To install LAMW completely the <strong>first time</strong> with <strong><em>Android SDK Tools r26.1.1:</em></strong></br>
	<strong>bash simple-lamw-install.sh</strong>       <em>install</em>
<br>To fully update LAMW <strong>after</strong> the <em>first installation</em>:</br>
	<strong>bash simple-lamw-install.sh</strong>
<br>To just upgrade <strong>LAMW framework</strong> <em>(with the latest version available in git)</em></br>
	<strong>bash simple-lamw-install.sh</strong>        <em>update_lamw</em>

</pre>
<pre>					<Strong>Syntax:</Strong>
bash simple-lamw-install.sh¹
bash simple-lamw-install.sh² 	<strong>[actions]</strong>    [options]
</pre>
</p>
**Usage:**

<p>
bash simple-lamw-install.sh
	<pre>
	<strong>[action]</strong>                            <em>Description</em>
	<strong>install</strong>                             Install lamw with <em>Android SDK Tools r26.1.1</em>
	<strong>install_default</strong>                     The first time, install LAMW with <strong>default option</strong>, in other cases only install updates.                                                   
	<strong>uninstall</strong>                           Uninstall LAMW completely and erase all settings.
	<strong>reinstall</strong>                           Clean and reinstall <em>LAMW IDE with Android SDK Tools r26.1.1</em>
	<strong>install-oldsdk</strong>                      Install lamw with <em>Android SDK Tools r25.2.5³ GUI</em>
	<strong>install_old_sdk</strong>                     Auto Install lamw with <strong><em>Android SDK Tools r25.2.5 CLI</em></strong>
	<strong>reinstall-oldsdk</strong>                    Clean and reinstall lamw with <em>Android SDK Tools r25.2.5</em>
	<strong>update-lamw</strong>                         Update LAMW sources and rebuild Lazarus IDE
	</pre>
	<strong>Note:</strong>The <em>default option</em> is <strong><em>Android SDK Tools r25.2.5</em></strong>
</p>

**proxy options:**
<p>
	<pre>
	<em>actions</em>    <strong>--use-proxy</strong> 		<em>[proxy options]</em>
	<em>install</em>    <strong>--use-proxy --server</strong>	<em>[HOST]</em> <strong>--port</strong> 	<em>[NUMBER]</em>
</pre>
</p>

<pre> <strong>sample:</strong>	simple-lamw-install.sh install	<strong>--use-proxy	--server</strong> <em>10.0.16.1</em>	<strong>--port</strong>	<em>3128</em> </pre>


¹<strong>New!
Implied action</strong>:
<em>When using the <strong>bash simple-lamw-install.sh</strong> command <strong>without parameters the first time</strong>, LAMW Manager installs the default LAMW environment (Android SDK Tools r25.2.5), in other cases LAMW Manager <strong>only</strong> installs updates.</em>


<p>
	<em>²An installable LAMW Manager package will be available in the future and the command simple-lamw-install.sh can be called independent of the current directory $PWD</em>
	<br><strong>³You need in Android SDK Tools Installer:</strong></br>
	<ul>
	<li>check "Android SDK Tools"</li>
	<li>check "Android SDK Platform-Tools"</li>			
	<li>check "Android SDK Build-Tools 26.0.2"</li>  	
	<li>go to "Android 8.0.0 (API 26)" and check only "SDK Platform"</li>
	<li>go to "Extras" and check:</li> 
	<li>		"Android Support Repository"</li>				
	<li>		"Android Support Library"</li>				
	<li>		"Google Repository"</li>
	<li>		"Google Play Services" </li>
	</ul>																
</p>
