# intellij_cygwin
Integrating Cygwin/Babun as Intellij IDEA Terminal

## Install babun

Set user environment variable HOME=%USERPROFILE%. You will enjoy better navigation to ~/IdeaProjects

    reg add HKCU\Environment /v HOME /t REG_EXPAND_SZ /d ^%USERPROFILE^%

 * Install [babun](http://babun.github.io/)

## Configure babun and environment
    # Update /etc/passwd to reflect new HOME
    mkpasswd -l -p "$(cygpath -H)" > /etc/passwd
  	
    # Tweak mintty to support middle-button paste
    curl https://raw.githubusercontent.com/vermut/intellij_cygwin/master/minttyrc > .minttyrc

## Configure PuTTY settings (default and existing sessions)
Mostly from [here](https://github.com/jblaine/solarized-and-modern-putty) with middle-button paste and no alt-screen.

    curl https://raw.githubusercontent.com/vermut/intellij_cygwin/master/putty-mass-settings-update.sh | bash


## Add support for Pageant
    pact install ssh-pageant
    echo 'eval $(/usr/bin/ssh-pageant -r -a "/tmp/.ssh-pageant-$USERNAME")' >> ~/.zshrc
