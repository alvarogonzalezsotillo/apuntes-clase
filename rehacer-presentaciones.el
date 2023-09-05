
(defun es-presentacion-p (filename)
  (let* ((contents (org-file-contents filename)))
    (string-match-p "/common/footer.org" contents)))

(defun lista-de-orgs (directory)
  (directory-files-recursively directory ".*\.org$" ))


(defun lista-de-presentaciones (directory)
  (let* ((all-orgs (lista-de-orgs directory))
         (presentations (seq-filter #'es-presentacion-p all-orgs)) )
    presentations))


(defun recrea-presentaciones ()
  (dolist (orgfile (lista-de-presentaciones default-directory))
    (message "%s" orgfile)
    (save-window-excursion
      (find-file orgfile)
      (ags/reveal-y-pdf)
      )
    ))

(recrea-presentaciones)


