;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ordinary environment
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; load-path & package initialization
(setq load-path
      (append '("~/.emacs.d/elisp") load-path))
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
(load-theme 'misterioso t)

;; tab setting
(setq num-for-tab-setting 2)
(setq-default tab-width num-for-tab-setting)
(setq default-tab-width num-for-tab-setting)
(setq tab-stop-list())
(while (<= num-for-tab-setting 256)
  (setq tab-stop-list `(,@tab-stop-list ,num-for-tab-setting))
  (setq num-for-tab-setting (+ num-for-tab-setting default-tab-width)))

(setq-default indent-tabs-mode nil)

;;(global-set-key "\C-m" 'newline-and-indent)

;; emacs-client (need .zshrc setting also)
(server-start)

;; python tab setting
(add-hook 'python-mode-hook
          '(lambda ()
             (setq indent-tabs-mode nil)
             (setq indent-level 2)
             (setq python-indent 2)
             (setq tab-width 2)))

;; jedi
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)  

;; flymake
(require 'flymake)
(require 'flymake-cursor)

;; pep8
;; /usr/local/bin/pep8check.sh
(when (load "flymake" t) 
  (defun flymake-pyflakes-init () 
    (let* ((temp-file (flymake-init-create-temp-buffer-copy 
                       'flymake-create-temp-inplace)) 
           (local-file (file-relative-name 
                        temp-file 
                        (file-name-directory buffer-file-name)))) 
      (list "/usr/local/bin/pep8check.sh" (list local-file)))) 
  
  (add-to-list 'flymake-allowed-file-name-masks 
               '("\\.py\\'" flymake-pyflakes-init))) 

(add-hook 'find-file-hook 'flymake-find-file-hook)
(load-library "flymake-cursor")
(global-set-key [f10] 'flymake-goto-prev-error)
(global-set-key [f11] 'flymake-goto-next-error)

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))
(exec-path-from-shell-copy-env "PYTHONPATH")
(exec-path-from-shell-copy-env "PATH")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; setting for mac
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; change font size
(set-frame-font "fontset-15")

;; change japanese font
(set-fontset-font nil 'japanese-jisx0208 (font-spec :family "Hiragino Kaku Gothic ProN"))
(setq face-font-rescale-alist
      '((".*Hiragino_Kaku_Gothic_ProN.*" . 1.2)))

;; clipboard share 

;; (defun copy-from-osx ()
;;  (shell-command-to-string "pbpaste"))
;; (defun paste-to-osx (text &optional push)
;;  (let ((process-connection-type nil))
;;      (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
;;        (process-send-string proc text)
;;        (process-send-eof proc))))
;;(setq interprogram-cut-function 'paste-to-osx)
;;(setq interprogram-paste-function 'copy-from-osx)

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
(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(w)" "|" "STARTED(s)" "CANCELED(c)" "DONE(d)")))
(setq org-todo-keyword-faces
      '(("WAIT" . (:foreground "yellow" :weight bold))
        ("STARTED" . (:foreground "red" :weight bold))
        ("CANCELED" . (:foreground "green" :weight bold))))



;; org confluence export 
(require 'ox-confluence)

;; Make windmove work in org-mode:
(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)

;; js2-mode
;;(require 'js2-mode)
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; js2 indent setting
;; http://witterk.blogspot.jp/2012/04/emacs-no-tab.html
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(js2-basic-offset 2)
 '(tab-width 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; rotate.el
(require 'rotate)
(global-set-key (kbd "C-t") 'rotate-window)

;; recentf mode
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; whiitespace setting
(setq whitespace-style
      '(tabs tab-mark spaces space-mark))
(setq whitespace-space-regexp "\\(\x3000+\\)")
(setq whitespace-display-mappings
      '((space-mark ?\x3000 [?\□])
        (tab-mark   ?\t   [?\xBB ?\t])
        ))
(require 'whitespace)
(global-whitespace-mode 1)
(set-face-foreground 'whitespace-space "LightSlateGray")
(set-face-background 'whitespace-space "DarkSlateGray")
(set-face-foreground 'whitespace-tab "LightSlateGray")
(set-face-background 'whitespace-tab "DarkSlateGray")

;; taskjuggler-mode
(require 'taskjuggler-mode)

;; split window
(split-window-right)
(other-window 1)
(split-window-below)
(other-window 1)
(other-window 1)
(recentf-open-files)
