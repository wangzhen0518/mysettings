<#
 * FileName: Microsoft.PowerShell_profile.ps1
 * Author: 刘 鹏
 * Email: littleNewton6@outlook.com
 * Date: 2021, Aug. 21
 * Copyright: No copyright. You can use this code for anything with no warranty.
#>


#------------------------------- Import Modules BEGIN -------------------------------
# 引入 posh-git
Import-Module posh-git

# 引入 ps-read-line
Import-Module PSReadLine
Import-Module Dircolors

# 引入 oh-my-posh
oh-my-posh init pwsh --config "${env:POSH_THEMES_PATH}/my-theme.omp.json" | Invoke-Expression
# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/negligible.omp.json" | Invoke-Expression
# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/kali.omp.json" | Invoke-Expression
# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/hunk.omp.json" | Invoke-Expression
# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/honukai.omp.json" | Invoke-Expression

#------------------------------- Import Modules END   -------------------------------





#-------------------------------  Set Hot-keys BEGIN  -------------------------------
# 设置预测文本来源为历史记录
Set-PSReadLineOption -PredictionSource History

# 每次回溯输入历史，光标定位于输入内容末尾
Set-PSReadLineOption -HistorySearchCursorMovesToEnd

# 设置 Tab 为菜单补全和 Intellisense
Set-PSReadLineKeyHandler -Key "Tab" -Function MenuComplete

# 设置 Ctrl+d 为退出 PowerShell
Set-PSReadlineKeyHandler -Key "Ctrl+d" -Function ViExit

# 设置 Ctrl+z 为撤销
Set-PSReadLineKeyHandler -Key "Ctrl+z" -Function Undo

# 设置向上键为后向搜索历史记录
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward

# 设置向下键为前向搜索历史纪录
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
#-------------------------------  Set Hot-keys END    -------------------------------





#-------------------------------    Functions BEGIN   -------------------------------
# Python 直接执行
# $env:PATHEXT += ";.py"

# 更新系统组件
# function Update-Packages {
# 	# update pip
# 	Write-Host "Step 1: 更新 pip" -ForegroundColor Magenta -BackgroundColor Cyan
# 	$a = pip list --outdated
# 	$num_package = $a.Length - 2
# 	for ($i = 0; $i -lt $num_package; $i++) {
# 		$tmp = ($a[2 + $i].Split(" "))[0]
# 		pip install -U $tmp
# 	}

	# update TeX Live
	#$CurrentYear = Get-Date -Format yyyy
	#Write-Host "Step 2: 更新 TeX Live" $CurrentYear -ForegroundColor Magenta -BackgroundColor Cyan
	#tlmgr update --self
	#tlmgr update --all

	# update Chocolotey
	#Write-Host "Step 3: 更新 Chocolatey" -ForegroundColor Magenta -BackgroundColor Cyan
	#choco outdated
# }
#-------------------------------    Functions END     -------------------------------





#-------------------------------   Set Alias BEGIN    -------------------------------
# 1. 编译函数 make
# function MakeThings {
# 	nmake.exe $args -nologo
# }
#Set-Alias -Name make -Value MakeThings
#Set-Alias -Name python3 -Value python

# 2. 更新系统 os-update
# Set-Alias -Name os-update -Value Update-Packages

# 3. 查看目录 ls & ll
#function ListDirectory {
#	(Get-ChildItem).Name
#	Write-Host("")
#}
#Set-Alias -Name ls -Value ListDirectory
Set-Alias -Name ll -Value Get-ChildItem
#Set-Alias -Name rm -Value Remove-Item
Set-Alias -Name touch -Value New-Item

# 4. 打开当前工作目录
# function OpenCurrentFolder {
# 	param
# 	(
		# 输入要打开的路径
		# 用法示例：open C:\
		# 默认路径：当前工作文件夹
# 		$Path = '.'
# 	)
# 	Invoke-Item $Path
# }
# Set-Alias -Name open -Value OpenCurrentFolder
#-------------------------------    Set Alias END     -------------------------------


#-------------------------------    Set Scoop BEGIN     -----------------------------
Invoke-Expression (&scoop-search --hook)
#-------------------------------    Set Scoop END     -------------------------------


#-------------------------------   Set Conda BEGIN    -------------------------------
#region conda initialize
# !! Contents within this block are managed by 'conda init' !!
#(& "D:\Developer\miniconda3\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | Invoke-Expression
#endregion

#conda activate ml
#conda deactivate
#-------------------------------   Set Conda END  ----------------------------------

#-------------------------------   Set Network BEGIN    -------------------------------
function proxy_on {
	$env:HTTP_PROXY="http://127.0.0.1:10809"
	$env:HTTPS_PROXY="https://127.0.0.1:10809"
	#set HTTP_PROXY="http://127.0.0.1:10809"
	#set HTTPS_PROXY="https://127.0.0.1:10809"
	#SetEnvironmentVariable("HTTP_PROXY", "http://127.0.0.1:10809", "User")
	#SetEnvironmentVariable("HTTPS_PROXY", "https://127.0.0.1:10809", "User")
}
function proxy_off{
	$env:HTTP_PROXY=""
	$env:HTTPS_PROXY=""
	#set HTTP_PROXY=
	#set HTTPS_PROXY=
	#SetEnvironmentVariable("HTTP_PROXY", $null, "User")
	#SetEnvironmentVariable("HTTPS_PROXY", $null, "User")
}

function ssh-copy-id([string]$userAtMachine, $args){   
    $publicKey = "$ENV:USERPROFILE" + "/.ssh/id_rsa.pub"
    if (!(Test-Path "$publicKey")){
        Write-Error "ERROR: failed to open ID file '$publicKey': No such file"            
    }
    else {
        & cat "$publicKey" | ssh $args $userAtMachine "umask 077; test -d .ssh || mkdir .ssh ; cat >> .ssh/authorized_keys || exit 1"      
    }
}

function my_port_forward{
    echo $args[0]
    ssh -L $args[0]:localhost:$args[0] -p 33111 zhenwang@202.38.69.241

}

Set MIRA "zhenwang@202.38.69.241:~/Downloads"

#-------------------------------   Set Network END  ----------------------------------

