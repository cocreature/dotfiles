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
    (swiper counsel ivy-hydra ivy go-mode rjsx-mode js2-mode doom-themes dired-subtree nix-mode dante webpaste magithub all-the-icons ggtags cmake-project cdlatex magit-svn yaml-mode ws-butler writeroom-mode which-key web-mode web volume use-package undo-tree unbound tuareg toml-mode systemd sml-mode smartparens rust-mode rainbow-delimiters racket-mode projectile powerline pkgbuild-mode pdf-tools org-bullets nginx-mode multiple-cursors mmm-mode markdown-mode magit lua-mode llvm-mode libmpdee ledger-mode keyfreq json-mode jonprl-mode intero idris-mode hydra gnuplot git-gutter-fringe flycheck-package f expand-region ensime elisp-slime-nav dockerfile-mode dash-functional company-coq cmake-mode clang-format bison-mode auctex ace-window)))
 '(safe-local-variable-values
   (quote
    ((intero-targets "irbuilder:lib" "irbuilder:test:irbuilder")
     (intero-targets "servant-match:lib" "servant-match:test:test")
     (eval let
           ((default-directory
              (locate-dominating-file buffer-file-name ".dir-locals.el")))
           (setq-local coq-prog-args
                       (\`
                        ("-coqlib"
                         (\,
                          (expand-file-name ".."))
                         "-R"
                         (\,
                          (expand-file-name "."))
                         "Coq")))
           (setq-local coq-prog-name
                       (expand-file-name "../bin/coqtop")))
     (eval progn
           (let
               ((coq-root-directory
                 (when buffer-file-name
                   (locate-dominating-file buffer-file-name ".dir-locals.el")))
                (coq-project-find-file
                 (and
                  (boundp
                   (quote coq-project-find-file))
                  coq-project-find-file)))
             (set
              (make-local-variable
               (quote tags-file-name))
              (concat coq-root-directory "TAGS"))
             (setq camldebug-command-name
                   (concat coq-root-directory "dev/ocamldebug-coq"))
             (unless coq-project-find-file
               (set
                (make-local-variable
                 (quote compile-command))
                (concat "make -C " coq-root-directory))
               (set
                (make-local-variable
                 (quote compilation-search-path))
                (cons coq-root-directory nil)))
             (when coq-project-find-file
               (setq default-directory coq-root-directory))))
     (intero-targets "hsfmt:lib" "hsfmt:exe:hs-fmt" "hsfmt:test:properties")
     (haskell-stylish-on-save . t)
     (ispell-dictionary . "en_US")
     (eval
      (lambda nil
        (when
            (string=
             (file-name-extension
              (or
               (buffer-file-name)
               ""))
             "v")
          (verilog-mode))))
     (eval
      (lambda nil
        (when
            (or
             (string=
              (file-name-extension
               (buffer-file-name))
              "v")
             nil)
          (verilog-mode))))
     (eval
      (lambda nil
        (when
            (string=
             (file-name-extension
              (buffer-file-name))
             "v")
          (verilog-mode))))
     (eval lambda nil
           (message
            (buffer-file-name)))
     (eval setq auto-mode-alist
           (\`
            (("\\.v" . verilog-mode)
             \, auto-mode-alist)))
     (buffer-file-coding-system . utf-8-unix)
     (eval if
           (and
            (buffer-file-name)
            (string-equal
             (file-name-extension
              (buffer-file-name))
             "h"))
           (c++-mode))))))
