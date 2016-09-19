;; Testing for Emacs lisp
(defun hello ()
  "Hello World and you can call it via M-x hello."
  (interactive)
  (message "Hello World!")
  (split-window-right)
  )

;;; init-open-bookmark.el --- Open recentf immediately after Emacs is started -*- coding: utf-8 ; lexical-binding: t -*-

;; Copyright (C) 2015 USAMI Kenta

;; Author: USAMI Kenta <tadsan@zonu.me>
;; Created: 26 Oct 2015
;; Version: 0.0.1
;; Package-Version: 20160528.2330
;; Keywords: file bookmark after-init-hook
;; Package-Requires: ((emacs "24.4"))

;; This file is NOT part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; Open bookmark immediately after Emacs is started.
;; If files are opend, does nothing.  Open bookmark otherwise.
;; (For example, it is when execute by specifying the file from command line.)
;; This script uses only advice function for startup.  Do not have interactive function.
;; (This approach's dirty hack, but the hook to be the alternative does not exist.)
;;
;; put into your own .emacs file (~/.emacs.d/init.el)
;;
;;   (init-open-bookmark)
;;
;; `init-open-bookmark' Support helm, ido, anything (or nothing).
;; Determine from your environment, but it is also possible that you explicitly.
;;
;;   (setq init-open-bookmark-interface 'ido)
;;   (init-open-bookmark)
;;
;; If you want to do another thing, you can specify an arbitrary function.
;;
;;   (setq init-open-bookmark-function #'awesome-open-recentf)
;;   (init-open-bookmark)
;;

;;; Code:
(require 'cl-lib)
(require 'bookmark)

(defgroup init-open-bookmark nil
  "init-open-bookmark"
  :group 'emacs)

(defcustom init-open-bookmark-function
  nil
  "Function to open bookmark files (or other)."
  :type '(function :tag "Invoke bookmark (or other) function")
  :group 'init-open-bookmark)

(defcustom init-open-bookmark-interface
  nil
  "Interface to open bookmark files."
  :type '(radio (const :tag "Use ido interface" 'ido)
                (const :tag "Use helm interface" 'helm)
                (const :tag "Use anything intereface" 'anything)
                (const :tag "Use Emacs default (bookmark-open-files)" 'default)
                (const :tag "Select automatically" 'nil))
  :group 'init-open-bookmark)

(defvar init-open-bookmark-before-hook nil
  "Run hooks before `init-open-bookmark-open'.")

(defvar init-open-bookmark-after-hook nil
  "Run hooks after `init-open-bookmark-open'.")

(defun init-open-bookmark-buffer-files ()
  "Return list of opened file names."
  (let ((found-files '()))
    (dolist (buffer (buffer-list))
      (with-current-buffer buffer
        (when buffer-file-name
          (cl-pushnew buffer-file-name found-files))))
    found-files))

(defun init-open-bookmark-interface ()
  ""
  (or init-open-bookmark-interface
      (cond
       ((and (boundp 'helm-mode) helm-mode) 'helm)
       ((and (boundp 'ido-mode) ido-mode) 'ido)
       ((fboundp 'anything-bookmark) 'anything)
       (:else 'default))))

(defun init-open-bookmark-dwim ()
  "Open recent file command you want (Do What I Mean)."
  (if init-open-bookmark-function
      (call-interactively init-open-bookmark-function)
    (cl-case (init-open-bookmark-interface)
      ((helm) (helm-bookmarks))
      ((ido) (find-file (ido-completing-read "Find recent file: " bookmark-list)))
      ((anything) (anything-bookmark))
      ((default) (bookmark-open-files)))))

(defun init-open-bookmark-open (&rest dummy-args)
  "If files are opend, does nothing.  Open bookmark otherwise.
`DUMMY-ARGS' is ignored."
  (prog2
      (run-hooks 'init-open-bookmark-before-hook)
      (cond
       ((init-open-bookmark-buffer-files) t)
       ( (init-open-bookmark-dwim))
       (:else
        (error "`bookmark-mode' is not enabled")))
    (run-hooks 'init-open-bookmark-after-hook)
    (advice-remove 'display-startup-screen #'init-open-bookmark-open)))

;;;###autoload
(defun init-open-bookmark ()
  "Set 'after-init-hook ."
  (advice-add 'command-line-1 :after #'init-open-bookmark-open)
  t)

(provide 'init-open-bookmark)
;;; init-open-bookmark.el ends here


(init-open-bookmark)
