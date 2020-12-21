;; Set C code style

;;; Code:

(setq c-default-style "linux"
      c-basic-offset 8)


;;
;; ggtags
;;

;; Before Using ggtags or helm-gtags, remember to create a GTAGS
;; database by running `gtags` at project root

(require 'ggtags)
;; enable ggtags for C, C++, Java, and Asm mode (plus derivatives)
(add-hook 'c-mode-common-hook
	  (lambda ()
	    (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
	      (ggtags-mode 1))))

(define-key ggtags-mode-map (kbd "C-c g s") 'ggtags-find-other-symbol)
(define-key ggtags-mode-map (kbd "C-c g h") 'ggtags-view-tag-history)
(define-key ggtags-mode-map (kbd "C-c g r") 'ggtags-find-reference)
(define-key ggtags-mode-map (kbd "C-c g f") 'ggtags-find-file)
(define-key ggtags-mode-map (kbd "C-c g c") 'ggtags-create-tags)
(define-key ggtags-mode-map (kbd "C-c g u") 'ggtags-find-update-tags)

(define-key ggtags-mode-map (kbd "M-,") 'pop-tag-mark)


;;
;; code completion
;;

(require 'company)

;; enable company mode EVERYWHERE
(add-hook 'after-init-hook 'global-company-mode)

;;
;; syntax-error checking
;;

(require 'flycheck)

;; enable flycheck for C, C++, Java, and Asm mode
(add-hook 'after-init-hook #'global-flycheck-mode)


(defun add-linux-kernel-source-path (linux-path include-dirs)
  "Add each INCLUDE-DIRS in LINUX-PATH to flycheck search path."
  (dolist (dir include-dirs)
    (add-to-list 'flycheck-clang-include-path (concat linux-path dir))
    (add-to-list 'flycheck-gcc-include-path (concat linux-path dir))))


;; (add-hook 'flycheck-mode-hook
;; 	  (lambda ()
;; 	    (let ((ti-sdk-linux-path "/opt/ti-tools/sdk-linux-am335x/board-support/linux-4.19.94-ti-r42/")
;; 		  (ti-sdk-linux-include-dirs (list "arch/arm/include/"
;; 						   "arch/arm/include/uapi/"
;; 						   "arch/arm/include/generated/"
;; 						   "arch/arm/include/generated/uapi"
;; 						   "include/"
;; 						   "include/uapi/"))
;; 		  (gcc-defines (list "__KERNEL__=1"
;; 				     "ARCH=arm"))
;; 		  (gcc-args (list "-nostdinc"
;; 				  ;"-isystem\ /opt/ti-tools/sdk-linux-am335x/linux-devkit/sysroots/x86_64-arago-linux/usr/bin/../lib/gcc/arm-linux-gnueabihf/8.3.0/include/"
;; 				  "-isystem /usr/lib/gcc/x86_64-linux-gnu/9/include/")))
;; 	      (add-linux-kernel-source-path ti-sdk-linux-path ti-sdk-linux-include-dirs)
;; 	      (dolist (definition gcc-defines)
;; 		(add-to-list 'flycheck-gcc-definitions definition)
;; 		(add-to-list 'flycheck-clang-definitions definition))
;; 	      (dolist (arg gcc-args)
;; 		(add-to-list 'flycheck-gcc-args arg)
;; 		(add-to-list 'flycheck-clang-args arg))
;; 	      (setq flycheck-checker-error-threshold 1000))))

(defun flycheck-set-arm-cross-compile ()
  "Set flycheck checker to arm cross compiler."
  (interactive)
  (let* ((ti-sdk-path "/opt/ti-tools/sdk-linux-am335x")
	 (linux-devkit-path (concat ti-sdk-path "/linux-devkit"))
	 (isystem (concat linux-devkit-path "/sysroots/x86_64-arago-linux/usr/lib/gcc/arm-linux-gnueabihf/8.3.0/include"))
	 (cross-compile (concat linux-devkit-path "/sysroots/x86_64-arago-linux/usr/bin/arm-linux-gnueabihf-"))
	 (c-compiler (concat cross-compile "gcc"))
	 (kernel-dir (concat ti-sdk-path "/board-support/linux-4.19.94-ti-r42"))
	 (includes (list
		    (concat kernel-dir "/include/linux/compiler_types.h")
		    (concat kernel-dir "/include/linux/kconfig.h")
		    (concat kernel-dir "/include/generated/autoconf.h")))
	 (arglist (list
		   "-std=gnu89"
		   "-DKBUILD_MODNAME=\"j2k_driv\""
		   "-DKBUILD_BASENAME=\"j2k_driv\""
		   "-DMODULE"
		   "-msoft-float"
		   "-march=armv7-a"
		   "-D__LINUX_ARM_ARCH__=7"
		   "-marm"
		   "-D__KERNEL__"
		   ;(concat kernel-dir "/include/generated/autoconf.h")
		   ;"-include"
		   ;(concat kernel-dir "/include/linux/compiler_types.h")
		   ;"-include"
		   ;(concat kernel-dir "/include/linux/kconfig.h")
		   ;"-include"
		   (concat "-I" kernel-dir "/include/generated/uapi")
		   (concat "-I" kernel-dir "/include/uapi")
		   (concat "-I" kernel-dir "/arch/arm/include/generated/uapi")
		   (concat "-I" kernel-dir "/arch/arm/include/uapi")
		   (concat "-I" kernel-dir "/include")
		   (concat "-I" kernel-dir "/arch/arm/include/generated")
		   (concat "-I" kernel-dir "/arch/arm/include")
		   isystem
		   "-isystem"
		   "-nostdinc")))
    (setq flycheck-checker 'c/c++-gcc) ; set checker to gcc
    (setq flycheck-c/c++-gcc-executable c-compiler) ; set executable to cross-compiler
    (dolist (arg arglist) ; add each ARG in ARGLIST to gcc argument list
      (add-to-list 'flycheck-gcc-args arg))
    (dolist (header includes)
      (add-to-list 'flycheck-gcc-includes header))))


;; only run flycheck on buffer save to prevent slowdowns
(setq flycheck-check-syntax-automatically '(mode-enabled save))

;;; M-x gendoxy-tag and M-x gendoxy-tag-header
(load "gendoxy.el")

;; C editing utilities

(defun generate-c-header ()
  "Generate a c header guard based on the name of the current buffer."
  (interactive)
  (let ((name (concat "__" (upcase (replace-regexp-in-string ".h" "_H" (buffer-name))))))
    (insert "#ifndef " name "\n")
    (insert "#define " name "\n\n\n\n")
    (insert "#endif" "  /* " name " */")
    (forward-line -2)))


;;; c-editing.el ends here
