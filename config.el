;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
 ;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
;; (setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(defun my/regular-font ()
  (interactive)
  (setq doom-font (font-spec :family "Monoplex Nerd" :size 16.0 :weight 'regular)
        ;; doom-variable-pitch-font (font-spec :family "Iosevka Comfy Motion Duo" :size 20)
        )
  (doom/reload-font)
  (menu-bar-mode 1)
  (tool-bar-mode 1)
  )

(setq doom-modeline-time nil)
(setq doom-modeline-time-icon nil)
(setq doom-modeline-minor-modes nil)
(setq doom-modeline-support-imenu t)
(setq doom-modeline-enable-word-count nil)
;; (setq doom-modeline-continuous-word-count-modes '(markdown-mode gfm-mod)) ; org-mode

(after! doom-modeline
  (setq doom-modeline-icon nil)

  (setq doom-modeline-height 35)
  (setq doom-modeline-bar-width 4)

  (setq doom-modeline-persp-name t) ; doom nil
  (setq doom-modeline-buffer-file-name-style 'truncate-upto-project) ; default 'auto

  (setq doom-modeline-repl t)
  (setq doom-modeline-github t)
  (setq doom-modeline-lsp t)
  (setq doom-modeline-indent-info t)
  (setq doom-modeline-hud nil))


;; Over-ride or add to Doom Emacs default key bindings
;; https://discourse.doomemacs.org/t/what-are-leader-and-localleader-keys/153
;; 'M-m', '\,' 'SPC m' for localleader
(setq doom-localleader-key ","
      doom-localleader-alt-key "C-,")

(defun my/call-localleader ()
  (interactive)
  (setq unread-command-events (listify-key-sequence ",")))
(map! :leader (:desc "+major-mode" "m" #'my/call-localleader))
 ;; (global-set-key (kbd "M-m") #'my/call-localleader)

(progn
  (setq default-input-method "korean-hangul")
  (set-language-environment "Korean")

  ;; (setq default-transient-input-method "TeX")

  (set-keyboard-coding-system 'utf-8)
  (setq locale-coding-system 'utf-8)
  (prefer-coding-system 'utf-8)
  (set-charset-priority 'unicode)
  (set-default-coding-systems 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (setq-default buffer-file-coding-system 'utf-8-unix)

  (set-selection-coding-system 'utf-8) ;; important
  (setq coding-system-for-read 'utf-8)
  (setq coding-system-for-write 'utf-8)

  ;; Treat clipboard input as UTF-8 string first; compound text next, etc.
  (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

  (setq-default line-spacing 3)

  ;; (setenv "LANG" "en_US.UTF-8")
  ;; (setenv "LC_ALL" "en_US.UTF-8")
  ;; (setenv "LANG" "ko_KR.UTF-8")

  ;; 날짜 표시를 영어로한다. org mode에서 time stamp 날짜에 영향을 준다.
  (setq system-time-locale "C")

  (setq input-method-verbose-flag nil
        input-method-highlight-flag nil)

  (global-set-key (kbd "<S-SPC>") 'toggle-input-method)
  ;; (global-set-key (kbd "<Alt_R>") 'toggle-input-method)
  (global-set-key (kbd "<Hangul>") 'toggle-input-method)
  ;; (global-unset-key (kbd "S-SPC"))
  )

(customize-set-variable 'user-emacs-directory "/sdcard/emacs/cache/")
(setq doom-cache-dir user-emacs-directory)
(customize-set-variable 'bookmark-save-flag 1) ; Save bookmark list immediately when it has been updated.
(after! recentf
  (progn
    (setq recentf-max-saved-items 200) ; Set it to whatever you prefer, the default is too small
    (add-hook 'find-file-hook 'recentf-save-list)))

(after! evil-escape
  (setq evil-escape-key-sequence ",.") ;; "jk"
 (setq evil-escape-unordered-key-sequence nil)
  (setq evil-escape-delay 1.0) ;; 0.5, default 0.1
  (evil-escape-mode 1))

(global-visual-line-mode 1)

(add-hook 'doom-after-init-hook 'my/regular-font)
