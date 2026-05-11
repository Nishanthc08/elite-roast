# Support

## Something broke after install

Check if your .bashrc has a syntax error first:

```bash
bash -n ~/.bashrc && echo "ok"
```

If it says syntax error, run:

```bash
sed -i '/# BEGIN elite-roast/,/# END elite-roast/d' ~/.bashrc
bash -n ~/.bashrc && echo "ok"
```

Then reinstall:

```bash
sudo apt remove elite-roast
sudo dpkg -i elite-roast_1.0_all.deb
```

Open a new terminal and test.


## Roasting is not working in the terminal

Make sure you opened a new terminal after installing. The current session does not pick up the changes until you start a new one.

If a new terminal still does not roast, check that the .bashrc injection worked:

```bash
grep "elite-roast" ~/.bashrc
```

If nothing comes back, the injection was skipped. Run:

```bash
source /usr/share/elite-roast/roast.sh && setup_roast_aliases
```

And then add it to ~/.bashrc manually:

```bash
echo "" >> ~/.bashrc
echo "# BEGIN elite-roast" >> ~/.bashrc
echo "if [ -f /usr/share/elite-roast/roast.sh ]; then" >> ~/.bashrc
echo "    source /usr/share/elite-roast/roast.sh && setup_roast_aliases" >> ~/.bashrc
echo "fi" >> ~/.bashrc
echo "# END elite-roast" >> ~/.bashrc
```


## The failure counter is not incrementing

This usually means the counter file is owned by root. Fix it:

```bash
sudo rm -f /tmp/roast_failures*
```

Open a new terminal and test again.


## Asking questions

Open a GitHub issue at https://github.com/Nishanthc08/elite-roast/issues with the label question. Describe what you tried and what happened.

For anything that should not be public, email nishanthc264@gmail.com.


## Feature requests

Open a GitHub issue with the label enhancement. Describe what you want and why.
