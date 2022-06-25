(setq-default inferior-lisp-program "sbcl")

;; Package manager:
;; Initialise package and add Melpa repository
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(defvar required-packages '(slime
                            smartparens
                            auto-complete
			    evil
			    spacemacs-theme))

(defun packages-installed-p ()
  (cl-loop for package in required-packages
        unless (package-installed-p package)
          do (cl-return nil)
        finally (cl-return t)))

(unless (packages-installed-p)
  (package-refresh-contents)
  (dolist (package required-packages)
    (unless (package-installed-p package)
      (package-install package))))

(package-initialize)
(package-refresh-contents)

;; Enable
(require 'evil)

;; Evil mode
(evil-mode 1)

;; Configuration
(when (version<= "26.0.50" emacs-version)
  (global-display-line-numbers-mode))
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(show-paren-mode t) ; включить выделение выражений между {},[],()
(setq show-paren-style 'parenthesis) ; выделить цветом выражения между {},[],()

(when (packages-installed-p)
  (require 'smartparens-config)
  (smartparens-global-mode)

  (require 'auto-complete-config)
  (ac-config-default)
  (global-auto-complete-mode t)
  (setq-default ac-auto-start t)
  (setq-default ac-auto-show-menu t)
  (defvar *sources* (list
                     'lisp-mode
                     'ac-source-semantic
                     'ac-source-functions
                     'ac-source-variables
                     'ac-source-dictionary
                     'ac-source-words-in-all-buffer
                     'ac-source-files-in-current-dir))
  (let (source)
    (dolist (source *sources*)
      (add-to-list 'ac-sources source)))
  (add-to-list 'ac-modes 'lisp-mode)

  (require 'slime)
  (require 'slime-autoloads)
  (slime-setup '(slime-asdf
                 slime-fancy
                 slime-indentation))
  (setq-default slime-net-coding-system 'utf-8-unix))

(setq-default lisp-body-indent 2)
(setq-default lisp-indent-function 'common-lisp-indent-function)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
