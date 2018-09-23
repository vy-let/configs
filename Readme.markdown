Vy-let's global configuration files
=======================


Well howdy there! You've found your way to my personal global config files. I mainly synchronize my emacs preferences between all my machines here. You're welcome to steal it outright if you want (per the License file, of course).

This readme is intended for curious visitors, and aimed mainly at novice to advanced Emacs users.



Features
--------------

1.  It's pretty. The colors are pretty, the margins are spacious, and the window separators are minimal.

2.  It's highly portable. With one file to drop in, it automatically sets everything up.

3.  It has my favorite packages pre-configured. Here's an incomplete sampling:

    -   Helm
    -   Projectile
    -   Magit
    -   Smart Mode-Line
    -   Treemacs
    -   Perspective.el
    -   Rainbow Parentheses
    -   Anzu (I-search summary)
    -   Winum (M-*n* to select window *n*)
    -   VLF (very large file support)
    -   Adaptive Wrap (word-wrap with smart indentation in code)
    -   Nyan-Mode
    -   Ruby-mode *and* Enh-Ruby-mode! You can switch between them! (Doesn't install enh-ruby-mode if you don't already have ruby installed.)
    -   Base16 Tomorrow Night Theme

4.  It behaves like it's the 21st century. All files are assumed utf-8; it auto reverts for changes made by git; it doesn't beep at you; etc.

5.  Local prefs set by Emacs's internal configurator don't clutter the init file.

### It's Personal

This is not meant to be exactly everyone's cup of tea. Like Spacemacs, you can drop it in and start going, but unlike Spacemacs, it's not meant to replace Emacs's configuration. It's more like a good starting point.

For instance, the current configuration is hard-coded to use 2-space indentation wherever possible. In the classical emacs tradition, I invite you to copy this config and modify it directly. Change those '2's to '4's. Make it your own.




The things
----------------

This repo contains a number of niceties that I like to have when setting up a computer.

1.  My default desktop picture, "Sunset near Mattole" (my own work;
    public domain).

2.  Some things for the fish shell? I need to add to this.

3.  A mostly-preconfigured fast emacs daemon setup for Mac and
    systemd-oriented linuxen. (More below.)

4.  The main course: my Emacs init.el file. (More below.)



How to use the things
---------------------------------


Either download the files you want, or clone the repo to keep abreast of my arbitrary and absolutely not backward-compatible changes. If you want to get *real* fancy, you could fork this repo even and keep customizing. After all, this isn't spacemacs, and I don't pretend that this will be out-of-the-box perfect for everyone.

On Mac I typically clone it to `~/Library/Configs`, and on Linux I use `~/.config/synchronized`.


### Emacs Configuration

My Emacs configuration (`init.el`) supports Linux and Mac (perhaps only [emacs-mac][emacs-mac]), versions 25+, on gui and terminal.

My design philosophy here is to have one single emacs file that contains everything I want to keep consistent across my machines. I don't have any custom elisp libraries; all the libraries and themes I use come from melpa. That means I can treat most everything inside `.emacs.d` as non-precious. This is so the installation steps are as simple as can be:

1.  Asynchronously:

    -   Install emacs (or [emacs-mac][emacs-mac], or emacs-nox).

    -   Create the `~/.emacs.d` folder (or, if you already have one, move it aside as a backup). Then copy or symlink my `init.el` to `~/.emacs.d/init.el` or `~/.emacs`.

2.  Launch emacs.

    This will start off a series of automatic setup steps. I like it to all be automatic to save me steps when setting up a new computer.

    > Please bear in mind that the init file is executable code, and if you use it (putting it in place and launching emacs) you're agreeing to the License file in this repo. That's important because, like most open software, **you use it at your own risk.**

    The first thing that will happen is emacs will go out and download [use-package][u-p] and the [base16 themes][b16]. The themes are particularly large and slow to download, so this step takes a minute. I may work on a way of speeding those up later.

    Next it will go out and, with use-package's help, download and configure all of the emacs packages I like to use.

That's it. On future launches, the config file (and use-package) will notice that you already have the right packages downloaded and skip past that step, and go right into configuring them. You won't need an internet connection. I find that emacs launches take about half a second.

If at any point you want to update the installed packages, I recommend deleting the elpa folder (`~/.emacs.d/elpa`) and relaunching emacs, which will cause all packages to be re-downloaded.

Note that if you want to make customizations to sync to other environments, you'll want to write them into the init.el file; whereas if you want to make changes that remain local to one machine, you'll want to use the built-in easy customization system. I have the easy-customization system set up to save out to `~/.emacs.d/local-prefs.el`, which I don't hook up to version control. For instance, I like to set my default font families on a per-machine basis, so I do that in my local prefs. That's good for you, because it means that my favorite, [Hasklig][hl], is not a dependency for you!


### Emacs Daemon

Wait, what? That half-second launch time is too slow?

If you want to keep it as your terminal's `$EDITOR`, the time-tested approach is to keep emacs open in the background and connect to it to edit files.

If you're on Linux and use systemd, you can copy the `systemd/user/emacs.service` file into the same location under your home folder, and register and start it like normal. I forget how this goes, but once you get it configured you can start and stop it in the background using `systemctl --user start emacs` and `systemctl --user stop emacs`.

If you're on Mac it's a bit more complicated. I will take the `bin/emacsd` program and copy it to my `~/bin` folder (which I make sure is in my executable `$PATH`). Then I copy out the `org.gnu.Emacs.daemon.plist` file into `~/Library/LaunchAgents`. Unfortunately this has my personal home folder hard-coded in, and you'll need to change it to match your own. Thanks, launchd. After that, the command to start and stop it is `launchctl load ~/Library/LaunchAgents/org.gnu.Emacs.daemon.plist` and the equivalent `unload` command.

In either case, I then set a shell alias of `em` as shorthand for `emacsclient -t`. Now you can do `em somefile.txt`, and it's super speedy and slick!





Background
-------------------

When I started using emacs in college, I used stock GNU Emacs. It was interesting, and I got accustomed to the everyday keybindings, but its default anachronisms pushed me away. Years later, a coworker suggested I try out Spacemacs. I did, and came to love it. I came to understand how modern emacs *could* feel, without any stark underlying modifications.

Eventually, though, I felt like it was boxing me in, and so I set out to recreate the Spacemacs features I'd become addicted to. This emacs config is the ongoing product of that endeavor, and honestly I'm more happy with it so far than I was with Spacemacs. I've used this config as you see it in the git commit log, as my only editor for almost two years.

















[emacs-mac]: https://bitbucket.org/mituharu/emacs-mac/
[u-p]: https://github.com/jwiegley/use-package
[b16]: https://melpa.org/#/base16-theme
[hl]: https://github.com/i-tu/Hasklig
