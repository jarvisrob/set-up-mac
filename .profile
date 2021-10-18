# Create/configure Homebrew environment variables, including adding Homebrew installations to PATH
eval "$(/opt/homebrew/bin/brew shellenv)"

# Homebrew installed/managed Python and ~/bin to path
# https://docs.brew.sh/Homebrew-and-Python
PATH=/opt/homebrew/opt/python/libexec/bin:$PATH:~/bin

# # conda starts off, so set "name" of current environment to "conda off" so can be used in my custom prompt
# CONDA_DEFAULT_ENV="conda off"

# pyenv
eval "$(pyenv init --path)"
