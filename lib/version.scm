(define-module (version)
  #:use-module (srfi srfi-9)
  #:use-module (ice-9 regex))

(define-record-type <version>
  (make-version parts)
  version?
  (parts       version-parts))

(export <version>)

(define-public (version-majar version)
  (cond ((version? version)    (car (version-parts version)))
        (else                  #f)))

(define-public (version-minor version)
  (cond ((version? version)    (cadr (version-parts version)))
        (else                  #f)))

(define-public (parse-version version-string)
  (let* ((match  (fold-matches "([.:_-]?[0-9]{1,})+" version-string 0
                               (lambda (match count)
                                 match)))
         (bucket (list-matches "[0-9]+" (match:substring match 0))))
    (make-version (map (lambda (match)
                         (let ((subs (match:substring match 0)))
                           (if (string-match "^[0-9]+$" subs)
                               (string->number subs)
                               ;; else
                               subs)))
                         bucket))))
