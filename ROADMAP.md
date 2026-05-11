# Roadmap

Things planned for future versions. Not in any particular order.


## Language packs

The biggest thing missing right now is more languages. The project currently has Bengaluru style Kannada mixed English roasts. Would love to see:

- Tamil roasts - Chennai dev culture has its own flavour
- Telugu roasts - Hyderabad tech scene has plenty of material
- Hindi roasts - for the rest of the country
- Malayalam roasts - Kochi/Trivandrum devs should have their own
- Any other Indian regional language

If you want to add roasts in your language, see ADDING_ROASTS.md. No bash knowledge needed.


## v1.1

- Fish shell support - currently bash only, fish has its own hook mechanism
- Zsh support - zsh uses command_not_found_handler with different behaviour
- roast-reset command to clear the failure counter manually
- More typo corrections in the suggestion map


## v1.2

- roast-off command to temporarily disable roasting without uninstalling
- roast-on to re-enable it
- Severity levels - some failures could get longer roasts than others


## v2.0

- Config file support so users can pick which categories they want
- Custom roast files - users can point to their own roasts.sh without modifying the package
- Per-command roast customisation


## Not planned

- GUI - this is a terminal tool, it stays in the terminal
- Network features - no phoning home, no stats collection, nothing
- Windows support - use WSL2 if you are on Windows
