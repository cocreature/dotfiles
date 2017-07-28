typeset -U path
source ~/.nix-profile/etc/profile.d/nix.sh
path=(~/bin
      ~/.local/bin
      ~/.cabal/bin
      ~/code/arcanist/bin
      ~/.gem/ruby/2.4.0/bin
      ~/.node/bin
      ~/.cargo/bin
      ~/code/go/bin
      $path)
systemctl --user import-environment PATH
