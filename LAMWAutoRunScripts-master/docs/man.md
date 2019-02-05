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
	<strong>uninstall</strong>                           Uninstall LAMW completely and erase all settings.
	<strong>--sdkmanager</strong>                        Run Android SDK Manager 
	<strong>--update-lamw</strong>                       Update LAMW sources and rebuild Lazarus IDE
	</pre>
	<strong>Note:</strong>The <em>default option</em> is <strong><em>Android SDK Tools r25.2.5</em></strong>
</p>


<pre> <strong>sample:</strong>	lamw_manager install	<strong>--use-proxy	--server</strong> <em>10.0.16.1</em>	<strong>--port</strong>	<em>3128</em> </pre>
**commands:**
<p>
	<ul>
		<li>preinstall-win32.bat</li>
		<li>preinstall-win64.bat</li>
		<li>lamw_manager.bat</li>
		<li>bash simple-lamw-install.sh**</li>
	</ul>
</p>

<strong>Example Advanced of installation:</strong>
<pre>
Get and Run setup.exe  in <a href="https://raw.githubusercontent.com/DanielTimelord/Laz4LAMW-win-installer/master/LAMWAutoRunScripts-master/setup.exe">Clich Here to get Setup</a>
Open  a powershell as administrator.
<br>Open directory with command "cd c:\lamw_manager"</br>
To install LAMW completely the <strong>first time</strong> with <strong><em>default option</em></strong>:
	<strong>bash simple-lamw-install.sh</strong>
<br>To fully update LAMW <strong>after</strong> the <em>first installation</em>:</br>
	<strong>bash simple-lamw-install.sh</strong>
<br>To just upgrade <strong>LAMW framework</strong> <em>(with the latest version available in git)</em></br>
	<strong>bash simple-lamw-install.sh</strong>        <em>update_lamw</em>

</pre>
**Usage:**
<pre>					<Strong>Syntax:</Strong>
bash simple-lamw-install.sh¹
bash simple-lamw-install.shr² 	<strong>[actions]</strong>         <strong>[options]</strong>  
</pre>

<p>
bash simple-lamw-install.sh                                     
	<pre>
	<strong>[action]</strong>                            <em>Description</em>
	<strong>uninstall</strong>                           Uninstall LAMW completely and erase all settings.
	<strong>--sdkmanager</strong>                        Run Android SDK Manager 
	<strong>--update-lamw</strong>                       Update LAMW sources and rebuild Lazarus IDE
	</pre>
</p>

**proxy options:**
<p>
	<pre>
	<em>actions</em>    <strong>--use-proxy</strong> 		<em>[proxy options]</em>
	<strong>sample:</strong>bash simple-lamw-install.sh    <em>--sdkmanager</em>    <strong>--use-proxy --server</strong>	<em>[HOST]</em> <strong>--port</strong> 	<em>[NUMBER]</em>
</pre>
</p>

<pre> <strong>sample:</strong>	simple-lamw-install.sh <strong>--use-proxy	--server</strong> <em>10.0.16.1</em>	<strong>--port</strong>	<em>3128</em> </pre>


¹<strong>New!
Implied action</strong>:
<em>When using the <strong>bash simple-lamw-install.sh</strong> command <strong>without parameters </strong>, LAMW Manager installs the default LAMW environment in other cases LAMW Manager <strong>only</strong> installs updates.</em>


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
