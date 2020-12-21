;;; package --- functions for making a histogram

;;; Commentary:


;;; Code:



(defun make-histo (values)
  "Make a histogram of VALUES."
  (let ((hist-max (apply #'max values)))
    (forward-line (- 0 hist-max))
    (end-of-line)
    (dolist (val values)
      (dotimes (count hist-max)
	(if (<= (- hist-max count) val)
	    (insert "# ")
	  (insert "  "))
	(forward-line 1)
	(end-of-line))
      (forward-line (- 0 hist-max))
      (end-of-line))
    (forward-line hist-max)
    (end-of-line)
    (mapcar (lambda (x) (insert (number-to-string x) " ")) values)))


(defun make-histogram (value-str)
  "Make a histogram of VALUE-STR, which is a list of values separated by whitespace."
  (interactive "sEnter Values (separated by whitespace): ")
  (make-histo (mapcar #'string-to-number (split-string value-str))))


(provide 'histogram)

;;; histogram.el ends here
