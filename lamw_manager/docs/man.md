**LAMW Manager v0.3.1.2 Manual**

**lamw_manager.bat**

1.	Open powershell as Admin
2.	Enter the folder you installed lamw_manager in (default folder is C:\lamw_manager):
	```powershell
		PS C:\> cd C:\lamw_manager
	```
3. Run lamw_manager.bat:

	```powershell
		PS C:\lamw_manager> .\lamw_manager.bat
	```


**Usage:**
<pre>					
<Strong>Syntax:</Strong>
.\lamw_manager.bat²
.\lamw_manager.bat³ 	<strong>[actions]</strong> <strong>[options]</strong> </pre>

<p>
<pre>
.\lamw_manager.bat    <strong>[action]</strong>                            <em>Description</em>
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
	.\lamw_manager.bat	<strong>--sdkmanager</strong>	<strong>[ARGS]</strong>
<Strong>Sample:</Strong>
	.\lamw_manager.bat	<strong>--sdkmanager</strong>	<strong>--list_installed</strong>
	</pre>
</p>

<p>
	<ol>
		<li>By default the installation waives the use of parameters, if LAMW is installed, it will only be updated!</li>
		<li>If it is already installed, just run the Android SDK Tools with [ARGS]</li>
	</ol>
</p>

**Note:**

**PS C:\\>** is the command prompt, equivalent to **$** or **#** on Unix/Linux


