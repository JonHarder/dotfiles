(straight-use-package 'terraform-mode)
(provide 'my-terraform-mode)

(setq terraform-format-on-save t)

(defun terraform-init ()
  (interactive)
  (compile "terraform init"))

(defun terraform-plan ()
  (interactive)
  (compile "terraform plan"))

(defun terraform-apply ()
  (interactive)
  (compile "terraform apply"))

(provide 'my-terraform-mode)
