# elite-roast

[![Build](https://github.com/Nishanthc08/elite-roast/actions/workflows/build.yml/badge.svg)](https://github.com/Nishanthc08/elite-roast/actions/workflows/build.yml)
[![Version](https://img.shields.io/badge/version-1.0-blue.svg)](https://github.com/Nishanthc08/elite-roast/releases)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Lintian](https://img.shields.io/badge/lintian-clean-brightgreen.svg)]()
[![Platform](https://img.shields.io/badge/platform-Ubuntu%20%7C%20Debian-orange.svg)]()
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

a terminal roaster with Bengaluru flavour. roasts you every time you type a wrong command, fail a git push, break a python script, or just sneeze on the keyboard.

built by [Nishanth C](https://github.com/Nishanthc08)

---

## table of contents

- [install](#install)
- [remove](#remove)
- [what it does](#what-it-does)
- [adding roasts in your own language](#adding-roasts-in-your-own-language)
- [building from source](#building-from-source)
- [requirements](#requirements)
- [file structure](#file-structure)
- [contributing](#contributing)
- [license](#license)

---

## install

download the latest `.deb` from [releases](https://github.com/Nishanthc08/elite-roast/releases) and run:

```bash
sudo dpkg -i elite-roast_1.0_all.deb
```

open a new terminal. that's it. start making mistakes.

```bash
gti status          # typo → roast
git status          # no repo → roast
pythoon script.py   # typo → roast + did you mean: python?
roast-stats         # show today's failure count
```

---

## remove

```bash
sudo apt remove elite-roast
```

open a new terminal. everything is gone — no leftover files, no broken `.bashrc`.

verify it's fully clean:

```bash
dpkg -l | grep elite-roast          # should return nothing
ls /etc/profile.d/ | grep roast     # should return nothing
grep roast ~/.bashrc                 # should return nothing
which roast-stats                   # should return nothing
```

---

## what it does

- **unknown command** → roasts you immediately via `command_not_found_handle`
- **git failure** → git-specific roast
- **python/pip failure** → python-specific roast
- **ssh/curl/ping failure** → network roast
- **sudo/apt/rm/chmod failure** → linux roast
- **anything else** → generic roast
- **312 roasts** across 8 categories
- **typo detected** → suggests what you meant (80+ common typos covered)
- **20% chance** → random Kannada phrase added on top of any failure
- **time-aware** → filter coffee reminder in the afternoon, rest reminder after 8pm
- **`roast-stats`** → shows how many times you failed today

---

## adding roasts in your own language

all roasts live in one file — `roasts.sh`. the logic is in `roast.sh` and never needs to be touched. see [ADDING_ROASTS.md](ADDING_ROASTS.md) for the full guide.

quick version:

### step 1 — clone the repo

```bash
git clone https://github.com/Nishanthc08/elite-roast
cd elite-roast
```

### step 2 — open roasts.sh

```bash
nano roasts.sh
```

you'll see arrays like this:

```bash
GIT_INSULTS=(
    "commit message 'fix stuff' antha?? en fix maade bro, ninna life aa?"
    "git log nodu - full chaos, BMTC busalli code maadidiya aa?"
    ...
)
```

there are 8 arrays — pick the right one:

| array | when it fires |
|---|---|
| `GIT_INSULTS` | any git command fails |
| `PYTHON_INSULTS` | python or pip fails |
| `LINUX_INSULTS` | sudo, apt, rm, chmod, systemctl fails |
| `NETWORK_INSULTS` | ssh, curl, ping, wget fails |
| `GENERIC_INSULTS` | anything else that fails |
| `UNKNOWN_CMD_INSULTS` | command not found |
| `DESI_EXTRAS` | random phrase added on top occasionally |
| `UNKNOWN_EXTRAS` | bonus line after unknown command roasts |

### step 3 — add your roasts

add a new line inside the array. example adding Tamil roasts to `UNKNOWN_CMD_INSULTS`:

```bash
UNKNOWN_CMD_INSULTS=(
    # existing roasts
    "en guru keyboard mele kai biddita?? this command doesn't exist da"

    # Tamil
    "enna da ithu, keyboard la random a type panniya?"
    "command illada, உன் talent maadhiri - kandukave mudiyala"
    "Google kooda theriyaadhu ithai, neeye oru legend da"
)
```

mix your language however you want — full native script, romanized, or mixed with English like people actually type online.

### step 4 — test locally

```bash
source roast.sh
setup_roast_aliases
gti       # should fire a roast
blah      # should fire unknown command roast
```

### step 5 — build and install

```bash
bash build.sh
sudo dpkg -i elite-roast_1.0_all.deb
```

open a new terminal and your roasts are live.

---

## building from source

requires only `dpkg-deb` which comes pre-installed on any Ubuntu/Debian system.

```bash
git clone https://github.com/Nishanthc08/elite-roast.git
cd elite-roast
bash build.sh
```

or using make:

```bash
make build       # build the .deb
make test        # run the test suite
make lint        # build and run lintian
make sign        # GPG sign the .deb
make clean       # remove build artifacts
```

verify the built package:

```bash
dpkg-deb --info elite-roast_1.0_all.deb
dpkg-deb --contents elite-roast_1.0_all.deb
lintian elite-roast_1.0_all.deb
```

updating the version — edit `debian/control` and `build.sh` before building:

```
Version: 1.1
```

---

## requirements

- Ubuntu 18.04+ or any Debian-based system
- bash 4.0+ (pre-installed on all modern Ubuntu/Debian)
- no other dependencies

does **not** work on macOS — macOS ships with bash 3.2 which is too old. works fine on WSL2.

---

## file structure

```
elite-roast/
├── roast.sh              ← logic, hooks, aliases. don't touch this
├── roasts.sh             ← all the roasts. this is what you edit
├── roast-stats           ← standalone command for failure count
├── build.sh              ← builds the .deb from source
├── sign.sh               ← GPG signs the .deb
├── Makefile              ← make build / test / lint / sign / clean
├── INSTALL               ← plain text install instructions
├── debian/
│   ├── control           ← package name, version, maintainer, description
│   ├── changelog         ← version history in Debian format
│   ├── copyright         ← MIT license in Debian machine-readable format
│   ├── compat            ← debhelper compatibility level
│   ├── rules             ← build instructions for dpkg-buildpackage
│   ├── install           ← declares which files install where
│   ├── manpages          ← tells debhelper about the man page
│   ├── docs              ← tells debhelper which docs to install
│   ├── postinst          ← runs after install, sets up .bashrc for all users
│   ├── prerm             ← runs before removal, cleans everything
│   ├── watch             ← upstream version tracking via uscan
│   ├── lintian-overrides ← documents intentional policy exceptions
│   ├── roast-stats.1     ← man page source for roast-stats
│   ├── source/
│   │   ├── format        ← declares 3.0 (native) source format
│   │   └── options       ← excludes website files from source tarball
│   └── tests/
│       ├── control       ← autopkgtest test declarations
│       ├── basic-roast   ← verifies all functions load correctly
│       ├── unknown-cmd   ← verifies command_not_found_handle fires
│       ├── failure-counter ← verifies counter increments correctly
│       └── clean-removal ← verifies all files install to correct paths
└── .github/
    ├── workflows/
    │   └── build.yml     ← CI: build, lint, test, attach to release
    ├── ISSUE_TEMPLATE/
    │   ├── bug_report.md
    │   └── feature_request.md
    └── PULL_REQUEST_TEMPLATE.md
```

---

## contributing

see [CONTRIBUTING.md](CONTRIBUTING.md) for how to contribute code or logic changes.
see [ADDING_ROASTS.md](ADDING_ROASTS.md) if you just want to add roasts in your language.
see [ROADMAP.md](ROADMAP.md) for what is planned.

---

## license

MIT — do whatever you want with it, add your own language, redistribute, modify.

---

*namma oorina style terminal — written in Bengaluru, for everyone*
