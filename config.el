;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Renato Ceolin"
      user-mail-address "renato.ceolin@renatoceolin.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Fira Code" :size 18)
      doom-unicode-font (font-spec :family "Noto Color Emoji")
      doom-variable-pitch-font (font-spec :family "Open Sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; org-journal

(setq org-journal-dir "~/org/journal"
      org-journal-date-format "%A, %d %B %Y")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq flycheck-elixir-credo-strict t)

(setq plantuml-jar-path (expand-file-name "~/.emacs.d/.local/etc/plantuml.jar"))
(setq plantuml-default-exec-mode 'jar)

(setq lsp-enable-file-watchers t)
(setq lsp-file-watch-threshold 20000)
(setq lsp-elixir-fetch-deps t)
(setq vterm-max-scrollback 100000)

(add-hook 'lsp-after-initialize-hook (setq typescript-indent-level 2))

(setq-hook! 'dockerfile-mode-hook +format-with :none)

(map! "M-<up>" #'drag-stuff-up
      "M-<down>" #'drag-stuff-down)

(after! lsp-java
  (setq lsp-java-java-path "~/.asdf/installs/java/openjdk-21.0.2/bin/java"
        lsp-java-import-gradle-wrapper-enabled t
        lsp-java-import-gradle-home nil
        lsp-java-jdt-download-url "https://www.eclipse.org/downloads/download.php?file=/jdtls/milestones/1.40.0/jdt-language-server-1.40.0-202409261450.tar.gz"
        lsp-java-configuration-runtimes
        '[(:name "JavaSE-21"
           :path "~/.asdf/installs/java/openjdk-21.0.2")
          (:name "JavaSE-20"
           :path "~/.asdf/installs/java/corretto-20.0.2.10.1"
           :default t)]
        lsp-java-vmargs (list
                         "-noverify"
                         "--enable-preview"))
  (setq lombok-library-path (concat doom-data-dir "lombok.jar"))

  (unless (file-exists-p lombok-library-path)
    (url-copy-file "https://projectlombok.org/downloads/lombok.jar" lombok-library-path))

  (setq lsp-java-vmargs '("-XX:+UseParallelGC" "-XX:GCTimeRatio=4" "-XX:AdaptiveSizePolicyWeight=90" "-Dsun.zip.disableMemoryMapping=true" "-Xmx4G" "-Xms100m"))

  (push (concat "-javaagent:"
                (expand-file-name lombok-library-path))
        lsp-java-vmargs))

(after! google-java-format
  (setq google-java-format-executable (executable-find "google-java-format")))
