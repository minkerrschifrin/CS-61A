(define (map-stream f s)
    (if (null? s)
    	nil
    	(cons-stream (f (car s)) (map-stream f (cdr-stream s)))))

(define multiples-of-three
  (cons-stream 3 (map-stream (lambda (x) (+ x 3)) multiples-of-three)
 )
)

(define (rle s)
  (define (helper element stream length)
  	(cond
  		((null? stream) (cons-stream (list element length) nil))
  		((= element (car stream)) (helper element (cdr-stream stream) (+ 1 length)))
  		(else (cons-stream (list element length) (rle stream)))
 )
)
  (if (null? s)
  	nil
  	(helper (car s) (cdr-stream s) 1)
 )
)