# GNU Stow: A Better Way to Manage Dotfiles

## The Problem We're Solving

This repository currently uses a manual symlink strategy:

```bash
ln -s ~/XeitorMarchyVault/hypr ~/.config/hypr
ln -s ~/XeitorMarchyVault/starship.toml ~/.config/starship.toml
ln -s ~/XeitorMarchyVault/omarchy-themed ~/.config/omarchy/themed
```

This works, but has issues:
- No automated setup (copy-paste commands from README)
- No easy way to install/uninstall all symlinks at once
- No conflict detection if files already exist at target
- Hard to manage across multiple machines
- Easy to forget which symlinks belong to the vault

**GNU Stow** solves all of this.

---

## What is GNU Stow?

Stow is a **symlink farm manager**. Originally designed for installing software packages in isolation while making them appear unified in `/usr/local`, it turns out to be perfect for dotfiles.

Instead of manually creating symlinks, you organize your dotfiles into "packages" and let Stow handle the linking.

---

## Core Concepts

### Three Directories

| Directory | Description | Our Context |
|-----------|-------------|-------------|
| **Stow Directory** | Contains all your packages | `~/XeitorMarchyVault/` |
| **Package** | A folder with related configs | `hypr/`, `starship/`, etc. |
| **Target Directory** | Where symlinks are created | `~/.config/` (or `~`) |

### The Key Insight

When you run `stow <package>` from the stow directory, it creates symlinks in the **parent directory** by default. The package's internal structure mirrors exactly where files should end up.

---

## Anatomy of a Stow Command

Let's break down exactly what happens when you run a stow command, using our `hypr` package as an example.

### The Five Key Components

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           STOW DIRECTORY                                    │
│                      ~/XeitorMarchyVault/                                   │
│  ┌───────────────────────────────────────────────────────────────────────┐  │
│  │                      PACKAGE DIRECTORY                                │  │
│  │                         hypr/                                         │  │
│  │  ┌─────────────────────────────────────────────────────────────────┐  │  │
│  │  │                   INSTALLATION IMAGE                            │  │  │
│  │  │                      .config/                                   │  │  │
│  │  │                        └── hypr/                                │  │  │
│  │  │                              ├── hyprland.conf                  │  │  │
│  │  │                              ├── bindings.conf                  │  │  │
│  │  │                              ├── monitors.conf                  │  │  │
│  │  │                              └── ...                            │  │  │
│  │  └─────────────────────────────────────────────────────────────────┘  │  │
│  └───────────────────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────────────────┘
                                     │
                                     │ stow hypr
                                     │
                                     ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                          TARGET DIRECTORY                                   │
│                                 ~/                                          │
│                                                                             │
│   .config/                                                                  │
│     └── hypr/ ──────────── SYMLINK ──────────► ../XeitorMarchyVault/       │
│                                                  hypr/.config/hypr/         │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Component Definitions

| Component | What It Is | Example |
|-----------|------------|---------|
| **Stow Directory** | The root folder containing all your packages. Stow uses the current directory by default, or specify with `-d`. | `~/XeitorMarchyVault/` |
| **Package Directory** | A subfolder in the stow directory. Its name is the package name you pass to stow. | `hypr/` |
| **Installation Image** | The directory structure *inside* a package that mirrors how files should appear in the target. | `.config/hypr/` with all the config files |
| **Target Directory** | Where symlinks get created. Defaults to parent of stow directory, or specify with `-t`. | `~/` (home directory) |
| **Symlink** | The actual link created by stow, pointing from target back into the package. | `~/.config/hypr` → `XeitorMarchyVault/hypr/.config/hypr` |

### Practical Example: Stowing Hypr

**Setup**: Your dotfiles vault is at `~/XeitorMarchyVault/` with this structure:

```
~/XeitorMarchyVault/
└── hypr/                          ← Package Directory
    └── .config/                   ← Installation Image starts here
        └── hypr/
            ├── hyprland.conf
            ├── bindings.conf
            ├── monitors.conf
            ├── input.conf
            ├── looknfeel.conf
            ├── autostart.conf
            ├── hypridle.conf
            ├── hyprlock.conf
            └── scripts/
                ├── monitor-switch.sh
                └── window-switcher.sh
```

**Command**:
```bash
cd ~/XeitorMarchyVault    # Enter the stow directory
stow hypr                 # Stow the hypr package
```

**What happens**:
1. Stow looks in the current directory (stow directory): `~/XeitorMarchyVault/`
2. Finds the package directory: `hypr/`
3. Scans the installation image inside: `.config/hypr/...`
4. Determines target directory: `~/` (parent of stow directory)
5. Creates symlink: `~/.config/hypr` → `../XeitorMarchyVault/hypr/.config/hypr`

**Result**:
```bash
$ ls -la ~/.config/hypr
lrwxrwxrwx 1 xeitor xeitor 42 Jan 11 12:00 /home/xeitor/.config/hypr -> ../XeitorMarchyVault/hypr/.config/hypr
```

Now `~/.config/hypr/hyprland.conf` resolves to `~/XeitorMarchyVault/hypr/.config/hypr/hyprland.conf`.

### The Command Broken Down

```bash
stow -t ~ -d ~/XeitorMarchyVault hypr
     ──┬─   ────────┬───────────  ─┬─
       │            │              │
       │            │              └── Package name (directory in stow dir)
       │            │
       │            └── Stow directory (where packages live)
       │
       └── Target directory (where symlinks are created)
```

When you're inside the stow directory, you can omit `-d` and `-t`:
```bash
cd ~/XeitorMarchyVault
stow hypr    # Equivalent to: stow -t ~ -d . hypr
```

### Why the Installation Image Matters

The installation image is the key to understanding stow. It's **the path structure that gets recreated in the target**.

If your package looks like this:
```
hypr/
└── .config/
    └── hypr/
        └── hyprland.conf
```

Stow creates: `~/.config/hypr/` → pointing to the package

If your package looked like this instead (wrong):
```
hypr/
└── hyprland.conf
```

Stow would create: `~/hyprland.conf` → pointing to the package (not what you want!)

**The installation image must mirror the exact path from target to final file location.**

---

## How It Would Work for This Repo

### Current Structure Problem

Our current layout:
```
XeitorMarchyVault/
├── hypr/           → symlinked to ~/.config/hypr
├── starship.toml   → symlinked to ~/.config/starship.toml
└── omarchy-themed/ → symlinked to ~/.config/omarchy/themed
```

The target is `~/.config/`, but our vault is in `~/`. The parent of our stow directory is `~`, not `~/.config/`.

### Stow-Compatible Structure

To use Stow, we reorganize packages to mirror their target location:

```
XeitorMarchyVault/
├── hypr/
│   └── .config/
│       └── hypr/
│           ├── hyprland.conf
│           ├── bindings.conf
│           └── ...
├── starship/
│   └── .config/
│       └── starship.toml
└── omarchy/
    └── .config/
        └── omarchy/
            └── themed/
                ├── hyprland.conf.tpl
                └── ...
```

Now from `~/XeitorMarchyVault/`, running:
```bash
stow hypr
```

Creates: `~/.config/hypr` → `XeitorMarchyVault/hypr/.config/hypr`

### Alternative: Specify Target

Or keep the current structure and specify the target explicitly:
```bash
cd ~/XeitorMarchyVault
stow -t ~/.config hypr
stow -t ~/.config starship.toml  # won't work - stow works on directories
```

**Catch**: Stow operates on directories (packages), not individual files. For `starship.toml`, you'd need:
```
XeitorMarchyVault/
└── starship/
    └── starship.toml
```
Then: `stow -t ~/.config starship`

---

## Stow Commands

### Basic Operations

```bash
# Install a package (create symlinks)
stow <package>

# Uninstall a package (remove symlinks)
stow -D <package>

# Reinstall (useful after updating package contents)
stow -R <package>

# Dry run - see what would happen
stow -n -v <package>
```

### Useful Options

| Option | Description |
|--------|-------------|
| `-t <dir>` | Set target directory (default: parent of stow dir) |
| `-d <dir>` | Set stow directory (default: current dir) |
| `-n` | Simulate, don't actually do anything |
| `-v` | Verbose output |
| `--adopt` | Move existing files into package (dangerous but useful) |
| `--dotfiles` | Treat `dot-` prefix as `.` (avoid hidden files in repo) |

---

## Tree Folding: Stow's Secret Weapon

Stow is smart about creating the minimum number of symlinks.

### Folding

If `hypr/` is the only package needing `.config/hypr/`, Stow creates ONE symlink:
```
~/.config/hypr → ~/XeitorMarchyVault/hypr/.config/hypr
```

Not individual symlinks for each file inside.

### Unfolding

If another package also needs files in `.config/hypr/`, Stow "unfolds":
1. Removes the directory symlink
2. Creates actual `.config/hypr/` directory
3. Creates individual file symlinks from both packages

### Refolding

When you unstow a package and only one package remains using that directory, Stow can refold back to a single directory symlink.

---

## Conflict Detection

Stow checks for conflicts **before** making any changes:

- If a real file exists where Stow needs to create a symlink → **conflict**
- If a symlink exists pointing somewhere else → **conflict**

Stow aborts entirely if conflicts are found, keeping your filesystem consistent.

### The `--adopt` Escape Hatch

If you have existing configs you want to bring into your dotfiles:
```bash
stow --adopt <package>
```

This **moves** the existing files into your package directory, then creates symlinks. Useful for initial setup, but use with caution (backup first!).

---

## Practical Migration Plan

### Step 1: Restructure the Repository

```bash
# Create package directories with proper nesting
mkdir -p hypr/.config
mv hypr hypr-old
mkdir -p hypr/.config/hypr
mv hypr-old/* hypr/.config/hypr/
rmdir hypr-old

# Same for others
mkdir -p starship/.config
mv starship.toml starship/.config/

mkdir -p omarchy/.config/omarchy
mv omarchy-themed omarchy/.config/omarchy/themed
```

### Step 2: Remove Old Symlinks

```bash
rm ~/.config/hypr
rm ~/.config/starship.toml
rm ~/.config/omarchy/themed
```

### Step 3: Stow Everything

```bash
cd ~/XeitorMarchyVault
stow hypr starship omarchy
```

### Step 4: Verify

```bash
ls -la ~/.config/hypr
ls -la ~/.config/starship.toml
ls -la ~/.config/omarchy/themed
```

---

## Stow vs Current Approach

| Aspect | Manual `ln -s` | GNU Stow |
|--------|---------------|----------|
| Setup | Copy-paste commands | `stow *` |
| Uninstall | Find and remove each link | `stow -D *` |
| Conflict handling | Overwrites or fails silently | Detects and aborts safely |
| New machine setup | Remember all paths | Clone repo, run stow |
| Adding new configs | Edit README, run ln | Put in package, run stow |
| Visibility | Must remember what's linked | `stow -n -v` shows everything |

---

## Ignore Files

Stow automatically ignores common files (`.git`, `README`, etc.), but you can customize:

**`.stow-local-ignore`** in a package:
```
README.md
LICENSE
\.git
```

**`~/.stow-global-ignore`** for all packages:
```
\.DS_Store
*~
```

---

## References

- [GNU Stow Manual](https://www.gnu.org/software/stow/manual/stow.html)
- [Managing Dotfiles with Stow](https://www.jakewiesler.com/blog/managing-dotfiles) - Practical tutorial
