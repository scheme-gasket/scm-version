(use-modules (version)
             (srfi srfi-1)
             (rnrs io ports)
             (ice-9 regex))

(define* (println #:rest args)
  (let recur ((xs args))
    (cond ((null? xs)
           (newline))
          (else
           (display (car xs))
           (recur (cdr xs))))))

(system "yaourt -Q | sort > ./installed.list")

(call-with-input-file "./installed.list"
  (lambda (input)
    (let recur ((line (get-line input)))
      (cond ((eof-object? line) #f)
            (else
             (println line)
             (let ((result (parse-version line)))
               (println result))
             (recur (get-line input)))))))

