# Create/configure Homebrew environment variables, including adding Homebrew installations to PATH
eval "$(/opt/homebrew/bin/brew shellenv)"

# Homebrew installed/managed Python and ~/bin to path
# https://docs.brew.sh/Homebrew-and-Python
PATH=/opt/homebrew/opt/python/libexec/bin:$PATH:~/bin

# pyenv
eval "$(pyenv init --path)"
