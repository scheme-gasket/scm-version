(use-modules (version)
             (srfi srfi-64))

(test-begin "02-compare")

(test-assert (version>?  "3.6.3" "3.6.0"))
(test-assert (version>=? "3.5.3" "3.5.0"))

(test-end "02-compare")
