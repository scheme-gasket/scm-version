(use-modules (version)
             (srfi srfi-64))

(test-begin "01-parsing")
(let ((version (parse-version "2.27.1-1")))
  (test-equal  2 (version-majar version))
  (test-equal 27 (version-minor version)))
(test-end "01-parsing")
