## How to import/export settings

Gnome terminal is a bit of a jerk and does not save settings in a local dotfile which makes it super annoying to do this. So you have to use dconf to dump and then import the settings:

```dconf dump /org/gnome/terminal/ > gnome_terminal_settings.txt```

and then

```dconf load /org/gnome/terminal/ < gnome_terminal_settings.txt```
