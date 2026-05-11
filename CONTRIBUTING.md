# Contributing to elite-roast

Thanks for wanting to contribute. This project is simple by design so contributing is straightforward.

There are two kinds of contributions: adding roasts and changing the logic. Both are welcome but they work differently.


## Adding roasts

This is the main thing people contribute. You do not need to understand bash to do this. You only need to edit one file.

All roasts live in `roasts.sh`. Open it and you will find clearly labelled arrays:

```
GIT_INSULTS        fires when a git command fails
PYTHON_INSULTS     fires when python or pip fails
LINUX_INSULTS      fires when sudo, apt, rm, chmod, systemctl fails
NETWORK_INSULTS    fires when ssh, curl, ping, wget fails
GENERIC_INSULTS    fires for anything else that fails
UNKNOWN_CMD_INSULTS  fires when bash cannot find the command
DESI_EXTRAS        random phrase added on top occasionally
UNKNOWN_EXTRAS     bonus line after unknown command roasts
```

Pick the right array, add your line inside the quotes, done.

Write roasts the way people actually talk online. Mixed language is fine and actually preferred for this project. The Bengaluru roasts mix Kannada and English mid-sentence because that is how people in Bengaluru actually type. Do the same for your language.

No need to add a translation or explanation. Just write it naturally.


## Adding a new language pack

If you are adding roasts in a language that is not already in the file, add a comment above your lines so people know what language it is:

```bash
UNKNOWN_CMD_INSULTS=(
    # existing roasts
    "en guru keyboard mele kai biddita?? this command doesn't exist da"

    # Tamil roasts
    "enna da ithu, keyboard la random a type panniya?"
    "command illada, unna maadhiri - kandukave mudiyala"
)
```

That is all. No separate file needed, no configuration changes.


## Changing the logic

If you want to change how roast.sh works, open an issue first and describe what you want to change and why. This avoids situations where someone spends time on a change that does not fit the project.

For small bug fixes you can just open a pull request directly.


## How to submit your changes

Fork the repo on GitHub, make your changes, and open a pull request. In the pull request description, mention what you added or changed and which language if you added roasts.

There is no formal review process. If it looks good it gets merged.


## Testing before you submit

Source the file and make sure nothing broke:

```bash
source roast.sh
setup_roast_aliases
gti
asd
pythoon
roast-stats
```

If all four do something sensible, you are good.

To build the deb and test the full package:

```bash
bash build.sh
sudo dpkg -i elite-roast_1.0_all.deb
```

Open a new terminal and test again.


## Code style

For roast.sh: keep it readable, no magic, comment anything that is not obvious.

For roasts.sh: lowercase, no full stops at the end, write like you are texting not writing an essay.
