(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bold ((t (:weight ultra-bold)))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(package-selected-packages
   (quote
    (rjsx-mode js2-mode doom-themes dired-subtree nix-mode dante webpaste magithub all-the-icons ggtags cmake-project cdlatex magit-svn yaml-mode ws-butler writeroom-mode which-key web-mode web volume use-package undo-tree unbound tuareg toml-mode systemd sml-mode smartparens rust-mode rainbow-delimiters racket-mode projectile powerline pkgbuild-mode pdf-tools org-bullets nginx-mode multiple-cursors mmm-mode markdown-mode magit lua-mode llvm-mode libmpdee ledger-mode keyfreq json-mode jonprl-mode ivy-hydra intero idris-mode hydra gnuplot git-gutter-fringe flycheck-package f expand-region ensime elisp-slime-nav dockerfile-mode dash-functional counsel company-coq cmake-mode clang-format bison-mode auctex ace-window)))
 '(safe-local-variable-values
   (quote
    ((buffer-file-coding-system . utf-8-unix)
     (eval if
           (and
            (buffer-file-name)
            (string-equal
             (file-name-extension
              (buffer-file-name))
             "h"))
           (c++-mode))))))
