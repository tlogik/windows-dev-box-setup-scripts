# Description: Boxstarter Script
# Author: Microsoft
# Common dev settings for desktop app development

Disable-UAC

# Get the base URI path from the ScriptToCall value
$bstrappackage = "-bootstrapPackage"
$helperUri = $Boxstarter['ScriptToCall']
$strpos = $helperUri.IndexOf($bstrappackage)
$helperUri = $helperUri.Substring($strpos + $bstrappackage.Length)
$helperUri = $helperUri.TrimStart("'", " ")
$helperUri = $helperUri.TrimEnd("'", " ")
$helperUri = $helperUri.Substring(0, $helperUri.LastIndexOf("/"))
$helperUri += "/scripts"
write-host "helper script base URI is $helperUri"

function executeScript {
    Param ([string]$script)
    write-host "executing $helperUri/$script ..."
	iex ((new-object net.webclient).DownloadString("$helperUri/$script"))
}

#--- Setting up Windows ---
#executeScript "SystemConfiguration.ps1";
#executeScript "FileExplorerSettings.ps1";
#executeScript "RemoveDefaultApps.ps1";
#executeScript "CommonDevTools.ps1";
#executeScript "Browsers.ps1";
#executeScript "NetDeveloperCommonTools.ps1";

executeScript "WSL.ps1";
RefreshEnv
executeScript "Docker.ps1";

choco install -y powershell-core
choco install -y azure-cli
Install-Module -Force Az
choco install -y microsoftazurestorageexplorer
choco install -y azure-data-studio
choco install -y sql-server-management-studio



#--- Tools ---
#--- Installing VS and VS Code with Git
choco install -y visualstudio2019enterprise --package-parameters="'--add Microsoft.VisualStudio.Component.Git'"
Update-SessionEnvironment #refreshing env due to Git install

#--- UWP Workload and installing Windows Template Studio ---
choco install -y visualstudio2019-workload-azure

#-- VARIOUS --
choco install -y kdiff3
choco install -y gitextensions
choco install -y zoom
choco install -y adobereader
choco insatall -y dashlane

#-- CHAT --
choco install -y microsoft-teams
choco install -y slack

#-- LENOVO STUFF --
choco install -y lenovo-thinkvantage-system-update


#--- reenabling critial items ---
Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
