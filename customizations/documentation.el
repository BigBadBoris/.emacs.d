(require 'dash-docs)
(require 'helm-dash)


(defun remove-docset-path (url)
  "Removes everything in url upto  to .docset."
  (replace-regexp-in-string (dash-docs-docsets-path) "" url))

;; (expand-file-name "~/")

(setq server-ip "0.0.0.0")
(setq server-port "8000")
(setq server-address (concat server-ip ":" server-port ))

(defun dash-docs-result-url (docset-name filename &optional anchor)
  "Return the full, absolute URL to documentation.
Either a file:/// URL joining DOCSET-NAME, FILENAME & ANCHOR with sanitization
 of spaces or a http(s):// URL formed as-is if FILENAME is a full HTTP(S) URL."
  (let* ((clean-filename (replace-regexp-in-string "<dash_entry_.*>" "" filename))
         (path (format "%s%s" clean-filename (if anchor (format "#%s" anchor) ""))))
    (if (string-match-p "^https?://" path)
        path
      (replace-regexp-in-string
       " "
       "%20"
       (remove-docset-path (concat
			    server-address
			    (expand-file-name "Contents/Resources/Documents/" (dash-docs-docset-path docset-name))
			    path))))))

;; (funcall dash-docs-browser-func "0.0.0.0:8000/HTML.docset/Contents/Resources/Documents/developer.mozilla.org/en-US/docs/Web/HTML/Element/select.html")

(setq dash-docs-browser-func 'browse-url-firefox)

;; (browse-url-firefox "0.0.0.0:8000/HTML.docset/Contents/Resources/Documents/developer.mozilla.org/en-US/docs/Web/HTML/Element/select.html")

(defun dash-docs-browse-url (search-result)
  "Call to `browse-url' with the result returned by `dash-docs-result-url'.
Get required params to call `dash-docs-result-url' from SEARCH-RESULT."
  (let ((docset-name (car search-result))
        (filename (nth 2 (cadr search-result)))
        (anchor (nth 3 (cadr search-result))))
    (funcall dash-docs-browser-func (dash-docs-result-url docset-name filename anchor))))
