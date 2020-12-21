;;; Package --- A basic parser of libGDX behavior trees
;;; btree.el

;;; Commentary:


(require 'parsec)

(defun btree-import-tok ())

;;; Code:


(setq btree-tokens
      '( 'String
	 'Identifier
	 'Import
	 'Colon
	 'Indent
	 'OpenParen
	 'CloseParen
	 'Number))

(defun btree-string-tok (str)
  (cons 'String str))

(defun btree-spaces ()
  "Parse zero or more spaces."
  (parsec-many-s (parsec-ch ? )))

(defun btree-spaces1 ()
  "Parse one or more spaces."
  (parsec-many1-s (parsec-ch ? )))

(defun btree-import ()
  "Parse a single inport statement."
  (parsec-collect (parsec-and
		   (parsec-str "import")
		   (btree-spaces1)
		   (parsec-re "[a-zA-Z0-9_?]+"))
		  (parsec-and
		   (parsec-str ":")
		   (parsec-between (parsec-str "\"")
				   (parsec-and
				    (parsec-str "\"")
				    (btree-spaces)
				    (parsec-newline))
				   (parsec-many-s (parsec-none-of ?\"))))))

(parsec-with-input "import move:\"com.badlogic.utils.atomic.move\"\nimport grove:\"com.badlogic.ai.grove\"\n"
  (parsec-many
   (btree-import)))

(provide 'btree)
;;; btree.el ends here
