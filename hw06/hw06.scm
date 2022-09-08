;;;;;;;;;;;;;;;
;; Questions ;;
;;;;;;;;;;;;;;;

; Scheme

(define (cddr s)
  (cdr (cdr s)))

(define (cadr s)
  (car (cdr s))
)

(define (caddr s)
  (car (cddr s))
)

(define (unique s)
  ; Think of recursion with base case and recursive call etc.
  (if (null? s)
    nil
   (cons (car s) (filter (lambda (x) (not (equal? x (car s)))) 
   (unique (cdr s))))
 )
)

(define (cons-all first rests)
  (if (null? rests)
    nil
  (map (lambda (x) (append (list first) x)) rests)
 )
)


;; List all ways to make change for TOTAL with DENOMS
(define (list-change total denoms)
  (cond
    ((null? denoms) nil)
    ((< total 0) nil)
    ((= total 0) (list()))
    (else
      (append (cons-all (car denoms) 
        (list-change (- total (car denoms)) denoms)) 
          (list-change total (cdr denoms))))
 )
)

; Tail recursion

(define (replicate x n)
  (define (helper x n current_list)
    (if (= n 0)
      current_list
      (helper x (- n 1) (cons x current_list))
 )
)
  (helper x n nil))

(define (accumulate combiner start n term)
  (cond
   ((= n 0) start)
   (else (accumulate combiner (combiner (term n) start) (- n 1) term))
 )
)
; This works as well, but makes accumulate-tail harder:

;   (if (= n 0)
;     start
;     (combiner (accumulate combiner start (- n 1) term) (term n)))
; )


(define (accumulate-tail combiner start n term)
  (cond
   ((= n 0) start)
   (else (accumulate-tail combiner (combiner (term n) start) (- n 1) term))
 )
)

; Macros

(define-macro (list-of map-expr for var in lst if filter-expr)
  `(map (lambda (,var) ,map-expr) (filter (lambda (,var) ,filter-expr) ,lst))
)