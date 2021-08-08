**LAMW Manager v0.3.1.1 Manual**


**commands:**
<p>
	<ul>
		<li>lamw_manager.bat</li>
	</ul>
</p>


</pre>

**Installed by LAMW Manager Setup¹**

<ol>
	<li> Open cmd or powershell as Admin</li>
</ol>




**Usage:**
<pre>					
<Strong>Syntax:</Strong>
lamw_manager.bat²
lamw_manager.bat³ 	<strong>[actions]</strong> <strong>[options]</strong> </pre>

<p>
<pre>
lamw_manager.bat    <strong>[action]</strong>                            <em>Description</em>
						   		Install LAMW and dependencies
			<strong>--sdkmanager	[ARGS]</strong>               Run Android SDK Manager 
			<strong>--update-lamw</strong>              	     	Update LAMW sources and rebuild Lazarus IDE
			<strong>--reset</strong>			     	Clean and Install LAMW
			<strong>uninstall</strong>                 	 	Uninstall LAMW completely and erase all settings.
			<strong>--help</strong>                 	   	Show help
	</pre>
</p>

**ANDROID SDK MANAGER**

<p>
	<pre>					<Strong>Syntax:</Strong>
	lamw_manager.bat	<strong>--sdkmanager</strong>	<strong>[ARGS]</strong>
<Strong>Sample:</Strong>
	lamw_manager.bat	<strong>--sdkmanager</strong>	<strong>--list_installed</strong>
	</pre>
</p>

<p>
	<ol>
		<li>By default the installation waives the use of parameters, if LAMW is installed, it will only be updated!</li>
		<li>If it is already installed, just run the Android SDK Tools with [ARGS]</li>
	</ol>
</p>

