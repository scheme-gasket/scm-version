(define-module (version)
  #:use-module (srfi srfi-9)
  #:use-module (ice-9 regex))

(define-record-type <version>
  (make-version parts)
  version?
  (parts       version-parts   set-version-parts!))

(export <version>)

(define-public (parse-version version-string)
  (let* ((match  (fold-matches "([.:_-]?[0-9]{1,})+" version-string 0
                               (lambda (match count)
                                 match)))
         (bucket (list-matches "[0-9]+" (match:substring match 0))))
    (make-version (map (lambda (match)
                         (string->number (match:substring match 0)))
                       bucket))))
