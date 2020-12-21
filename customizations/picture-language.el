

(defun get-svg-width (svg)
  "Returns the width of SVG object"
  (cdaadr svg))

(defun get-svg-height (svg)
  "Returns the width of SVG object"
  (cdadar (cdr svg)))
