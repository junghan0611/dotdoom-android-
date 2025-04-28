;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;; (package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/radian-software/straight.el#the-recipe-format
;; (package! another-package
;;   :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;; (package! this-package
;;   :recipe (:host github :repo "username/repo"
;;            :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;; (package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;; (package! builtin-package :recipe (:nonrecursive t))
;; (package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see radian-software/straight.el#279)
;; (package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;; (package! builtin-package :pin "1a2b3c4d5e")

;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;; (unpin! pinned-package)
;; ...or multiple packages
;; (unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;; (unpin! t)

;; doom-disabled-packages

(package! diredfl :disable t) ; conflict @denote
(package! dirvish :disable t)
(package! code-review :disable t) ; not working

;; checkers
(package! flyspell-lazy :disable t)
(package! flymake-popon :disable t)
(package! flycheck-popup-tip :disable t) ; conflict
(package! flycheck-plantuml :disable t)
;; (package! flycheck :disable t)
(package! lsp-mode :disable t) ; use eglot

(package! nose :disable t) ; python module
(package! lsp-python-ms :disable t)

(package! vundo :disable t)
(package! undo-fu-session :disable t)

;; app rss
(package! elfeed-goodies :disable t)

(package! solaire-mode :disable t)
;; (package! ace-window :disable t)

(package! treemacs-nerd-icons :disable t)

;; (package! corfu-popupinfo :disable t)

(package! evil-snipe :disable t)
(package! evil-goggles :disable t)
;; (package! evil-mc :disable t)

;; Disable tty module
(package! evil-terminal-cursor-changer :disable t) ; conflict on kitty
(package! kkp :disable t) ; conflict on term-keys

;;; additional packages

;;;; completion

;;;; ui

;; (unpin! doom-themes)
;; (package! doom-themes :recipe (:host github :repo "junghan0611/doom-themes" :branch "ko"))
;; (package! spacious-padding)
;; (package! keycast)
;; (package! outli :recipe (:host github :repo "jdtsmith/outli" :files ("*.el")))

;;;; for ccmenu

;; (package! transpose-frame)
;; (package! webpaste)
;; (package! google-translate)
;; (package! password-store-menu)
;; (package! google-this)

;;;; denote

(package! denote)
(package! denote-org)
(package! denote-silo)
(package! denote-sequence)
(package! denote-markdown)
(package! denote-journal)

;; (package! denote-explore)
;; (package! denote-search)
;; (package! consult-notes)
;; (package! citar-denote)

;;;; template

;; (package! tempel)
;; (package! tempel-collection)
;; (package! imenu-list :recipe (:host github :repo "junghan0611/imenu-list" :branch "master"))
;; (package! laas)

;;;; llmclient

(package! gptel)
;; (package! gptel-quick :recipe (:host github :repo "karthink/gptel-quick"))

;;;; org extra

;; (package! org-download)
;; (package! org-rainbow-tags)
;; (package! org-glossary :recipe (:host github :repo "tecosaur/org-glossary" :files ("*.el" "*.org" "*.texi")))
;; (package! ten :recipe (:host sourcehut :repo "nobiot/ten")) ;; https://git.sr.ht/~nobiot/ten
;; (package! org-fragtog)          ;; interactive toggling of inline latex formulas
;; (package! org-transclusion)

;;;; code

;; (package! aggressive-indent)
;; (package! geiser-mit :recipe (:host github :repo "emacsmirror/geiser-mit"))

;;;; tools

;; (package! dired-preview)
;; (package! jinx) ; spell checker
;; (package! term-keys :recipe (:host github :repo "junghan0611/term-keys"))
;; (package! nov)

;;;; workspaces

;; (package! tabgo)

;; ;;;; transient

;; (package! ccmenu :recipe (:host github :repo "junghan0611/ccmenu"))
;; (package! casual-suite)
;; (package! nov)

;;; org-mode for latex-preview-auto-mode
