# Changelog

All notable changes to elite-roast are listed here.
Format follows https://keepachangelog.com


## [1.0] - 2026-04-06

First release.

### Added

- command_not_found_handle hook that fires automatically for every unknown command
- execute() wrapper that intercepts known commands and roasts on failure
- 187 roasts across 8 categories: git, python, linux, network, generic, unknown command, desi extras, unknown extras
- Typo correction suggestions for 80+ common command misspellings
- Per-user failure counter stored in /tmp/roast_failures_$UID
- roast-stats command to check failure count for the day
- setup_roast_aliases to enable roasting for git, python, pip, ssh, curl, wget, sudo, apt, systemctl, nmap, ping
- Time-based messages: filter coffee reminder in the afternoon, rest reminder after 8pm
- 20% chance of a random Kannada phrase on top of any failure roast
- Auto-inject into ~/.bashrc on install so all terminal types load the roaster
- Clean removal via prerm that strips everything including .bashrc entries
- Lintian-clean deb package with changelog, copyright, man page, and lintian overrides
- Reproducible builds via SOURCE_DATE_EPOCH
- Autopkgtest suite with four tests: basic-roast, unknown-cmd, failure-counter, clean-removal
- GitHub Actions CI/CD pipeline that builds, lints, tests, and attaches deb to releases
- GPG signing script
