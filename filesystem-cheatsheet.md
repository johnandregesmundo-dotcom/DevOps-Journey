# Linux Filesystem Cheatsheet

## Important Directories

| Directory | Purpose | Tagalog Explanation |
|-----------|---------|---------------------|
| `/` | Root of the filesystem | Pinaka-ugat ng lahat. Walang nasa itaas nito. |
| `/etc` | Configuration files | Dito nakalagay ang configs ng system at apps (e.g., nginx.conf, ssh config). |
| `/var` | Variable data | Logs, cache, spool files. Lumalaki habang tumatakbo ang system. |
| `/home` | User home directories | Bahay ng mga users. `/home/juan`, `/home/maria`, etc. |
| `/tmp` | Temporary files | Nawawala pagka-reboot. Ginagamit ng apps para sa pansamantalang files. |
| `/usr` | User programs | Binaries, libraries, docs ng mga naka-install na programs. |
| `/bin` | Essential binaries | Core commands: `ls`, `cp`, `mv`, `cat`, etc. |
| `/sbin` | System binaries | Commands para sa system admin: `reboot`, `fdisk`, `iptables`. |
| `/proc` | Process information | Virtual filesystem. Hindi totoong files — info ng kernel at processes. |
| `/dev` | Device files | Kinakatawan ang hardware (e.g., `/dev/sda` = first disk). |
| `/opt` | Optional software | Manually installed apps (e.g., Google Chrome, custom tools). |
| `/boot` | Boot files | Kernel at bootloader (GRUB). HUWAG galawin. |

## Useful Commands for Exploring

```bash
cd /etc && ls -la
cd /var && ls
cat /proc/cpuinfo
cat /proc/meminfo
ls /bin | wc -l/           → Root (lahat nagsisimula dito)
├── etc/    → Settings ng system
├── var/    → Logs at dynamic data
├── home/   → Bahay ng users
├── tmp/    → Scratch space
├── usr/    → Programs
├── bin/    → Commands
├── proc/   → Live system info
└── dev/    → HardwarePush:
```bash
git add filesystem-cheatsheet.md
git commit -m "Day 2: Add filesystem cheatsheet"
git push


