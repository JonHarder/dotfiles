;; -*- lexical-binding: t; -*-
(use-package request
  :straight t)

(use-package emacs-opencode
  :straight (:type git :host github :repo "jdormit/emacs-opencode")
  :demand t
  :custom
  (opencode-server-environment
   '(("OPENCODE_CONFIG" . "/Users/jharder/.config/opencode/opencode.emacs.jsonc")))
  (opencode-session-default-agent "build")
  :config
  ;; `opencode-mcp-status' shells out without `opencode-server-environment',
  ;; so it misses the custom OPENCODE_CONFIG and reports no MCP servers.
  ;; Redefine it to apply the same environment used for `opencode serve'.
  (defun opencode-mcp-status ()
	"Display OpenCode's current MCP connections."
	(interactive)
	(let ((process-environment
		   (opencode-connection--process-environment opencode-server-environment)))
	  (async-shell-command
	   (format "%s mcp list" (executable-find opencode-server-command))))))

(use-package mcp-server
  :straight (:type git :host github :repo "rhblind/emacs-mcp-server"
             :files ("*.el" "tools/*.el" "mcp-wrapper.py" "mcp-wrapper.sh"))
  :demand t
  :custom
  ;; Allow the agent to run shell commands / read the environment through
  ;; `emacs_eval-elisp' without being blocked by the MCP security layer.
  ;; Anything NOT listed below either prompts (see the commented toggle) or
  ;; is blocked outright.
  ;; (mcp-server-security-prompt-for-permissions t) ; prompt in minibuffer for everything else
  (mcp-server-security-allowed-dangerous-functions
   '(async-shell-command
     shell-command
     shell-command-to-string
     getenv
     with-current-buffer))
  :config
  (add-hook 'emacs-startup-hook #'mcp-server-start-unix))

(defvar my-c-c-a-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "a") #'opencode)
    (define-key map (kbd "o") #'opencode-open-session)
    (define-key map (kbd "k") #'opencode-ask-contextual)
    (define-key map (kbd "s") #'opencode-ask)
    (define-key map (kbd "m") #'opencode-mcp-status)
	(define-key map (kbd "r") #'opencode-restart)
    (define-key map (kbd "q") #'opencode-shutdown-all)
    map)
  "Prefix keymap bound to \\[my-c-c-a-map], C-c a, for AI workflows.")
(define-key global-map (kbd "C-c a") my-c-c-a-map)

(provide 'my-ai)
