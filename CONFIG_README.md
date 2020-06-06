link to base instructions https://www.atlassian.com/git/tutorials/dotfiles

managing zsh plugins with the config via reddit

I would recommend not using a plugin manager. Instead, manage your plugins the same way you manager zshrc and other dotfiles.

First of all, if you aren't yet storing your dotfiles in a Git repository, start doing so. There are many ways to do this but one of them stands apart in its convenience, ease of use and power. I'm talking about storing dotfiles in a bare Git repository. Follow the linked tutorial. It's quite straightforward.

Now, if you want to use zsh-autosuggestions (it's really great), add it as a submodule to your dotfiles Git repository:

config submodule add -b master https://github.com/zsh-users/zsh-autosuggestions.git
And add one line to your ~/.zshrc:

source ~/zsh-autosuggestions/zsh-autosuggestions.zsh
That's it. Now you can utilize the power of Git to manage your plugins. For example, to update everything to the latest version:

config submodule update --remote
Review what's changed and commit if everything looks normal and zsh still works. Something broken after update? Revert. Your whole zsh configuration is now versioned. With plugin managers only a small part gets versioned -- the part that you put in zshrc.

Some plugin managers provide extra features that you might want to have. Thankfully, they are not difficult to implement without giving up control over your configuration. For example, some plugin managers can convert zsh files into bytecode before sourcing them. This speeds up zsh startup. Let's see how we can do this for zsh-autosuggestions.

# If there is no *.zsh.zwc or it's older than *.zsh, compile *.zsh into *.zsh.zwc.
if [[ ! ~/zsh-autosuggestions/zsh-autosuggestions.zsh.zwc -nt ~/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  zcompile ~/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
source ~/zsh-autosuggestions/zsh-autosuggestions.zsh
Not too complicated but repeating the same file name 4 times doesn't look pretty. To cut down on boilerplate, create a helper function so that you can write this:

source-compiled ~/zsh-autosuggestions/zsh-autosuggestions.zsh
There is no plugin manager that can load plugins faster than this but there are some that can defer the loading of plugins until zsh has nothing else to do and is sitting there waiting for user input. This feature is once again fairly simple and doesn't require a plugin manager. For example, he's how the loading of zsh-autosuggestions can be deferred with zsh-defer:

zsh-defer source-compiled ~/zsh-autosuggestions/zsh-autosuggestions.zsh
To sum up, with this approach you are:

in full control over your configuration (understanding what happens when you start zsh is very useful)

relying on standard tools (Git, zsh) that behooves you to know anyway since this knowledge will transfer to many other tasks

enjoying fast zsh startup

able to update plugins individually to any revision you like or to revert what doesn't work

