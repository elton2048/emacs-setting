(defun window-half-height ()
  (max 1 (/ (1- (window-height (selected-window))) 2)))
   
(defun scroll-up-half ()
  (interactive)
  (scroll-up (window-half-height)))

(defun scroll-down-half ()         
  (interactive)                    
  (scroll-down (window-half-height)))

(defun django-html-hook ()
  (setq engine web-mode-engine)
  ;;(message web-mode-engine)
  (when (string-match "\\.html\\'" (buffer-file-name))
	(web-mode-set-engine "django")
	)
  (when (string-equal web-mode-engine "django")
	(electric-pair-local-mode 0)
	(message "TRUE")
	)
  )


(defun newline-without-break-of-line ()
  "1. move to end of the line.
  2. insert newline with index"

  (interactive)
  (let ((oldpos (point)))
    (end-of-line)
    (newline-and-indent)))
  
