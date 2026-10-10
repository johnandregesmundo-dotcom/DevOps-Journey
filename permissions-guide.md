# 🔐 Linux File Permissions Guide

> A complete guide to understanding and mastering `chmod`, `chown`, and `chgrp` in Linux.

---

## 📖 Table of Contents
1. [Understanding Permissions (rwx)](#1-understanding-permissions-rwx)
2. [Numeric Values (4, 2, 1)](#2-numeric-values-4-2-1)
3. [Using chmod — Numeric Mode](#3-using-chmod--numeric-mode)
4. [Using chmod — Symbolic Mode](#4-using-chmod--symbolic-mode)
5. [Using chown and chgrp](#5-using-chown-and-chgrp)
6. [Best Practices](#6-best-practices)
7. [Quick Reference Cheat Sheet](#7-quick-reference-cheat-sheet)

---

## 1. Understanding Permissions (rwx)

When you run `ls -la`, you'll see something like this:
The first 10 characters break down like this:

| Position | Meaning |
|----------|---------|
| `-` (1st) | File type (`-` = file, `d` = directory, `l` = symlink) |
| `rwx` (2nd-4th) | **Owner** permissions |
| `r-x` (5th-7th) | **Group** permissions |
| `r--` (8th-10th) | **Others** permissions |

### What Each Permission Means

| Permission | Symbol | On a File | On a Directory |
|------------|--------|-----------|----------------|
| **Read** | `r` | View file contents (`cat`, `less`) | List directory contents (`ls`) |
| **Write** | `w` | Modify file contents (`echo`, `nano`) | Create/delete files inside |
| **Execute** | `x` | Run as program/script (`./script.sh`) | Enter directory (`cd`) |

> 💡 **Tip:** If a file has `r` but not `x`, you can read it but not run it. If a directory has `r` but not `x`, you can list files but not `cd` into it.

---

## 2. Numeric Values (4, 2, 1)

Each permission has a numeric value:

| Permission | Value |
|------------|-------|
| Read (`r`) | **4** |
| Write (`w`) | **2** |
| Execute (`x`) | **1** |
| No permission (`-`) | **0** |

You **add** these values to get a permission set:

| Sum | Permission | Symbol |
|-----|------------|--------|
| 0 | None | `---` |
| 1 | Execute only | `--x` |
| 2 | Write only | `-w-` |
| 3 | Write + Execute | `-wx` |
| 4 | Read only | `r--` |
| 5 | Read + Execute | `r-x` |
| 6 | Read + Write | `rw-` |
| 7 | Read + Write + Execute | `rwx` |

### Three-Digit Format

A permission like `644` means:

| Digit | Who | Value | Permission |
|-------|-----|-------|------------|
| 6 | Owner | 4+2 | `rw-` |
| 4 | Group | 4 | `r--` |
| 4 | Others | 4 | `r--` |

Result: `-rw-r--r--`

---

## 3. Using chmod — Numeric Mode

`chmod` (change mode) sets file permissions using numbers.

### Syntax
```bash
chmod [permissions] [file]
Common Examples
bash
# 644 — Owner: read+write, Group: read, Others: read
chmod 644 secret.txt

# 755 — Owner: full, Group: read+execute, Others: read+execute
chmod 755 myscript.sh

# 600 — Owner: read+write only (private file)
chmod 600 ~/.ssh/id_rsa

# 700 — Owner: full only (private directory)
chmod 700 ~/private-folder

# 777 — EVERYONE full access (⚠️ NEVER DO THIS)
chmod 777 dangerous.txtReal-World Use Cases
Permission	Use Case
644	Regular files, web content (HTML, CSS)
600	SSH keys, private config files
755	Executable scripts, directories
700	Private directories (.ssh, .gnupg)
775	Shared directories for a group
4. Using chmod — Symbolic Mode
Instead of numbers, you can use letters. This is useful for modifying permissions without resetting everything.

Syntax
bash
chmod [who][operator][permission] [file]
Who	Meaning
u	User (owner)
g	Group
o	Others
a	All (u+g+o)
Operator	Meaning
+	Add permission
-	Remove permission
=	Set exact permission
Examples
bash
# Add execute for the owner
chmod u+x myscript.sh

# Remove write for group
chmod g-w secret.txt

# Set others to read only (removes everything else)
chmod o=r secret.txt

# Add read for everyone
chmod a+r file.txt

# Remove all permissions for others
chmod o-rwx file.txt

# Multiple changes at once
chmod u+x,g-w,o-rwx file.txt
💡 Tip: Symbolic mode is great for tweaking permissions. Numeric mode is better for setting them from scratch.

5. Using chown and chgrp
chown — Change Owner
bash
# Change owner only
sudo chown root secret.txt

# Change owner and group at once
sudo chown root:root secret.txt

# Change owner back to you
sudo chown $USER:$USER secret.txt

# Change owner recursively (for directories)
sudo chown -R $USER:$USER ~/permissions-lab
chgrp — Change Group
bash
# Change group only
sudo chgrp root secret.txt

# Change group recursively
sudo chgrp -R developers ~/project
Why Ownership Matters
Owner — The user who created the file (or was assigned it).

Group — A set of users who share permissions.

Others — Everyone else on the system.

⚠️ You need sudo to change ownership to another user. Regular users can only change ownership of files they already own (and only to themselves).

6. Best Practices
❌ NEVER Use chmod 777
bash
# 🚫 BAD — gives EVERYONE full access
chmod 777 /var/www/html
Why it's dangerous:

Any user can read, modify, or delete your files.

Attackers can inject malicious code into scripts.

It's a massive security hole in production.

It violates the Principle of Least Privilege.

✅ Follow the Principle of Least Privilege
Give users only the permissions they need — nothing more.

Scenario	Recommended Permission
Web files (HTML/CSS/JS)	644
Web directories	755
Executable scripts	755
SSH private keys	600
SSH directory	700
Config files with secrets	600
Shared team directory	775 (with proper group)
✅ Other Best Practices
Use groups instead of 777 — Add users to a group and use 775.

Audit permissions regularly — Run find / -perm -777 to find dangerous files.

Set proper umask — Default umask 022 gives new files 644 and directories 755.

Never chmod -R 777 — Recursive 777 is a disaster waiting to happen.

Use chown before chmod — Fix ownership first, then set permissions.

Document your permission scheme — Future you will thank present you.

Finding Dangerous Permissions
bash
# Find files with 777 permissions
find / -type f -perm 0777 2>/dev/null

# Find world-writable files
find / -type f -perm -o+w 2>/dev/null

# Find files with no owner
find / -nouser -o -nogroup 2>/dev/null
7. Quick Reference Cheat Sheet
Permission Values
text
r = 4    w = 2    x = 1    - = 0
Common Permissions
text
644  →  rw-r--r--   (regular files)
600  →  rw-------   (private files)
755  →  rwxr-xr-x   (scripts, directories)
700  →  rwx------   (private directories)
775  →  rwxrwxr-x   (shared group directories)
chmod Commands
bash
chmod 644 file.txt           # Numeric
chmod u+x file.sh            # Symbolic: add execute for owner
chmod g-w file.txt           # Symbolic: remove write for group
chmod o=r file.txt           # Symbolic: set others to read only
chmod -R 755 /var/www        # Recursive
chown / chgrp Commands
bash
sudo chown user file.txt             # Change owner
sudo chown user:group file.txt       # Change owner + group
sudo chgrp group file.txt            # Change group
sudo chown -R user:group dir/        # Recursive
Checking Permissions
bash
ls -la file.txt              # View permissions
stat file.txt                # Detailed info
namei -l /path/to/file       # Check permissions along a path
🧪 Practice Lab
bash
# Create test environment
mkdir ~/permissions-lab && cd ~/permissions-lab
touch secret.txt
echo "DevOps Master" > secret.txt

# Experiment
ls -la secret.txt
chmod 000 secret.txt && cat secret.txt      # Should FAIL
chmod 644 secret.txt && cat secret.txt      # Should WORK
chmod 755 secret.txt
chmod u+x secret.txt
chmod g-w secret.txt
chmod o=r secret.txt
📚 Summary
Concept	Key Takeaway
rwx	Read, Write, Execute — the three permissions
4,2,1	Numeric values for r, w, x
chmod	Change permissions (numeric or symbolic)
chown	Change file owner
chgrp	Change file group
777	NEVER USE IT — security nightmare
Best practice	Principle of Least Privilege — give only what's needed


