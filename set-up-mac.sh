#!/bin/bash
echo "Running script using bash version:"
echo $BASH_VERSION

# If you're not me, *really* think before running this script--it's all on you

# Before running, install Xcode command line tools via:
# $ xcode-select —-install

echo "-- Shell script to set-up a new Mac --"
echo "IMPORTANT: You are warned - this is *my* set-up, *my* way!"
echo "IMPORTANT: You must also have *already installed Xcode command-line tools* with: $ xcode-select —-install"

read -p "Press <return> to continue or ^C to quit now"

echo "Ok. Here we go ..."


# Make my directories
echo "Making my directories under HOME (~), i.e. under $HOME"
mkdir ~/bin
mkdir ~/lab
mkdir ~/tmp
echo "Directory structure under HOME (~) is now:"
ls -d */


# SSH keys
echo "Generating SSH keys"
echo "You will be prompted for email, file location (enter for default) and passphrase"
read -p "Enter SSH key email: " SSH_EMAIL
ssh-keygen -t ed25519 -C "$SSH_EMAIL"
echo "Adding SSH private key to ssh-agent and storing passphrase in keychain"
echo "You will be prompted for the passphrase again"
eval "$(ssh-agent -s)"
cat <<EOT >> ~/.ssh/config
Host *
	AddKeysToAgent yes
	UseKeychain yes
	IdentityFile ~/.ssh/id_ed25519

EOT
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
read -p "Copy key details and then press <return> to continue"


# Install Homebrew itself
echo "Installing Homebrew ..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update
brew upgrade
echo "Done ..."


# Install packages and software using Homebrew
echo "Installing packages and software using Homebrew ..."

# Bash
echo 'Installing the latest version of bash'
echo 'You will be prompted for root password to add the new version of bash to /etc/shells'
brew install bash
echo '/opt/homebrew/bin/bash' | sudo tee -a /etc/shells 1>/dev/null

# Zsh
echo 'Installing the latest version of Zsh'
echo 'You will be prompted for root password to add the new version of bash to /etc/shells'
brew install zsh
echo '/opt/homebrew/bin/zsh' | sudo tee -a /etc/shells 1>/dev/null

# Python
brew install python  # Becomes the new default, non-system version
pip install --upgrade pip
brew install pyenv
brew install pyenv-virtualenv

# Git
brew install git

# Terminal tools, commands and prompts
brew install bash-completion@2
brew install zsh-completions
brew install zsh-syntax-highlighting
brew install zsh-autosuggestions
brew install z
brew install pure
brew install tree
brew install wget
brew install jq
brew install yq
brew install --cask iterm2

# Dev tools
brew install terraform
brew install sqlite

# Command-line interfaces and tools
brew tap databricks/tap
brew install databricks
brew install awscli
brew install azure-cli
brew install --cask microsoft-azure-storage-explorer

# Text editors and IDEs
brew install --cask visual-studio-code

# Productivity
brew install --cask alfred
brew install --cask 1password
brew install --cask google-chrome
brew install --cask logi-options+
brew install --cask meetingbar
brew install --cask drawio

# Collaboration/meetings
brew install --cask slack
brew install --cask zoom

# MS Office
brew install --cask microsoft-teams
brew install --cask microsoft-excel
brew install --cask microsoft-powerpoint
brew install --cask microsoft-word

# Fonts and icons
echo "Installing fonts ..."
echo "Configure fonts in iTerm2 via Preferences > Profiles > Text > Font [> potenitally also Non-ASCII Font]"
brew tap homebrew/cask-fonts
brew install --cask font-menlo-for-powerline
brew install --cask font-hack-nerd-font
brew install --cask font-fontawesome
brew install --cask font-fira-code

# Homebrew installations complete
brew cleanup
echo "Homebrew software installations complete"


# Configure Git
echo "Configuring Git settings and aliases ..."
read -p "Enter global default Git email: " GIT_EMAIL

# Configure Git settings
git config --global user.name "Rob Jarvis"
git config --global user.email "$GIT_EMAIL"
git config --global core.editor "vim"

# Git aliases
git config --global alias.unstage 'reset HEAD --' 
git config --global alias.unmod 'checkout --' 
git config --global alias.last 'log -1 HEAD' 
git config --global alias.pub 'push -u origin HEAD' 
# git config --global alias.setemail 'config user.email jarvisrob@users.noreply.github.com' 
git config --global alias.cm 'commit -m' 
git config --global alias.co checkout 
git config --global alias.cob 'checkout -b' 
git config --global alias.aa 'add -A' 
git config --global alias.s status 
git config --global alias.ss 'status -s' 
git config --global alias.dm diff 
git config --global alias.ds 'diff --staged'


# VS Code extensions
echo "Installing VS Code extensions"
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension ms-python.debugpy
code --install-extension ms-python.isort
code --install-extension databricks.databricks
code --install-extension mtxr.sqltools
code --install-extension databricks.sqltools-databricks-driver
code --install-extension mhutchie.git-graph
code --install-extension donjayamanne.githistory
code --install-extension hashicorp.terraform
code --install-extension redhat.vscode-yaml
code --install-extension dracula-theme.theme-dracula
code --install-extension pkief.material-icon-theme
code --install-extension gruntfuggly.todo-tree


# iTerm2 themes
echo "Installing iTerm2 themes ..."
echo "Configure in iTerm2 > Preferences > Profiles > Colors > Color Presets > [Choose theme]."
# iterm2-snazzy, https://github.com/sindresorhus/iterm2-snazzy
wget https://github.com/sindresorhus/iterm2-snazzy/raw/main/Snazzy.itermcolors -P ~/tmp
open ~/tmp/Snazzy.itermcolors
rm ~/tmp/Snazzy.itermcolors


# macOS settings
echo "macOS settings being configured"

echo "First closing System Preferences window if open to avoid conflicts"
# Close System Preferences to prevent conflicts with the settings changes
# The following is AppleScript called from the command line
# http://osxdaily.com/2016/08/19/run-applescript-command-line-macos-osascript/
osascript -e 'tell application "System Preferences" to quit'

echo "Finder settings"

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

killall -HUP Finder


echo "Dock settings"

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Only Show Open Applications In The Dock  
defaults write com.apple.dock static-only -bool true

# Minimise to Dock using "scale" effect
defaults write com.apple.dock mineffect -string scale

defaults write com.apple.dock orientation -string left

defaults write com.apple.dock magnification -bool false

defaults write com.apple.dock show-process-indicators -bool false

defaults write com.apple.dock tilesize -float 40

defaults write com.apple.dock show-recents -bool false

# Don't minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool false

killall Dock


echo ".DS_Store files settings"
# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true


echo "TextEdit settings"
# Use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0


echo "Screen saver password settings"
# Require password immediately after sleep or screen saver begins
# Start screen saver after 5 mins of idle
defaults write com.apple.screensaver askForPassword -bool true
defaults write com.apple.screensaver askForPasswordDelay -int 0
defaults -currentHost write com.apple.screensaver idleTime 300


echo "Screenshot settings"

# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "$HOME/Desktop"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"


echo "Dialog settings"
# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false


# Dot files
# References:
#   - https://www.davidculley.com/dotfiles/
#   - https://superuser.com/questions/183870/difference-between-bashrc-and-bash-profile/183980#183980
#   - https://apple.stackexchange.com/questions/51036/what-is-the-difference-between-bash-profile-and-bashrc
#   - http://zsh.sourceforge.net/Intro/intro_3.html

echo "Download dot files"

# .aliases
echo "Downloading .aliases"
wget https://raw.githubusercontent.com/jarvisrob/set-up-mac/master/.aliases -P ~
cat ~/.aliases

# .profile
echo "Downloading .profile"
wget https://raw.githubusercontent.com/jarvisrob/set-up-mac/master/.profile -P ~
cat ~/.profile

# .bash_profile
echo "Downloading .bash_profile"
wget https://raw.githubusercontent.com/jarvisrob/set-up-mac/master/.bash_profile -P ~
cat ~/.bash_profile

# .bashrc
echo "Downloading .bashrc"
wget https://raw.githubusercontent.com/jarvisrob/set-up-mac/master/.bashrc -P ~
cat ~/.bashrc

# .zshenv
echo "Downloading .zshenv"
wget https://raw.githubusercontent.com/jarvisrob/set-up-mac/master/.zshenv -P ~
cat ~/.zshenv

# .zprofile
echo "Downloading .zprofile"
wget https://raw.githubusercontent.com/jarvisrob/set-up-mac/master/.zprofile -P ~
cat ~/.zprofile

# .zshrc
echo "Downloading .zshrc"
wget https://raw.githubusercontent.com/jarvisrob/set-up-mac/master/.zshrc -P ~
cat ~/.zshrc

# .vimrc (Vim)
echo "Downloading .vimrc"
wget https://raw.githubusercontent.com/jarvisrob/set-up-mac/master/.vimrc -P ~
cat ~/.vimrc


# Make Zsh the default shell
echo 'Making the Homebrew-installed and updated version of Zsh into the default shell. You will be prompted for root password.'
chsh -s /opt/hombrew/bin/zsh


# Apps that need to be installed manually
echo ""
echo "NOTE: The following apps need to be installed manually:"
echo "- Magnet"
echo "- Poly Lens"
echo "- Goodnotes"
echo ""


# End
echo "-- Mac set-up completed. Enjoy! --"
echo "IMPORTANT: Close terminal and re-open to get everything"
echo "IMPORTANT: It's probably a good idea to reboot fisrt anyway"
echo "--"
echo ""
