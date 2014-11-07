(defvar company-mode-packages
  '(
    company
    company-tern
    ))

(when (boundp 'ycmd-server-command)
  (add-to-list 'company-mode-packages 'ycmd)
  (add-to-list 'company-mode-packages 'company-ycmd))

(defun company-mode/init-company ()
  (use-package company
    :config
    (progn
      (setq company-idle-delay 0.0
            company-minimum-prefix-length 2
            company-require-match nil
            company-transformers '(company-sort-by-occurrence)
            company-dabbrev-ignore-case nil
            company-dabbrev-downcase nil
            company-tooltip-flip-when-above t)

      (global-company-mode 1)

      ; Fix integration of company and yasnippet
      (define-key company-active-map (kbd "TAB") nil)
      (define-key company-active-map (kbd "<tab>") nil)
      (define-key company-active-map [tab] nil)

      (spacemacs//diminish company-mode " Ⓒ"))))

(defun company-mode/init-company-tern ()
   (use-package company-tern
     :defer t
     :config
     (add-to-list 'company-backends 'company-tern)))

(defun company-mode/init-ycmd ()
  (use-package ycmd
    :init
    (progn
      (add-hook 'c++-mode-hook 'ycmd-mode)
      (setq-default ycmd-file-parse-result-hook nil)
      (setq-default ycmd-global-config
                    (expand-file-name "~/.emacs.d/contrib/company-mode/global_conf.py")))))

(defun company-mode/init-company-ycmd ()
  (use-package company-ycmd
    :init (company-ycmd-setup)))
