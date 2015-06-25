{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ExtendedDefaultRules #-}
module MyAntigen where

import Antigen (AntigenConfiguration (..), bundle, antigen, antigenSourcingStrategy, filePathsSourcingStrategy, sourcingStrategy)
import Shelly (shelly, verbosely)

bundles =
  [bundle "zsh-users/zsh-syntax-highlighting"
  ,bundle "zsh-users/zsh-history-substring-search"
  ,bundle "zsh-users/zaw"
  ,(bundle "sindresorhus/pure") {sourcingStrategy =
                                   filePathsSourcingStrategy
                                     ["async.zsh","pure.plugin.zsh"]}
  ,(bundle "rupa/z") {sourcingStrategy = antigenSourcingStrategy}]

config = AntigenConfiguration bundles

main :: IO ()
main = shelly $ verbosely $ antigen config
