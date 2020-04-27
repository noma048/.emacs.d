;;パッケージ管理の初期化
(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;;背景色と文字色を変更
(set-background-color "black")
(set-foreground-color "#ffffff")

;;C-tでウィンドウを切り替える。初期値はtranspose-chars
(define-key global-map (kbd "C-t") 'other-window)

;;カラム番号も表示
(column-number-mode t)

;;左に行番号表示
(require 'linum)
(global-linum-mode)

;;ファイルサイズを表示
(size-indication-mode t)
;;時計を表示(好みに応じてフォーマットを変更可能)
;;(setq display-time-day-and-date t)
(setq display-time-24hr-format t)
(display-time-mode t)

;;タイトルバーにファイルのフルパスを表示
(setq frame-title-format "%f")

;;paren-mode:対応する括弧を強調して表示する
(setq show-paren-delay 0)
(show-paren-mode t)

;;TABの無効化
(setq-default indent-tabs-mode nil)

;;redo+の設定
(when (require 'redo+ nil t)
  (global-set-key (kbd "C-.") 'redo))

;;メニューバー、ツールバー、スクロールバーを消去
(menu-bar-mode t)
(tool-bar-mode t)
(scroll-bar-mode 0)

;; ファイルを開いた位置を保存する
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (concat user-emacs-directory "places"))

;;;括弧の対応を保持して編集する設定
;;(require 'paredit)
;;(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
;;(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
;;(add-hook 'lisp-mode-hook 'enable-paredit-mode)
;;(add-hook 'ielm-mode-hook 'enable-paredit-mode)

;;neotree ディレクトリーツリーを表示
(global-set-key [f8] 'neotree-toggle)
;; 隠しファイルをデフォルトで表示
(setq neo-show-hidden-files t)
;; neotree ウィンドウを表示する毎に current file のあるディレクトリを表示する
(setq neo-smart-open t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (neotree))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; *.~ とかのバックアップファイルを作らない
(setq make-backup-files nil)
;;; .#* とかのバックアップファイルを作らない
(setq auto-save-default nil)
