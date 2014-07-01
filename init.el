;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ordinary environment
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; load-path & package initialization
(setq load-path
      (append '("~/.emacs.d/elisp")
	      load-path))
(add-to-list 'load-path' "~/.emacs.d/elpa")

(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.milkbox.net/packages/")
			 ("org" . "http://orgmode.org/elpa/")))
(package-initialize)

;; japanese environment 
(set-locale-environment nil)
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)

;; C-h assgine BackSpace
(keyboard-translate ?\C-h ?\C-?)
(global-set-key (kbd "C-x ?") 'help-command)

;; disappear error noise in emacs
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;;menu
(setq inhibit-startup-screen t)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(menu-bar-mode 0)
(show-paren-mode 1)
(global-hl-line-mode 1)
(icomplete-mode 1)

;;buffer move keybind (shift + up, down. right, left)
(setq windmove-wrap-around t)
(windmove-default-keybindings)

;; default directory
(setq default-directory "~/") 
(setq command-line-default-directory "~/")

;;color-theme
(load-theme 'zen-and-art t)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; setting for mac
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; change font size
;;(set-frame-font "fontset-15")

;; change japanese font
;; (set-fontset-font nil 'japanese-jisx0208
;; 		  (font-spec :family "Hiragino Kaku Gothic ProN"))
;; (setq face-font-rescale-alist
;;       '((".*Hiragino_Kaku_Gothic_ProN.*" . 1.2)))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; setting for windows
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; avoid "<M-kanji> is undifined"
;;(global-set-key [M-kanji] 'ignore)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; lisp settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; auto-install
(when (require 'auto-install nil t)
  (setq auto-install-directory "~/.emacs.d/elisp/")
  (auto-install-update-emacswiki-package-name t)
  (auto-install-compatibility-setup))

;;anything
(require 'anything-startup)

;;auto-complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp/ac-dict")
(ac-config-default)

;; yasnippet
(require 'yasnippet)
(yas/global-mode t)

;; malabar
(require 'cedet)
(global-ede-mode 1)

;;(semantic-load-enable-minimum-features) ;; or enable more if you wish
(require 'malabar-mode)
(setq  alabar-groovy-lib-dir "/path/to/malabar/lib")
(add-to-list 'auto-mode-alist '("\\.java\\'" . malabar-mode))
      
;;undo-tree
(require 'undo-tree)
(global-undo-tree-mode)

;;flymake
(require 'flymake)

;; org-mode
(require 'org)

;; org confluence export 
(require 'ox-confluence)

;; Make windmove work in org-mode:
(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)
		    
