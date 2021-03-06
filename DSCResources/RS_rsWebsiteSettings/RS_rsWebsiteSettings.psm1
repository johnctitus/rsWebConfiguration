Import-Module WebAdministration

function Get-TargetResource
{
	[CmdletBinding()]
	[OutputType([System.Collections.Hashtable])]
	param
	(
		[parameter(Mandatory = $true)]
		[System.String]
		$SiteName,

		[System.String]
		$LogPath
	)

	#Write-Verbose "Use this cmdlet to deliver information about command processing."

	#Write-Debug "Use this cmdlet to write debug information while troubleshooting."


	$configuration = @{
	SiteName = $SiteName
	LogPath = $LogPath
	}
	
	return $configurationon
}


function Set-TargetResource
{
	[CmdletBinding()]
	param
	(
		[parameter(Mandatory = $true)]
		[System.String]
		$SiteName,

		[System.String]
		$LogPath
	)
	
	if(!(Test-Path "IIS:\Sites\$SiteName")){
		return
	}
	
	if(!(Test-Path $LogPath)){
		New-Item $LogPath -Type Directory
	}
	
	if((Get-ItemProperty "IIS:\Sites\$SiteName" -name logfile.directory.Value) -ne $LogPath){
		Set-ItemProperty "IIS:\Sites\$SiteName" -name logfile.directory -value $LogPath
	}
		
}


function Test-TargetResource
{
	[CmdletBinding()]
	[OutputType([System.Boolean])]
	param
	(
		[parameter(Mandatory = $true)]
		[System.String]
		$SiteName,

		[System.String]
		$LogPath
	)
	
	
	if((Get-ItemProperty "IIS:\Sites\$SiteName" -Name logfile.directory.Value) -ne $LogPath){
		return $false
	}

    if(!(Test-Path $LogPath)){
		return $false
	}
		
	else{
		return $true
	}
}


Export-ModuleMember -Function *-TargetResource

