;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; User Identify (optional)
;; e.g. GPG configuration, email clients, file templates and snippets
(setq user-full-name "junghanacs"
      user-mail-address "junghanacs@gmail.com")

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

;;;; better default

;; 'tags-completion-at-point-function' break ten-glossary
(setq-default completion-at-point-functions nil) ; important

;; (setq-default display-line-numbers-width-start t) ; doom's default t
(setq inhibit-compacting-font-caches t)

;; Stop asking abount following symlinks to version controlled files
(setq vc-follow-symlinks t)

(global-auto-revert-mode 1) ; doom nil
(setq auto-revert-interval 10)

;; default 120 emacs-29, 60 emacs-28
(setq kill-ring-max 30) ; keep it small

;; Disable .# lock files
(setq create-lockfiles nil)

;; Denote 23.9. Speed up backlinks’ buffer creation?
;; Prefer ripgrep, then ugrep, and fall back to regular grep.
(setq xref-search-program
      (cond ((or (executable-find "ripgrep") (executable-find "rg")) 'ripgrep)
       ((executable-find "ugrep") 'ugrep) (t 'grep)))

;;; overide doomemacs

(setq bookmark-default-file (concat org-directory "/android/emacs-bookmarks.el"))
(setq bookmark-use-annotations nil)
(setq bookmark-automatically-show-annotations t)

(progn
  (require 'dabbrev)
  (setq dabbrev-abbrev-char-regexp "[가-힣A-Za-z-_]")
  (setq dabbrev-upcase-means-case-search nil) ; default t
  (setq dabbrev-ignored-buffer-regexps
        '("\\` "
          "\\.\\(?:pdf\\|jpe?g\\|png\\)\\'"
          "\\(?:\\(?:[EG]?\\|GR\\)TAGS\\|e?tags\\|GPATH\\)\\(<[0-9]+>\\)?"))
  (setq dabbrev-abbrev-skip-leading-regexp "[$*/=~']"))

;;;; dired

(after! dired
  (setq dired-make-directory-clickable t) ; Emacs 29.1, doom t
  (setq dired-free-space nil) ; Emacs 29.1, doom first

  ;; Better dired flags:
  ;; `-l' is mandatory
  ;; `-a' shows all files
  ;; `-h' uses human-readable sizes
  ;; `-F' appends file-type classifiers to file names (for better highlighting)
  ;; -g     like -l, but do not list owner
  (setq dired-listing-switches "-AGFhgv --group-directories-first --time-style=long-iso") ;; doom "-ahl -v --group-directories-first"
  (setq dired-recursive-copies 'always ; doom 'always
        dired-dwim-target t) ; doom t
  (setq dired-ls-F-marks-symlinks nil ; doom nil -F marks links with @
        delete-by-moving-to-trash t) ; doom nil

  (setq dired-use-ls-dired t)  ; doom t
  (setq dired-do-revert-buffer t) ; doom nil
  ;; (setq dired-clean-confirm-killing-deleted-buffers t) ; doom nil
  ;; (setq dired-kill-when-opening-new-dired-buffer t) ; doom nil

  (require 'wdired)
  (setq wdired-allow-to-change-permissions t) ; doom nil
  (setq wdired-create-parent-directories t)

  (add-hook 'dired-mode-hook
            (lambda ()
              (interactive)
              (setq-local truncate-lines t) ; Do not wrap lines
              ;; (visual-line-mode -1)
              (hl-line-mode 1)))
  (add-hook 'dired-mode-hook 'dired-hide-details-mode)
  (remove-hook 'dired-mode-hook 'dired-omit-mode)

  (evil-define-key 'normal dired-mode-map
    (kbd "C-c C-e") 'wdired-change-to-wdired-mode
    (kbd "C-c l") 'org-store-link
    (kbd "C-x /") 'dired-narrow-regexp
    (kbd ".") 'consult-line
    ;; (kbd "K") 'dired-kill-subdir
    (kbd "K") 'dired-do-kill-lines
    ;; (kbd "F") 'evil-avy-goto-line-below ;; 2024-01-25 useful
    (kbd "h") 'dired-up-directory
    (kbd "RET") 'dired-find-file
    (kbd "l") 'dired-find-file
    (kbd "S-<return>") 'dired-find-file-other-window
    ;; evil-force-normal-state
    (kbd "q") 'casual-dired-tmenu
    (kbd "S-SPC") 'dired-toggle-marks
    )
  )


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

;;;; corfu

(after! corfu
  ;; (setq corfu-auto-delay 0.5) ; doom 0.24
  (setq corfu-auto-prefix 4) ; doom 2, default 3
  ;; (setq corfu-preselect 'valid) ; doom 'prompt
  ;; (setq tab-always-indent t) ; for jump-out-of-pair - doom 'complete
  (setq +corfu-want-minibuffer-completion nil) ; doom t

  (setq +corfu-want-tab-prefer-expand-snippets nil)
  (setq +corfu-want-tab-prefer-navigating-snippets nil)
  (setq +corfu-want-tab-prefer-navigating-org-tables nil)

  ;; HACK: Prevent the annoting completion error when no `ispell' dictionary is set, prefer `cape-dict'
  (when (eq emacs-major-version 30)
    (setq text-mode-ispell-word-completion nil))

  ;; IMO, modern editors have trained a bad habit into us all: a burning need for
  ;; completion all the time -- as we type, as we breathe, as we pray to the
  ;; ancient ones -- but how often do you *really* need that information? I say
  ;; rarely. So opt for manual completion:
  ;; doom/hlissner-dot-doom/config.el
  ;; (setq corfu-auto nil)

  ;; default 'C-S-s'
  (define-key corfu-map (kbd "M-.") '+corfu-move-to-minibuffer)
  )

;;;; Font Test:

;; Font test: " & ' ∀ ∃ ∅ ∈ ∉ ∏ ∑ √ ∞ ∧ ∨ ∩ ∪ ∫ ² ³ µ · × ∴ ∼
;; ≅ ≈ ≠ ≡ ≤ ≥ < > ⊂ ⊃ ⊄ ⊆ ⊇ ⊥ ∂ ∇ ∈ ∝ ⊕ ⊗ ← → ↑ ↓ ↔ ⇐ ⇒ ⇔
;; □ ■ | © ¬ ± ° · ˜ Γ Δ α β γ δ ε φ ∀, ∃, ￢(~), ∨, ∧,⊂, ∈,
;; ⇒, ⇔ 𝑀＜1
;; 𝑻𝑼𝑽𝗔𝗕𝗖𝗗 𝞉𝞩𝟃 ϑϕϰ ⊰⊱⊲⊳⊴⊵⫕ 𝚢𝚣𝚤𝖿𝗀𝗁𝗂

;;; Input-method +Hangul

;; +------------+------------+
;; | 일이삼사오 | 일이삼사오 |
;; +------------+------------+
;; | ABCDEFGHIJ | ABCDEFGHIJ |
;; +------------+------------+
;; | 1234567890 | 1234567890 |
;; +------------+------------+
;; | 일이삼사오 | 일이삼사오 |
;; | abcdefghij | abcdefghij |
;; +------------+------------+
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

(after! evil
  ;; C-h is backspace in insert state
  ;; (setq evil-want-C-h-delete t) ; default nil
  (setq evil-want-C-w-delete t) ; default t
  (setq evil-want-C-u-scroll t) ; default t

  ;; use C-i / C-o  evil-jump-backward/forward
  ;; (setq evil-want-C-i-jump t) ; default nil

  ;;  /home/junghan/sync/man/dotsamples/vanilla/mpereira-dotfiles-evil-clojure/configuration.org
  ;; FIXME: this correctly causes '*' to match on whole symbols (e.g., on a
  ;; Clojure file pressing '*' on 'foo.bar' matches the whole thing, instead of
  ;; just 'foo' or 'bar', BUT, it won't match 'foo.bar' in something like
  ;; '(foo.bar/baz)', which I don't like.
  ;; (setq-default evil-symbol-word-search t)
  ;; (setq evil-jumps-cross-buffers nil)
  (setq evil-want-Y-yank-to-eol t) ; doom t

  ;; 'Important' Prevent the cursor from moving beyond the end of line.
  ;; Don't move the block cursor when toggling insert mode
  (setq evil-move-cursor-back nil) ; nil is better - default t
  (setq evil-move-beyond-eol nil) ; default nil

  (setq +evil-want-o/O-to-continue-comments nil) ; doom t
  (setq +default-want-RET-continue-comments nil) ; doom t

  (setq evil-want-fine-undo t) ; doom 'nil

  ;; Don't put overwritten text in the kill ring
  (setq evil-kill-on-visual-paste nil) ; default t
  ;; Don't create a kill entry on every visual movement.
  ;; More details: https://emacs.stackexchange.com/a/15054:
  (fset 'evil-visual-update-x-selection 'ignore)

  ;; Prevent evil-motion-state from shadowing previous/next sexp
  (with-eval-after-load 'evil-maps
    (define-key evil-motion-state-map "L" nil)
    (define-key evil-motion-state-map "M" nil)

    ;; Replace Emacs Tabs key bindings with Workspace key bindings
    ;; replace "." search with consul-line in Evil normal state
    ;; use default "/" evil search

    ;; disable evil macro
    (define-key evil-normal-state-map (kbd "q") 'nil) ; evil macro disable
    (define-key evil-normal-state-map (kbd "Q") 'evil-record-macro)

    ;; o :: ace-link-info 이거면 충분하다.
    (define-key evil-insert-state-map (kbd "C-]") 'forward-char) ; very useful

    ;; =C-w= 'insert 'evil-delete-backward-word
    ;; =C-w= 'visual 'evil-window-map
    ;; use evil bindings $ ^

    ;; M-d region delete and C-d char delete
    (define-key evil-insert-state-map (kbd "C-d") 'delete-forward-char)

    ;; Don't put overwritten text in the kill ring
    ;; evil-delete-char -> delete-forward-char
    (define-key evil-normal-state-map "x" 'delete-forward-char)
    (define-key evil-normal-state-map "X" 'delete-backward-char)
    )

  ;; evil-org
  (with-eval-after-load 'evil-org
    ;; (evil-define-key 'insert 'evil-org-mode-map (kbd "C-d") 'delete-forward-char)
    (evil-define-key 'normal 'evil-org-mode-map "x" 'delete-forward-char)
    ;; (evil-define-key 'insert 'evil-org-mode-map (kbd "C-k") 'org-kill-line)
    ;; (evil-define-key 'insert 'org-mode-map (kbd "C-k") 'org-kill-line)
    (evil-define-key 'normal 'evil-org-mode-map "X" 'delete-backward-char))
  )

(after! evil-escape
  (setq evil-escape-key-sequence ",.") ;; "jk"
  (setq evil-escape-unordered-key-sequence nil)
  (setq evil-escape-delay 1.0) ;; 0.5, default 0.1
  (evil-escape-mode 1))

;;;; sdcard/emacs/cache

(customize-set-variable 'user-emacs-directory "/sdcard/emacs/cache/")
(setq doom-cache-dir user-emacs-directory)
(customize-set-variable 'bookmark-save-flag 1) ; Save bookmark list immediately when it has been updated.
(after! recentf
  (progn
    (setq recentf-max-saved-items 200) ; Set it to whatever you prefer, the default is too small
    (add-hook 'find-file-hook 'recentf-save-list)))

;;;; visual-line-mode

;; (global-visual-line-mode 1)

;;;; org-journal

;; (require 'side-journal)
(progn
  (require 'org-journal)
  (setq org-journal-carryover-items  "TODO=\"TODO\"|TODO=\"NEXT\"")

  (setq org-journal-dir (concat org-directory "journal"))
  (setq org-journal-file-format "%Y%m%dT000000--%Y-%m-%d__journal_week%W.org")
  (setq org-journal-date-format "%Y-%m-%d %a") ; Week%W:

  ;; (setq org-journal-date-prefix "#+title: ")
  ;; (setq org-journal-time-prefix "** ") ; default **
  ;; (setq org-journal-time-format "%R ") ; "[%<%Y-%m-%d %a %H:%M>]" ; default "%R "

  (setq org-journal-enable-agenda-integration t) ; default nil
  (setq org-journal-file-type 'weekly) ; default 'daily

  (setq org-journal-tag-alist '(("meet" . ?m) ("dev" . ?d) ("idea" . ?i) ("emacs" . ?e) ("discuss" . ?c) ("1on1" . ?o))) ; default nil

  ;; (add-hook 'org-mode-hook (lambda () (setq-local tab-width 8)))
  ;; (add-hook 'org-journal-mode-hook (lambda () (setq-local tab-width 8)))

  ;; (defun my/org-journal-add-custom-id ()
  ;;   ;;  :CUSTOM_ID: h:20250321
  ;;   (unless (org-journal--daily-p)
  ;;     (org-set-property "CUSTOM_ID" (format-time-string "h:%Y-%m-%d"))))

  ;; (add-hook 'org-journal-after-header-create-hook #'my/org-journal-add-custom-id)
  )

;;;;; emacs-lisp-mode-hook


(add-hook
 'emacs-lisp-mode-hook
 (lambda ()
   ;; Emacs' built-in elisp files use a hybrid tab->space indentation scheme
   ;; with a tab width of 8. Any smaller and the indentation will be
   ;; unreadable. Since Emacs' lisp indenter doesn't respect this variable it's
   ;; safe to ignore this setting otherwise.
   ;; (setq-local tab-width 8)
   (setq-local comment-column 0)
   (define-key emacs-lisp-mode-map (kbd "M-[") 'backward-sexp)
   (define-key emacs-lisp-mode-map (kbd "M-]") 'forward-sexp)))

;;;;; aggressive-indent

(use-package! aggressive-indent
  :defer 1
  :if window-system
  :config
  (add-hook 'emacs-lisp-mode-hook 'aggressive-indent-mode))

;;;; pkm

;;;;; denote confuguration

(use-package! denote
  :demand t
  :commands
  (denote denote-create-note denote-insert-link denote-show-backlinks-buffer denote-link-ol-store)
  :init
  (setq denote-directory org-directory)
  (require 'denote-org)
  (require 'denote-silo)
  (require 'denote-sequence)
  ;; (require 'denote-journal)
  (require 'denote-org)
  ;; (require 'denote-markdown)

  (setq denote-file-type 'org)
  (setq denote-sort-components '(signature title keywords identifier))
  (setq denote-backlinks-show-context nil)
  (setq denote-sort-keywords t)
  (setq denote-infer-keywords t)
  (setq denote-excluded-directories-regexp "screenshot")
  (setq denote-org-front-matter
        "#+title:      %1$s
,#+filetags:   %3$s
,#+hugo_lastmod: %2$s
,#+date:       %2$s
,#+identifier: %4$s
,#+export_file_name: %4$s.md
,#+description:
,#+hugo_tags: temp
,#+hugo_categories: Noname
,#+print_bibliography:\n* History\n- %2$s\n* Related-Notes\n\n")

  ;; Automatically rename Denote buffers using the `denote-rename-buffer-format'.
  (setq denote-prompts '(subdirectory title keywords)) ; These are the minimum viable prompts for notes
  (setq denote-date-prompt-use-org-read-date t) ; And `org-read-date' is an amazing bit of tech

  ;; More functionality
  (setq denote-org-store-link-to-heading nil ; default t
        denote-rename-confirmations nil ; default '(rewrite-front-matter modify-file-name)
        denote-save-buffers t) ; default nil
  (add-hook 'org-mode-hook (lambda ()
                             (setq denote-rename-buffer-backlinks-indicator "¶")
                             (setq denote-rename-buffer-format "%t%b")
                             (denote-rename-buffer-mode +1)))

  ;; (use-package! consult-notes
  ;;   :defer 2
  ;;   :commands (consult-notes consult-notes-search-in-all-notes)
  ;;   :config
  ;;   (setq consult-notes-denote-display-id t)
  ;;   (setq consult-notes-denote-dir t)
  ;;   (setq consult-notes-denote-title-margin 2) ; 24
  ;;   (consult-notes-denote-mode 1)
  ;;   )

  (use-package! citar-denote
    :after citar
    :demand t ;; Ensure minor mode is loaded
    :bind (:map org-mode-map
           ("C-c B" . citar-insert-citation)
           :map minibuffer-local-map
           ("M-r" . vertico-repeat))
    :commands
    (citar-create-note citar-open-notes citar-denote-open citar-denote-add-citekey)
    :init
    (require 'bibtex)
    (require 'citar)
    :custom
    ;; (citar-open-always-create-notes t)
    ;; (citar-denote-signature t)
    (citar-denote-file-type 'org)
    (citar-denote-subdir t)
    (citar-denote-keyword "bib")
    (citar-denote-title-format "author-year-title") ; default title
    (citar-denote-use-bib-keywords nil)
    (citar-denote-title-format-authors 1)
    (citar-denote-title-format-andstr "and")
    :config
    (citar-denote-mode))
  )

;;;;; denote-explore

(use-package! denote-explore)

;;;;; denote-search

(use-package! denote-search)

;;;;; ten

(use-package! ten
  :defer 2
  ;; :hook ((org-mode Info-mode) . ten-font-lock-mode) ;; text-mode
  :init
  (setq ten-exclude-regexps '("/\\."))
  :config
  (require 'consult-ten)
  (add-to-list 'consult-buffer-sources 'consult-ten-glossary 'append) ; g
  (setq ten-glossary-files-and-directories
        (mapcar (lambda (filename)
                  (concat org-directory "dict/" filename))
                '("20240913T145640--general__glossary.txt"
                  "20240913T150903--philosophy__glossary.txt"
                  "20240913T150904--philosophy-all__glossary.txt"
                  "20241109T120829--physics__glossary.txt"
                  "20241109T123634--math__glossary.txt"
                  "20241112T121549--it-terms__glossary.txt")))
  (setq user-ten-tags-file (concat org-directory "dict/ten-TAGS"))
  (setq user-ten-glossary-files
        (concat org-directory "dict/20240913T145640--general__glossary.txt"))
  )


;;;;; biblio - citar

(progn
  (require 'citar)
  (setq citar-notes-paths (list (concat org-directory "bib/")))
  ;; (defvar config-bibfiles (list (concat user-org-directory "bib/zotero-biblatex.bib")))
  (defvar config-bibfiles (list
                           (concat org-directory "resources/Slipbox.bib")
                           (concat org-directory "resources/Book.bib")
                           (concat org-directory "resources/Category.bib")
                           ))
  (setq citar-bibliography config-bibfiles)
  (setq org-cite-global-bibliography config-bibfiles)

  ;; use #+cite_export: csl apa.csl
  (setq org-cite-csl-styles-dir (concat org-directory ".csl"))
  (setq citar-citeproc-csl-styles-dir (concat org-directory ".csl"))
  ;; (setq citar-citeproc-csl-locales-dir "~/.csl/locales")
  (setq citar-citeproc-csl-style "apa.csl") ; ieee.csl
  (setq citar-symbol-separator " ")

  ;; (require 'citar-citeproc)
  ;; (setq citar-format-reference-function 'citar-citeproc-format-reference)
  (setq citar-format-reference-function 'citar-format-reference)

  (setq
   citar-templates
   '((main . ;; [${urldate:10}]
      "[${dateadded:10}] \{${datemodified:10}\} ${author editor:20} ${translator:8} (${date year issued:4}) @${=key= id:16} ${title:68} ")  ; 2024-09-12 김정한
     (suffix
      . "${shorttitle:25} ${=type=:10} ${namea:16} ${url:20} ${tags keywords:*}") ; 2024-11-17 add url
     (preview
      .
      "${title} :${year issued date:4}\n- ${author} ${translator} ${namea}\n- ${abstract}\n- ${shorttitle}") ; citar-copy-reference
     (note . "#+title: ${author translator:10}, ${title}")))

  (add-hook 'bibtex-mode-hook 'display-line-numbers-mode)
  (setq bibtex-dialect 'biblatex)
  (setq bibtex-align-at-equal-sign t)
  (setq bibtex-text-indentation 20)

  (with-eval-after-load 'savehist
    (add-to-list 'savehist-additional-variables 'citar-history))
  )


;;;; outli

(use-package! outli
  :defer 1
  :init (setq outli-speed-commands nil)
  :config
  ;; (add-to-list 'outli-heading-config '(tex-mode "%%" ?% t))
  (add-to-list 'outli-heading-config '(js2-mode "//" ?\/ t))
  (add-to-list 'outli-heading-config '(js-ts-mode "//" ?\/ t))
  (add-to-list 'outli-heading-config '(typescript-mode "//" ?\/ t))
  (add-to-list 'outli-heading-config '(typescript-ts-mode "//" ?\/ t))
  (add-to-list 'outli-heading-config '(python-mode "##" ?# t))
  (add-to-list 'outli-heading-config '(python-ts-mode "##" ?# t))
  (add-to-list 'outli-heading-config '(awk-mode "##" ?# t))
  (add-to-list 'outli-heading-config '(awk-ts-mode "##" ?# t))
  (add-to-list 'outli-heading-config '(elixir-mode "##" ?# t))
  (add-to-list 'outli-heading-config '(elixir-ts-mode "##" ?# t))
  (add-to-list 'outli-heading-config '(sh-mode "##" ?# t))
  (add-to-list 'outli-heading-config '(bash-ts-mode "##" ?# t))

  (add-to-list 'outli-heading-config '(clojure-mode ";;" ?\; t))
  (add-to-list 'outli-heading-config '(clojurescript-mode ";;" ?\; t))

  (add-hook 'prog-mode-hook 'outli-mode) ; not markdown-mode!
  ;; (add-hook 'org-mode-hook 'outli-mode)
  )

;;;; my/regular-font

(add-hook 'doom-after-init-hook 'my/regular-font)


;;; global-unset-key

(global-unset-key (kbd "<f2>"))

(global-unset-key (kbd "M-a"))  ; unset forward-sentence -> use ')'
(global-unset-key (kbd "M-c"))  ; unset capitalize-word
(global-unset-key (kbd "M-e"))  ; unset backward-sentence -> use '('

;;; Emacs Keys

(global-set-key (kbd "C-M-;") 'pp-eval-expression) ; unbinded key
(global-set-key (kbd "C-M-'") 'eldoc-toggle) ; unbinded key

;;;; embark

(global-set-key (kbd "M-y") #'consult-yank-pop) ; yank-pop
(global-set-key (kbd "M-o") 'embark-act) ;; spacemacs bindings
(global-set-key (kbd "M-O") 'embark-dwim) ;; good alternative: M-.

(global-set-key (kbd "C-h B") 'embark-bindings) ;; alternative for `describe-bindings'

(global-set-key (kbd "C-c l") 'org-store-link)
;; (global-set-key (kbd "C-c L") 'my/org-store-link-id-optional)
(global-set-key (kbd "C-c i") 'org-insert-link)
(global-set-key (kbd "C-c a") 'org-agenda)

;; persp-mode and projectile in different prefixes
;; (setq! persp-keymap-prefix (kbd "C-c w"))
;; (after! projectile
;;   (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

(global-set-key (kbd "M-u") 'evil-scroll-up)
(global-set-key (kbd "M-v") 'evil-scroll-down)

;;;; Extra Fn-key

;; (when (locate-library "imenu-list")
;;   (global-set-key (kbd "<f8>") 'imenu-list-smart-toggle)
;;   (global-set-key (kbd "M-<f8>") 'spacemacs/imenu-list-smart-focus))

(defvar-keymap ews-bibliography-map
  :doc "Bibliograpic functions keymap."

  "b" #'org-cite-insert

  "c" #'citar-open

  "d" #'citar-denote-dwim
  ;; "e" #'citar-open-entry
  "e" #'citar-denote-open-reference-entry

  "a" #'citar-denote-add-reference
  "1" #'citar-denote-find-citation ;; grep [cite @xxx]

  "i" #'citar-insert-citation
  "n" #'citar-create-note
  "o" #'citar-denote-open-note
  "O" #'citar-open-links

  "f" #'citar-denote-find-reference
  "l" #'citar-denote-link-reference

  "s" #'citar-denote-create-silo-note
  "k" #'citar-denote-remove-reference
  )

(defvar-keymap ews-denote-map
  :doc "Denote keybindings."
  "b" ews-bibliography-map
  "B" #'denote-org-backlinks-for-heading
  "d" #'denote-create-note

  "f" #'+default/find-in-notes ; find-files
  ;;   "F" #'+default/browse-notes

  "i" #'denote-org-dblock-insert-links
  "I" #'denote-org-dblock-insert-backlinks

  "l" #'denote-link-or-create
  "L" #'denote-link-after-creating-with-command

  "n" #'consult-notes

  "G" #'consult-notes-search-in-all-notes

  "s" #'denote-silo-open-or-create
  "S" #'denote-silo-select-silo-then-command

  "t" #'denote-type

  "r" #'denote-region ; "contents" mnemonic
  ;; "R" #'denote-rename-file-using-front-matter
  "," #'denote-rename-file-using-front-matter
  "-" #'denote-show-backlinks-buffer

  "SPC" #'org-journal-open-current-journal-file

  "j" #'org-journal-new-entry
  "u" #'org-transclusion-mode

  "k" #'denote-rename-file-keywords
  "z" #'denote-rename-file-signature

  "M-f" #'denote-find-link
  "M-b" #'denote-find-backlink
  )
(keymap-set global-map "C-c n" ews-denote-map)
(keymap-set global-map "M-e" ews-denote-map) ; ews-denote-map

;;; key

;;;; Top-menu M-x

;; 심볼 검색 현재 폴더
;; v expand-region
;; 토글 버퍼

(map! :leader
      "SPC" nil
      ;; "." nil
      ;; "," nil
      :desc "M-x" "SPC" #'execute-extended-command
      :desc "Search for symbol in cwd" "(" #'+default/search-cwd-symbol-at-point

      ;; :desc "Find file in project" "." #'projectile-find-file
      ;; :desc "Find file in cwd" "," #'my/consult-fd
      ;; :desc "consult-buffer" "`" #'consult-buffer
      ;; :desc "Eval expression" "M-;" #'pp-eval-expression
      )

;;;; Replace Doom `/' highlight with buffer-search

(map! :after evil
      :map evil-normal-state-map
      "." #'+default/search-buffer) ;; / -> .

;;;; 'v' er/expand-region

(map! :leader
      :desc "er/expand-region" "v" #'er/expand-region
      ;; :desc "expand-menu" "V" #'expand-transient
      )

;;;; window

;; doom-leader-map w C-S-w 'ace-swap-window

;;;; 'n' +notes denote

(map! :leader
      (:prefix ("n" . "notes")
               "g" #'+default/org-notes-search ; grep
               "d" ews-denote-map
               "SPC" #'org-journal-open-current-journal-file
               ;; "L" #'my/org-store-link-id-optional
               ))

;;;; 'i' insert

(map! :leader
      (:prefix "i"
       :desc "time-stamp" "1" #'time-stamp
       ))

;;;; org-mode-map

(map! (:map org-mode-map
       :ni "C-c H" #'org-insert-heading
       :ni "C-c S" #'org-insert-subheading
       :i "C-n" #'next-line
       :i "C-p" #'previous-line
       :n "C-S-p" #'outline-up-heading
       :n "C-j" #'org-forward-heading-same-level
       :n "C-k" #'org-backward-heading-same-level
       :n "C-n" #'org-next-visible-heading
       :n "C-p" #'org-previous-visible-heading
       :n "zu" #'outline-up-heading
       "C-c d"  #'cape-dict
       :i "<tab>"  #'completion-at-point ; 2025-02-03
       :i "TAB"  #'completion-at-point
       "M--" #'denote-find-backlink
       ))

(map! (:map org-journal-mode-map
       :n "]f"  #'org-journal-next-entry
       :n "[f"  #'org-journal-previous-entry
       :n "C-n" #'org-next-visible-heading ; overide
       :n "C-p" #'org-previous-visible-heading)
      (:map org-journal-search-mode-map
            "C-n" #'org-journal-search-next
            "C-p" #'org-journal-search-previous))

(map! (:map outline-mode-map
       :n "C-n" #'outline-next-heading
       :n "C-p" #'outline-previous-heading
       :i "C-n" #'next-line
       :i "C-p" #'previous-line
       :n "C-S-p" #'outline-up-heading
       :n "zu" #'outline-up-heading)
      )

;;; Custom EVIL Keys

(map! :i "M-l" #'sp-forward-slurp-sexp ; downcase-word
      :i "M-h" #'sp-forward-barf-sexp  ; mark-paragraph
      ;; :v "s" #'evil-surround-region
      ;; "s-b" #'consult-buffer
      ;; "s-=" #'text-scale-increase
      ;; "s--" #'text-scale-decrease
      :n "] p" (cmd! () (evil-forward-paragraph) (recenter)) ; nop
      :n "[ p" (cmd! () (evil-backward-paragraph) (recenter)) ; nop
      ;; :n "DEL" #'previous-buffer
      ;; :n "DEL" #'evil-switch-to-windows-last-buffer ; BACKSPACE
      :n "DEL" #'+vertico/switch-workspace-buffer
      ;; :n "s-e" #'+scroll-line-down-other-window
      ;; :n "s-y" #'+scroll-line-up-other-window
      :i "M-/" #'hippie-expand
      :n "g SPC" #'evil-jump-to-tag
      :i "C-v" #'evil-paste-after ; evil-quoted-insert : 'C-q'
      :n "[ g" #'+vc-gutter/previous-hunk ; remap diff-hl-previous-hunk
      :n "] g" #'+vc-gutter/next-hunk ; remap diff-hl-next-hunk

      :m "8" #'evil-ex-search-word-forward ; default *
      :m "3" #'evil-ex-search-word-backward ; default #
      :m "4" #'evil-end-of-line ; default $
      :m "0" #'evil-beginning-of-line

      ;; :m "C-i" #'evil-jump-forward ;; evil-want-C-i-jump - evil-maps.el
      :n "g ]" #'evil-jump-forward
      :n "g [" #'evil-jump-backward
      )
