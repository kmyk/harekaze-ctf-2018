(use srfi-13) ; String Libraries
(load "./lazier")
(load "./prelude")
(load "./prelude-numbers")

(lazy-def 'bottom '((lambda (x) (x x)) (lambda (x) (x x))))

;;; list
(lazy-def '(scott->church lst)
 '(lambda (cns nll)
   ((Y (lambda (recur lst)
        (if (null? lst)
          nll
          (cns (car lst) (recur (cdr lst))))))
    lst)))
(lazy-def '(append lst1 lst2) '((scott->church lst1) cons lst2))

;;; string
(define (list->lambda lst nll)
  (if (null? lst)
    nll
    (list 'cons (car lst) (list->lambda (cdr lst) nll))))
(define (string->lambda s nll)
  (list->lambda (map char->integer (string->list s)) nll))

(lazy-def '(compare s)
  '(scott->church s
    (lambda (car-s y t)
      (((= car-s (car t))
        (lambda (p) (cons (car p) (succ (cdr p))))
        (lambda (p) (cons (succ (car p)) (cdr p))))
       (y (cdr t))))
    (lambda (t) (cons 0 0))))
(lazy-def '(make-output result correct wrong)
   '(cdr
      ((car result) (lambda (p) ((car p) (cons i wrong)))
                    ((cdr result) (lambda (p) ((car p) (cons i correct)))
                                  (cons i end-of-output)))))
(lazy-def 'flag (string->lambda "HarekazeCTF{0b2b2edaf742240de97f44840b830d0befd5bb97}" '()))
(lazy-def 'correct (string->lambda "correct flag\n" 'bottom))
(lazy-def 'wrong (string->lambda "wrong flag\n" 'bottom))

(lazy-def '(main input)
  '(make-output
    (compare flag input)
    correct
    wrong))

; (write (laze 'main) (standard-error-port))
; (newline (standard-error-port))
(print-as-unlambda (laze 'main))
