(use-modules (version)
             (srfi srfi-64))

(test-begin "01-parsing")

(let ((a-version (parse-version "2.27.1-1")))

  (test-equal
   '(2 27 1 1)
   (version-parts a-version))

  (test-equal 
   2
   (version-majar a-version))

  (test-equal 
   27
   (version-minor a-version)))

(test-end "01-parsing")
