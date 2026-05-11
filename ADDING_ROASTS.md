# Adding Roasts in Your Language

You do not need to know bash. You do not need to be a developer. If you can write a funny line in your language, you can contribute to this project.


## How roasts work

When you type a wrong command, elite-roast picks a random line from an array and shows it. All these lines live in one file called `roasts.sh`. That is the only file you need to touch.


## Step 1 — Fork and clone the repo

On GitHub, click Fork in the top right. Then clone your fork:

```bash
git clone https://github.com/YOUR_USERNAME/elite-roast.git
cd elite-roast
```


## Step 2 — Open roasts.sh

```bash
nano roasts.sh
```

You will see arrays like this at the top:

```bash
GIT_INSULTS=(
    "commit message 'fix stuff' antha?? en fix maade bro, ninna life aa?"
    "git log nodu - full chaos, BMTC busalli code maadidiya aa?"
    ...
)
```

Each array fires for a different situation:

```
GIT_INSULTS          when a git command fails
PYTHON_INSULTS       when python or pip fails
LINUX_INSULTS        when sudo, apt, rm, chmod, systemctl fails
NETWORK_INSULTS      when ssh, curl, ping, wget fails
GENERIC_INSULTS      when anything else fails
UNKNOWN_CMD_INSULTS  when bash cannot find the command at all
DESI_EXTRAS          random phrase added on top of failures occasionally
UNKNOWN_EXTRAS       bonus line after unknown command roasts
```


## Step 3 — Add your roasts

Pick the right array and add your lines. Put a comment above them so people know what language it is:

```bash
UNKNOWN_CMD_INSULTS=(
    # existing lines
    "en guru keyboard mele kai biddita?? this command doesn't exist da"

    # Tamil
    "enna da ithu, keyboard la random a type panniya?"
    "google kooda theriyaadhu ithai - and google knows everything da"
    "command illada, unna maadhiri - kandukave mudiyala"
    "syntax correct a type pannave mudiyala, life la enna pannuva?"
)
```


## Writing good roasts

Write the way people actually talk online in your language. Mixed language is good. The Kannada roasts in this project mix Kannada and English mid-sentence because that is how people in Bengaluru actually text. Do the same.

Some things that work:

- Local references - traffic, food, places, public transport, anything specific to your city or region
- Developer pain points - slow builds, broken dependencies, deployment disasters
- Relatable situations - the kind of thing that makes other devs say "ayyoo this happened to me too"

Things to avoid:

- Targeting real people
- Anything that could come across as mean rather than funny
- Overly long roasts - shorter is usually funnier


## Step 4 — Test locally

```bash
source roast.sh
setup_roast_aliases
asd
gti
pythoon
```

Make sure your roasts show up and nothing broke.


## Step 5 — Open a pull request

Commit your changes:

```bash
git add roasts.sh
git commit -m "add Tamil roasts"
git push
```

Go to GitHub and open a pull request from your fork to the main repo. In the description, mention which language you added and roughly how many roasts. That is it.


## Tips

You can mix scripts freely. Tamil script, romanised Tamil, English, all in the same line - whatever feels natural for how people in your community actually type.

There is no minimum number of roasts. Even two or three lines in your language is a valid contribution.

If you are not sure which array to add to, just pick GENERIC_INSULTS or UNKNOWN_CMD_INSULTS. Those fire the most often so your roasts will show up regularly.
