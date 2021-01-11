#!/usr/bin/env bash

# git repositories with xrdb or iterm2 themes
repositories=( \
    https://github.com/mbadolato/iTerm2-Color-Schemes.git \
    https://github.com/hwyncho/ayu-iTerm.git \
    https://github.com/sonph/onehalf.git \
    https://github.com/Relaxed-Theme/relaxed-terminal-themes.git \
    https://github.com/fehawen/iterm2-material-theme.git \
    https://github.com/joshjon/bliss-iterm.git \
    https://github.com/leandromatos/pre-theme.git \
    https://github.com/mattly/iterm-colors-farmhouse.git \
    https://github.com/mattly/iterm-colors-pencil.git \
    https://github.com/mcchrish/iterm-snow.git \
    https://github.com/one-dark/iterm-one-dark-theme.git \
    https://github.com/rakr/hemisu-iterm2.git \
    https://github.com/rileytwo/kiss.git \
    https://github.com/sindresorhus/iterm2-snazzy.git \
    https://github.com/stoeffel/material-iterm.git \
)

# extra files
wget https://raw.githubusercontent.com/aseom/dotfiles/master/osx/iterm2/papercolor-light.itermcolors

for repository in "${repositories[@]}"; do
    git clone --depth 1 "${repository}" repository
    find repository/ -type f -iname '*.xrdb' -or -iname '*.itermcolors' -exec cp {} . \;
    rm -rf repository
done

for file in *.itermcolors; do
    xrdb="$(echo "${file}" | sed "s/.itermcolors/.xrdb/")"
    ! test -f "${xrdb}" && iterm2xrdb "${file}" > "${xrdb}"
done

for file in *.xrdb; do
    xrdb2hterm "${file}" > "$(echo "${file}" | sed "s/.xrdb/.js/")"
done

for file in *.js; do
    sed -i "s|.*\.prefs_\.set|t.prefs_.set|g" "${file}"
done

find . -type f ! -iname '*.js' -exec rm {} +

echo "DONE!"
ls -1 -p
