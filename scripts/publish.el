;; load env
(load "~/.emacs.d/init.el")

;; http://orgmode.org/worg/org-tutorials/org-publish-html-tutorial.html
(require 'ox-publish)

;; TODO(yan): 在下面设置 :html-head 一直有问题
;; 显示 Wrong type: sequencep my-org-publish-html-head
;; 但是在这里如果检查变量的话，的确是满足sequencep的。
;; 暂时找不到原因。不过如果放在 publish.el 下面设置 (setq org-html-head ...) 是可以work的
;; 现在解决方案是将这个处理放在pp-html里面，这样的好处是可以快速地修改样式，
;; 而不用每次对整个项目重新输出，速度更快。
(setq my-org-publish-html-head
      (replace-regexp-in-string
       "root/" "/"
       (get-string-from-file "~/repo/dirtysalt.github.io/themes/setup.txt")))
;; (message my-org-publish-html-head)
;; (when (sequencep my-org-publish-html-head)
;;   (message "IT'S SEQUENCE"))

(setq org-publish-project-alist
      '(("pages"
         :base-directory "~/repo/dirtysalt.github.io/src/"
         :publishing-directory "~/repo/dirtysalt.github.io/html/"
         :recursive nil
         :html-head-include-default-style nil
         ;; TODO(yan): seqeuncep my-org-publish-html-head failed?!
         ;; :html-head my-org-publish-html-head
         :html-head ""
         :publishing-function org-html-publish-to-html
         :with-toc 't)
        ("site" :components ("pages"))))

;; (setq my-org-publish-html-head
;;       (replace-regexp-in-string
;;        "root/" "/"
;;        (get-string-from-file "~/repo/dirtysalt.github.io/themes/setup.txt")))
;; (setq org-html-head my-org-publish-html-head)

(org-publish-project "site")
