{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ExtendedDefaultRules #-}
module MyAntigen where

import Antigen
       (AntigenConfig(..), defaultConfig, bundle, antigen, antigenSourcingStrategy,
        filePathsSourcingStrategy, sourcingStrategy)

bundles =
  [bundle "zsh-users/zsh-syntax-highlighting"
  ,bundle "zsh-users/zsh-history-substring-search"
  ,(bundle "sindresorhus/pure") {sourcingStrategy =
                                   filePathsSourcingStrategy
                                     ["async.zsh","pure.plugin.zsh"]}
  ,(bundle "rupa/z") {sourcingStrategy = antigenSourcingStrategy}]

config = defaultConfig { plugins = bundles }

main :: IO ()
main = antigen config
