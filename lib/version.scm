(define-module (version)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-9)
  #:use-module (ice-9 regex))

(define-record-type <version>
  (make-version parts)
  version?
  (parts       version-parts))

(export <version>
        make-version
        version?
        version-parts)

(define-public (version-majar version)
  ""
  (cond ((version? version)    (car (version-parts version)))
        (else                  #f)))

(define-public (version-minor version)
  ""
  (cond ((version? version)    (cadr (version-parts version)))
        (else                  #f)))

(define-public (parse-version version-string)
  ""
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

(define-public (version-compare left right)
  ""
  (let* ((left-ver    (if (version? left)
                          left
                          (parse-version left)))
         (right-ver   (if (version? right)
                          right
                          (parse-version right)))
         (diff        (remove zero? (map -
                                         (version-parts left-ver)
                                         (version-parts right-ver))))
         (first-part  (car diff)))
    (if (null? first-part)
        '=
        (cond ((positive? first-part)     '>)
              ((negative? first-part)     '<)
              (else                       '?)))))

(define-public (version>? left right)
  ""
  (eq? '> (version-compare left right)))

(define-public (version>=? left right)
  ""
  (case (version-compare left right)
    ((> =)                              #t)
    (else                               #f)))
