# intellij_cygwin
Integrating Cygwin/Babun as Intellij IDEA Terminal

## Install babun
 * Set user environment variable HOME=%USERPROFILE%. You will enjoy better navigation to ~/IdeaProjects
 * Install [babun](http://babun.github.io/)

## Configure babun and environment
  	# Update /etc/passwd to reflect new HOME
  	mkpasswd -l -p "$(cygpath -H)" > /etc/passwd
  	
  	# Tweak mintty to support middle-button paste
  	curl https://raw.githubusercontent.com/vermut/intellij_cygwin/master/minttyrc > .minttyrc
