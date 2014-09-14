{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ExtendedDefaultRules #-}
module MyAntigen where

import Antigen (AntigenConfiguration (..), bundle, antigen)
import Shelly (shelly, verbosely)

bundles = [ bundle "zsh-users/zsh-syntax-highlighting"
          , bundle "zsh-users/zsh-history-substring-search"
          , bundle "zsh-users/zaw"
          , bundle "Javafant/pure"]

config = AntigenConfiguration bundles

main :: IO ()
main = shelly $ verbosely $ antigen config
