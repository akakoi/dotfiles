;; Linux Mint 12 emacs environment.
;; last updated: <2012/08/10 16:13>
;; author a.kakoi<akihiro.kakoi@nts.ricoh.co.jp>
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Global setting.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; language Japanese/coding utf-8
; 言語を日本語にする
(set-language-environment 'Japanese)
; 極力UTF-8とする
(prefer-coding-system 'utf-8)


;display time
(display-time-mode 1)
;display line number
(line-number-mode 1)
; disable beep.
(setq visible-bell t)
; disable startup message
(setq inhibit-startup-screen t)
; lean scratch 
(setq initial-scratch-message "")
; disable tool bar
(setq tool-bar-mode -1)
;disable menu bar
(setq menu-bar-mode -1)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; C/C++ file<->mode association.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq auto-mode-alist
      (append '(("\\.C$"  . c++-mode)
                ("\\.cc$" . c++-mode)
                ("\\.cpp$". c++-mode)
                ("\\.hh$" . c++-mode)
                ("\\.c$"  . c-mode)
                ("\\.h$"  . c++-mode))
              auto-mode-alist))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; C Lang.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'c-mode-common-hook
          '(lambda ()
             (c-set-style "k&r")
	          (setq c-basic-offset 4)
		       (setq indent-tabs-mode t)
		            (setq tab-width 4)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Flymake(自動シンタックスチェック)
;; #Sample Makefile for emacs flymake
;; CC= g++
;; CFLAGS= -Wall
;; INCLUDES = .
;; # SRC= $(shell find . -type f -mmin -30 -regex ".*.cpp")
;; check-syntax:
;; $(CC) -o nul $(CFLAGS) $(INCLUDES) -S ${CHK_SOURCES}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'flymake)
; C++
; http://d.hatena.ne.jp/pyopyopyo/20070715/
(add-hook 'c++-mode-hook
  '(lambda ()
      (flymake-mode t)))

(add-hook 'c-mode-hook
  '(lambda ()
      (flymake-mode t)))


(global-set-key [f3] 'flymake-display-err-menu-for-current-line)
(global-set-key [f4] 'flymake-goto-next-error)

;; http://d.hatena.ne.jp/sugyan/20110510/1305036104
;;
(global-set-key "\M-e" 'flymake-goto-next-error)
(global-set-key "\M-E" 'flymake-goto-prev-error)

;; gotoした際にエラーメッセージをminibufferに表示する
(defun display-error-message ()
  (message (get-char-property (point) 'help-echo)))
(defadvice flymake-goto-prev-error (after flymake-goto-prev-error-display-message)
  (display-error-message))
(defadvice flymake-goto-next-error (after flymake-goto-next-error-display-message)
  (display-error-message))
(ad-activate 'flymake-goto-prev-error 'flymake-goto-prev-error-display-message)
(ad-activate 'flymake-goto-next-error 'flymake-goto-next-error-display-message)

;; C
;; http://d.hatena.ne.jp/nyaasan/20071216/p1
;; (defun flymake-c-init ()
;;   (let* ((temp-file   (flymake-init-create-temp-buffer-copy
;; 		       'flymake-create-temp-inplace))
;; 	 (local-file  (file-relative-name
;; 		       temp-file
;; 		       (file-name-directory buffer-file-name))))
;;     (list "gcc" (list "-Wall" "-Wextra"  "-fsyntax-only " local-file))))
;; (add-to-list 'flymake-allowed-file-name-masks
;; 	     '("\\.\\(c\\|y\\l\\)$" flymake-c-init))

;; C++
;; (defun flymake-cc-init ()
;;   (let* ((temp-file   (flymake-init-create-temp-buffer-copy
;; 		       'flymake-create-temp-inplace))
;; 	 (local-file  (file-relative-name
;; 		       temp-file
;; 		       (file-name-directory buffer-file-name))))
;;     (list "g++" (list "-Wall" "-Wextra" "-fsyntax-only" local-file))))

;; (add-to-list 'flymake-allowed-file-name-masks
;; 	     '("\\.\\(cpp\\|h\\)$" flymake-cc-init))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  auto-install
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path (expand-file-name "~/.emacs.d/auto-install"))
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/auto-install/")
(setq auto-install-use-wget t)
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; anything open anything できる
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'anything-startup)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; auto-complete
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-install/ac-dict")
(ac-config-default)

;auto-complete-etags
(require 'auto-complete-etags)
(add-to-list 'ac-sources 'ac-source-etags)

(setq ac-auto-start 1)
(setq ac-auto-show-menu 0.2)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; update time
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'time-stamp)
(add-hook 'before-save-hook 'time-stamp)
(setq time-stamp-active t)
(setq time-stamp-start "last updated:[ \t]+<")
(setq time-stamp-format "%04y/%02m/%02d %:H:%:M")
(setq time-stamp-end ">")
 
(global-set-key "\C-_" 'undo)