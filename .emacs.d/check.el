(require 'package)
(package-initialize)

(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.

Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     ;; (package-installed-p 'evil)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))

;; make sure to have downloaded archive description.
;; Or use package-archive-contents as suggested by Nicolas Dudebout
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

;; (setq prelude-packages 'evil 'avy 'web-mode 'typescript-mode 'sass-mode 'helm 'window-numbering 'smartparens)

(ensure-package-installed
  'evil 'avy 'web-mode 'typescript-mode 'sass-mode 'helm 'window-numbering 'smartparens) ;  --> (nil nil) if iedit and magit are already installed

;; activate installed packages
(package-initialize)
