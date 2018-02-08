(use srfi-13) ; String Libraries
(load "./lazier")
(load "./prelude")
(load "./prelude-numbers")

;;; string
(define (list->lambda lst nll)
  (if (null? lst)
    nll
    (list 'cons (car lst) (list->lambda (cdr lst) nll))))
(define (string->lambda s nll)
  (list->lambda (map char->integer (string->list s)) nll))

(define (encode s)
  (if (string-null? s)
    '(lambda (input)
       (= (car input) (^ 2 8)))
    (let ((car-s (char->integer (string-ref s 0)))
          (cdr-s (substring s 1 (string-length s))))
      (list 'lambda '(input)
            (list (list '!= '(^ (car input) 2) (list '^ car-s 2))
                  '#f
                  (list (encode cdr-s) '(cdr input)))))))

(define flag "HarekazeCTF{4AD8AA3A3571EA912A6EC5EA5FDCC93C}")
(lazy-def '(main input)
  (list (list (encode flag) 'input)
        (string->lambda "correct flag\n" 'end-of-output)
        (string->lambda   "wrong flag\n" 'end-of-output)))

; (write (laze 'main) (standard-error-port))
; (newline (standard-error-port))
(print-as-unlambda (laze 'main))
