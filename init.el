;;パッケージ管理の初期化
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

;; load-path
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))

;;引数のディレクトリとそのサブディレクトリをload-pathに追加
(add-to-load-path "elisp" "conf" "public_repos")

;;背景色と文字色を変更
(set-background-color "black")
(set-foreground-color "#ffffff")

;;tabやスペースの可視化
;;(global-whitespace-mode 1)

;;C-mにnewline-and-indentを割り当てる。初期値はnewline
;;(define-key global-map (kbd "C-m") 'newline-and-indent)

;;C-tでウィンドウを切り替える。初期値はtranspose-chars
(define-key global-map (kbd "C-t") 'other-window)

;;カラム番号も表示
(column-number-mode t)

 ;\左に行番号表示
(require 'linum)
(global-linum-mode)

;;ファイルサイズを表示
(size-indication-mode t)
;;時計を表示(好みに応じてフォーマットを変更可能)
;;(setq display-time-day-and-date t)
;;(setq display-time-24hr-format t)
(display-time-mode 0)
  
;;バッテリー残量を表示
(display-battery-mode 0)
;;タイトルバーにファイルのフルパスを表示
(setq frame-title-format "%f")
;;paren-mode:対応する括弧を強調して表示する
(setq show-paren-delay 0)
(show-paren-mode t)

;;auto-installの設定
(when (require 'auto-install nil t)
  (setq auto-install-use-wget t)  ;;オフライン時の対処
  (setq auto-install-directory "~/.emacs.d/elisp/")
  (auto-install-update-emacswiki-package-name t)
  (auto-install-compatibility-setup))


;; lisp directory's path
;;(add-to-load-path "~/.emacs.d/lisp")
;; load
;;(load "makebackupfile")

;; Auto Complete
(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories
	       "~/.emacs.d/elisp/ac-dict")
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
  (ac-config-default))

;;TABキーで自動補完を有効にする
(ac-set-trigger-key "TAB")

;;TABの無効化
(setq-default indent-tabs-mode nil)

;; undo-tree を読み込む
(when (require 'undo-tree)
;; undo-tree を起動時に有効にする
(global-undo-tree-mode))

;;multi-termの設定
(when (require 'multi-term nil t)
  ;;使用するシェルの設定
  (setq multi-term-program "/bin/bash"))

;;howmメモ保存の場所
(setq howm-directory (concat user-emacs-directory "../howm"))
;;howm-menuの言語を日本語に
(setq howm-menu-lang 'ja)
;;howmメモを一日1ファイルにする
;;(setq howm-file-name-format "%Y/%m/%Y-%m-%d.howm")
;;howm-modeを読み込む
(when (require 'howm-mode nil t)
  ;;C-cでhowm-menuを起動
  (define-key global-map (kbd "C-c ,,") 'howm-menu))
;;howmメモを保存と同時に閉じる
(defun howm-save-buffer-and-kill ()
  "howmメモを保存と同時に閉じます。 "
  (interactive)
  (when (and (buffer-file-name)
	     (string-match "\\.howm" (buffer-file-name)))
    (save-buffer)
    (kill-buffer nil)))
(define-key howm-mode-map (kbd "C-c C-c") 'howm-save-buffer-and-kill)

;;redo+の設定
(when (require 'redo+ nil t)
  (global-set-key (kbd "C-.") 'redo))

;;メニューバー、ツールバー、スクロールバーを消去
(menu-bar-mode t)
(tool-bar-mode 0)
(scroll-bar-mode 0)

;; ファイルを開いた位置を保存する
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (concat user-emacs-directory "places"))

;;
(require 'ace-jump-mode)
(setq ace-jump-mode-gray-background nil)
(setq ace-jump-word-mode-use-query-char nil)
(setq ace-jump-mode-move-keys
(append "asdfghjkl;:]qwertyuiop@zxcvbnm,." nil))
(global-set-key (kbd "C-:") 'ace-jump-word-mode)

;;大文字入力を楽にする @を入力した後ローマ時を入力すると大文字になるよ
(require 'sticky)
(use-sticky-key ?@ sticky-alist:ja)

;; anything
(require 'anything-startup)
(global-set-key "\C-q" 'anything-for-files)

;;;試行錯誤用ファイルを開くための設定
(require 'open-junk-file)
;;C-x C-zで試行錯誤用ファイルを開く
(global-set-key (kbd "C-x C-z") 'open-junk-file)

;;;式の評価結果を注釈するための設定
(require 'lispxmp)
;;emacs-lisp-modeでC-c C-dを押すと注釈される
(define-key emacs-lisp-mode-map (kbd "C-c C-d") 'lispxmp)

;;;括弧の対応を保持して編集する設定
(require 'paredit)
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)
(add-hook 'ielm-mode-hook 'enable-paredit-mode)

(require 'maxframe)
;;; マルチモニターのときはメインモニターの幅を設定する
;; (setq mf-max-width 1600)
;;(add-hook 'window-setup-hook 'maximize-frame nil)

;;neotree ディレクトリーツリーを表示
(global-set-key [f8] 'neotree-toggle)
;; 隠しファイルをデフォルトで表示
(setq neo-show-hidden-files t)
;; neotree ウィンドウを表示する毎に current file のあるディレクトリを表示する
(setq neo-smart-open t)

;;Mewの設定
(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)
(setq mew-fcc "+outbox") ; 送信メールを保存
(setq exec-path (cons "/usr/bin" exec-path))

;;molokai
(load-theme 'molokai t)