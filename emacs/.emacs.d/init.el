(load "~/.emacs.d/emacs.el")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values
   (quote
    ((c-style-alist
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
