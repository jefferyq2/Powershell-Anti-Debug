# Simple-AntiDebug PowerShell Script


## Features:
- **System Model Check**
- **BIOS Version Check**
- **GPU Check**
- **PortConnector Check**
- **Disk Drive Model Check**
- **User Folder Check**
- **vboxpostinstall.log Check**
- **Anti Analysis Program Protection = Shutdown**


## How to bypass
- All can be spoofed lmfao.. i might update it when i feel like it.. 😄 but it gotta have some stars ⭐ :)) y feel me like 
- Btw started on anti-analysis adding soon 🔒

## Anti-Analysis Program Protections:
The script includes protection against the following anti-analysis programs:
- `cmd`
- `taskmgr`
- `process`
- `processhacker`
- `ksdumper`
- `fiddler`
- `httpdebuggerui`
- `wireshark`
- `httpanalyzerv7`
- `decoder`
- `regedit`
- `procexp`
- `dnspy`
- `vboxservice`
- `burpsuit`
- `DbgX.Shell`
- `ILSpy`

**Note:** Attempting to kill Task Manager won't work until UAC Permissions (ADMIN). You can add UAC prompt functionality, and if the person chooses 'no,' prevent the script from running. Please don't use this script for malicious purposes. If you decide to use it, consider implementing a crypter like the one from Chainski on GitHub (AES ENCODER).

## To-do
- List of blacklisted UUIDs, PC Names, IP's, etc. (if I feel like it, I'll add it and it can be good.. and block VT Machines lmfao)


## Reason why i made this?
- I Never seen a good or simple powershell anti debug.. and since i make most of my times a powershell applications i want to protect them from debuggers, or deobfuscators such as ILSpy..
- And thats why i used most of my time.. Chainski's Obfuscator
- That doesnt mean it will protect from debuggers and windbg thats why i made this :)) but dw this will be better in future.

## Cool Repos to Checkout : 
- https://github.com/Chainski/AES-Encoder
- https://github.com/ChildrenOfYahweh/Powershell-Token-Grabber
- https://github.com/EvilBytecode/Batchfile-Token-Grabber-Evilbyte
