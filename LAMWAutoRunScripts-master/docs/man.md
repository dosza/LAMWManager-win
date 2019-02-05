<pre>					<Strong>Syntax:</Strong>
bash simple-lamw-install.sh¹
bash simple-lamw-install.sh² 	<strong>[actions]</strong>    [options]
</pre>
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
