;(package-initialize)
;(setq server-name "server-proxied")
(setq load-prefer-newer t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("cfa7053f155661faa33ef648f55d524eb97854f8f0ff9ff91a08b3ba47a9a25f" "70b5e506efe625e6a9cf71ddd5dbbf35b960229f32637676647bef873485df09" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "6bf237d23440fb0b340f4336695f2a08c6b785aa98288b3313526e76c38bca19" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "613a7c50dbea57860eae686d580f83867582ffdadd63f0f3ebe6a85455ab7706" default)))
 '(debug-on-error nil)
 '(org-agenda-files
   (quote
    ("~/docs/studium/proseminar/notes.org" "/home/moritz/org/bachelor.org" "/home/moritz/org/einkauf.org" "/home/moritz/org/ghcerrors.org" "/home/moritz/org/hie.org" "/home/moritz/org/job.org" "/home/moritz/org/notes.org" "/home/moritz/org/org.org" "/home/moritz/org/recipe.org" "/home/moritz/org/travel.org" "/home/moritz/org/typetheory.org")))
 '(package-selected-packages
   (quote
    (intero haskell-mode org-bullets cdlatex magit-svn tuareg smartparens racket-mode bison-mode writeroom-mode systemd keyfreq rainbow-delimiters ensime mmm-mode lua-mode f dash-functional pdf-tools dockerfile-mode cmake-mode gnuplot jonprl-mode llvm-mode sml-mode toml-mode rust-mode clang-format nyan-mode nginx-mode yaml-mode web-mode json-mode company-coq ledger-mode unbound markdown-mode multiple-cursors which-key volume hydra prop-menu pkgbuild-mode yasnippet flycheck-package flycheck elisp-slime-nav auctex ace-window expand-region web libmpdee smart-mode-line moe-theme projectile magit magit-popup company-cmake company ws-butler undo-tree pos-tip ivy-hydra counsel swiper use-package)))
 '(safe-local-variable-values
   (quote
    ((haskell-process-args-ghci "ghci" "--with-ghc" "ghci-ng")
     (haskell-process-path-ghci . "stack")
     (haskell-process-type . ghci)
     (haskell-indent-spaces . 2)
     (projectile-project-compilation-cmd . "cd Horn/LLVM/reve/build && make -j8")
     (buffer-file-coding-system . utf-8-unix)
     (eval remove-hook
           (quote write-contents-functions)
           (quote delete-trailing-whitespace))
     (eval remove-hook
           (quote before-save-hook)
           (quote delete-trailing-whitespace)
           t)
     (c-style-alist
      ("ledger"
       (indent-tabs-mode)
       (c-basic-offset . 2)
       (c-comment-only-line-offset 0 . 0)
       (c-hanging-braces-alist
        (substatement-open before after)
        (arglist-cont-nonempty))
       (c-offsets-alist
        (statement-block-intro . +)
        (knr-argdecl-intro . 5)
        (substatement-open . 0)
        (substatement-label . 0)
        (label . 0)
        (case-label . 0)
        (statement-case-open . 0)
        (statement-cont . +)
        (arglist-intro . +)
        (arglist-close . +)
        (inline-open . 0)
        (brace-list-open . 0)
        (topmost-intro-cont first c-lineup-topmost-intro-cont c-lineup-gnu-DEFUN-intro-cont))
       (c-special-indent-hook . c-gnu-impose-minimum)
       (c-block-comment-prefix . "")))
     (eval if
           (and
            (buffer-file-name)
            (string-equal
             (file-name-extension
              (buffer-file-name))
             "h"))
           (c++-mode))
     (eval if
           (string-equal
            (file-name-extension
             (buffer-file-name))
            "h")
           (c++-mode))
     (projectile-project-compilation-cmd . "cd reve/reve/build && make -j8")
     (coq-prog-args "-emacs-U" "-R" "/home/moritz/docs/books/typetheory/cpdt/src" "Cpdt")))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(load "~/.emacs.d/emacs.el")
