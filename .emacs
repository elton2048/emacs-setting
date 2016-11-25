(add-to-list 'load-path "~/.emacs.d/indent-guide/")


(add-to-list 'load-path "~/.emacs.d/settings/")
(add-to-list 'load-path "~/.emacs.d/download_plugins/yasnippets-rails/rails-snippets")
(add-to-list 'load-path "~/.emacs.d/snippets")

(load "customfunction")
(load "test")
(load "check")

(setq org-directory "~/notes")
(setq org-agenda-files '("~/notes/tasks.org"))
(setq org-mobile-directory "~/Dropbox/OrgNotes")
(setq org-mobile-files
			(quote ("~/notes/development.org"
							"~/notes/work.org"
							"~/notes/daily_work.org"
							)))
(setq org-mobile-inbox-for-pull 
			;;"~/notes/development.org"
			"~/notes/work.org"
			)
;; (load-file "~/.emacs.d/evernote-mode.el")

;; (require 'evernote-mode)

;; Using superuser to modify the file if necessary
(defadvice ido-find-file (after find-file-sudo activate)
  "Find file as root if necessary."
  (unless (and buffer-file-name
               (file-writable-p buffer-file-name))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
	 [default default default italic underline success warning error])
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
 '(company-dabbrev-downcase nil)
 '(company-idle-delay 0.35)
 '(crux-reopen-as-root-mode t)
 '(custom-enabled-themes (quote (tango-dark)))
 '(display-time-24hr-format t)
 '(display-time-day-and-date t)
 '(electric-indent-mode nil)
 '(evil-overriding-maps
	 (quote
		((Buffer-menu-mode-map)
		 (color-theme-mode-map)
		 (comint-mode-map)
		 (compilation-mode-map)
		 (grep-mode-map)
		 (dictionary-mode-map)
		 (ert-results-mode-map . motion)
		 (Info-mode-map . motion)
		 (speedbar-key-map)
		 (speedbar-file-key-map)
		 (speedbar-buffers-key-map)
		 (anaconda-mode-map))))
 '(global-aggressive-indent-mode t)
 '(menu-bar-mode nil)
 '(package-selected-packages
	 (quote
		(expand-region emmet-mode evil-org helm-projectile projectile edbi indent-guide pdf-tools smart-mode-line org-bullets dired+ crux which-key god-mode anaconda-mode elpy evil-multiedit aggressive-indent helm-swoop magit rainbow-mode company yasnippet yaml-mode window-numbering window-number web-mode typescript-mode smartparens sass-mode highlight-parentheses helm evil color-theme bookmark+ avy-flycheck)))
 '(paradox-github-token t)
 '(python-shell-interpreter-args "")
 '(tool-bar-mode nil)
 '(web-mode-script-padding 0))

;; Set color theme for Emacs
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#453944" :foreground "#eeeeec" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight bold :height 130 :width normal :foundry "nil" :family "Inconsolata"))))
 '(company-scrollbar-bg ((t (:background "antique white"))))
 '(company-scrollbar-fg ((t (:background "SlateBlue2"))))
 '(company-tooltip ((t (:background "gray67" :foreground "black"))))
 '(company-tooltip-selection ((t (:background "cadet blue" :foreground "snow"))))
 '(mode-line ((t (:background "DarkSeaGreen4" :foreground "light yellow" :inverse-video nil :box (:line-width 2 :style pressed-button)))))
 '(sml/global ((t (:foreground "gray90" :inverse-video nil)))))

;; Require MELPA packages
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
  (package-initialize))

;; Override the original key binding or setting for personal usage
(electric-indent-mode +1)
;; Scroll the page when 8 line before the cursor. The scroll is not reseted to the center.
(setq scroll-conservatively 101)

(setq scroll-margin 8)
;; Set the initial size of opening Emacs
(setq initial-frame-alist
			'((top . 30) (left . 1) (width . 140) (height . 40)))
(global-set-key "\C-x\C-b" 'buffer-menu)

;; Set the default indentation of using Emacs
(setq-default indent-tabs-node nil)
(setq-default tab-width 2)
(setq indent-line-funtion 'insert-tab)
(setq org-log-done 'time)
;; Setting the number line on the left side
(global-linum-mode 1)
;; Using helm-M-x using Ctrl-Meta-x
(global-set-key (kbd "C-M-x") 'helm-M-x)
;; ;; Setting of the indent-guide mode(indent-guide.el)
(indent-guide-global-mode)
(set-face-background 'indent-guide-face "transparent")
(set-face-foreground 'indent-guide-face "yellow")

(load "indent-guide")

(require 'dired)
(require 'dired-x)
(require 'dired+)
(setq dired-omit-mode t)				; Turn on Omit mode

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
;; Require plugin undo-tree
(require 'undo-tree)

;; Require Which-Key plugin
(require 'which-key)
(which-key-mode t)
;; Rainbow mode
(define-globalized-minor-mode global-rainbow-mode
  rainbow-mode
  (lambda () (rainbow-mode t)))
(global-rainbow-mode t)

;; Bookmark+ mode
(require 'bookmark+)

;; ido mode
(require 'ido)
(ido-mode t)

;; Require highlight parenthese
(require 'highlight-parentheses)
;; Use it for all buffers
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)

;; Set color theme for Emacs
(require 'color-theme)

;; Open recent file at the beginning
(require 'recentf)
(recentf-mode 1)
;; (init-open-recentf)

;; Evil setting, Vim plugin for Emacs
(setq evil-want-C-u-scroll t)
;; (require 'evil)
;; (evil-mode 1)
;; (define-key evil-motion-state-map (kbd "M-.") nil)

(require 'evil-org)

;; Helm mode
(require 'helm-config)
(helm-mode 1)

;; Set to enable web mode plugin
;; (load "~/web-mode")
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))

(add-to-list 'auto-mode-alist '("\\.erb$" . rhtml-mode))

(require 'emmet-mode)

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
      (let ((web-mode-enable-part-face nil))
        ad-do-it)
    ad-do-it))

;; Use flycheck to check js
;; (require 'flycheck)
;; (add-hook 'js-mode-hook
;;           (lambda () (flycheck-mode t)))
;; (require 'avy-flycheck)

;; (flycheck-define-checker jsxhint-checker
;;   "A JSX syntax and style checker based on JSXHint."

;;   :command ("jsxhint" source)
;;   :error-patterns
;;   ((error line-start (1+ nonl) ": line " line ", col " column ", " (message) line-end))
;;   :modes (web-mode))
;; (add-hook 'web-mode-hook
;;           (lambda ()
;;             (when (equal web-mode-content-type "jsx")
;;               ;; enable flycheck
;;               (flycheck-select-checker 'jsxhint-checker)
;;               (flycheck-mode))))

(require 'sass-mode)

;; Numbered windows
(require 'window-number)
(window-number-mode)
(window-number-meta-mode)

(require 'multiple-cursors)
;; Anaconda-mode setting
(add-hook 'python-mode-hook #'anaconda-mode)
(with-eval-after-load "anaconda"
  (define-key anaconda-mode-map (kbd "M-.") #'anaconda-mode-find-definitions)
	)

;; Yasnippet setting
(require 'yasnippet)
(add-hook 'web-mode-hook #'(lambda () (yas-activate-extra-mode 'html-mode)))
(yas-global-mode 1)
(yas-reload-all 1)
(add-to-list 'yas-snippet-dirs "~/.emacs.d/download_plugins/yasnippets-rails/rails-snippets/")

;; YAML mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

;; Key setting
(defun web-mode-refresh()
  "Refresh the page in web-mode"
  (interactive)
  (web-mode-reload)
  (web-mode-buffer-indent)
  )

;; Key binding setting
(define-key global-map (kbd "M-x") 'helm-M-x)
(define-key global-map (kbd "M-n") 'scroll-up)
(define-key global-map (kbd "M-p") 'scroll-down)
(global-set-key [remap move-beginning-of-line] #'crux-move-beginning-of-line)
;; Avy key setting
(define-key global-map (kbd "M-g M-g") 'avy-goto-line)
(define-key global-map (kbd "C-,") 'avy-goto-char-timer)

(define-key global-map [f12] 'helm-swoop)
(define-key global-map [C-f12] 'helm-multi-swoop)

(define-key global-map [f6] 'eval-buffer)
(define-key global-map [f7] 'evil-mode)
(define-key global-map [f9] 'god-mode)
(define-key web-mode-map [f5] 'web-mode-refresh)
(define-key evil-motion-state-map (kbd "SPC") #'avy-goto-word-1)
(define-key evil-motion-state-map (kbd "C-SPC") #'avy-goto-char)

;; Mode setting for using Evil
(loop for (mode . state) in '((inferior-emacs-lisp-mode . emacs)
                              (nrepl-mode . insert)
                              (pylookup-mode . emacs)
                              (comint-mode . normal)
                              (shell-mode . insert)
                              (git-commit-mode . insert)
                              (git-rebase-mode . emacs)
                              (term-mode . emacs)
                              (grep-mode . emacs)
                              (bc-menu-mode . emacs)
                              (magit-branch-manager-mode . emacs)
                              (rdictcc-buffer-mode . emacs)
                              (dired-mode . emacs)
                              (neotree-mode . emacs)
                              (wdired-mode . normal)
															(help-mode . emacs)
															(paradox-menu-mode . emacs))
      do (evil-set-initial-state mode state))
(add-hook 'after-init-hook 'global-company-mode)

(defun my-web-mode-hook()
  "Hook for indentation."
  (setq web-mode-indent-offset 0)
	(setq web-mode-code-indent-offset 2)
  (setq-local electric-indent-chars
							(append "{}():;," electric-indent-chars))
	;;(local-set-key (kbd "RET") 'newline-and-indent)
  )
(add-hook 'web-mode-hook 'my-web-mode-hook)
(add-hook 'web-mode-hook 'electric-pair-mode)


(loop for (mode . state) in '((inferior-emacs-lisp-mode . emacs)
                              (nrepl-mode . insert)
                              (pylookup-mode . emacs)
                              (comint-mode . normal)
                              (shell-mode . insert)
                              (git-commit-mode . insert)
                              (git-rebase-mode . emacs)
                              (term-mode . emacs)
                              (grep-mode . emacs)
                              (bc-menu-mode . emacs)
                              (magit-branch-manager-mode . emacs)
                              (rdictcc-buffer-mode . emacs)
                              (dired-mode . emacs)
                              (neotree-mode . emacs)
                              (wdired-mode . normal))
      do (evil-set-initial-state mode state))


(require 'evil-multiedit)
;; Part of using the evil-multiedit
;; Highlights all matches of the selection in the buffer.
(define-key evil-visual-state-map "R" 'evil-multiedit-match-all)

;; Match the word under cursor (i.e. make it an edit region). Consecutive presses will
;; incrementally add the next unmatched match.
(define-key evil-normal-state-map (kbd "M-d") 'evil-multiedit-match-and-next)
;; Match selected region.
(define-key evil-visual-state-map (kbd "M-d") 'evil-multiedit-match-and-next)

;; Same as M-d but in reverse.
(define-key evil-normal-state-map (kbd "M-D") 'evil-multiedit-match-and-prev)
(define-key evil-visual-state-map (kbd "M-D") 'evil-multiedit-match-and-prev)

;; OPTIONAL: If you prefer to grab symbols rather than words, use
;; `evil-multiedit-match-symbol-and-next` (or prev).

;; Restore the last group of multiedit regions.
(define-key evil-visual-state-map (kbd "C-M-d") 'evil-multiedit-match-and-prev)
(define-key evil-visual-state-map (kbd "C-M-d") 'evil-multiedit-restore)

;; RET will toggle the region under the cursor
(define-key evil-multiedit-state-map (kbd "RET") 'evil-multiedit-toggle-or-restrict-region)

;; ...and in visual mode, RET will disable all fields outside the selected region
(define-key evil-motion-state-map (kbd "RET") 'evil-multiedit-toggle-or-restrict-region)

;; For moving between edit regions
(define-key evil-multiedit-state-map (kbd "C-n") 'evil-multiedit-next)
(define-key evil-multiedit-state-map (kbd "C-p") 'evil-multiedit-prev)
(define-key evil-multiedit-insert-state-map (kbd "C-n") 'evil-multiedit-next)
(define-key evil-multiedit-insert-state-map (kbd "C-p") 'evil-multiedit-prev)

;; Ex command that allows you to invoke evil-multiedit with a regular expression, e.g.
(evil-ex-define-cmd "ie[dit]" 'evil-multiedit-ex-match)

;; JAVA setting
;; (require 'company)
;; (require 'company-emacs-eclim)
;; (company-emacs-eclim-setup)
;; (setq help-at-pt-display-when-idle t)
;; (setq help-at-pt-timer-delay 0.1)
;; (help-at-pt-set-timer)

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
;; backwards compatibility as default-buffer-file-coding-system
;; is deprecated in 23.2.
(if (boundp 'buffer-file-coding-system)
    (setq-default buffer-file-coding-system 'utf-8)
  (setq default-buffer-file-coding-system 'utf-8))

;; Treat clipboard input as UTF-8 string first; compound text next, etc.
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
(defvar universal-coding-system-env-list '("PYTHONIOENCODING")
  "List of environment variables \\[universal-coding-system-argument] should set")

(defadvice universal-coding-system-argument (around provide-env-handler activate)
  "Augments \\[universal-coding-system-argument] so it also sets environment variables

Naively sets all environment variables specified in
`universal-coding-system-env-list' to the literal string
representation of the argument `coding-system'.

No guarantees are made that the environment variables set by this advice support
the same coding systems as Emacs."
  (let ((process-environment (copy-alist process-environment)))
    (dolist (extra-env universal-coding-system-env-list)
      (setenv extra-env (symbol-name (ad-get-arg 0))))
    ad-do-it))


