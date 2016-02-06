(use-modules (version))

(define* (println #:rest args)
  (let recur ((xs args))
    (cond ((null? xs)
           (newline))
          (else
           (display (car xs))
           (recur (cdr xs))))))

(let ((version (parse-version "2.27.1-1")))
  (println (version-majar version))
  (println (version-minor version)))
