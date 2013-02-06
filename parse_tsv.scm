(use util.list)

(define (update acc expr)
  (let ((key (car (assq-ref expr 'p))))
    (hash-table-update! acc key (cut + 1 <>) 0)
    acc))


(define (->expr line)
  (map (lambda (col) (map string->symbol (string-split col ":")))
       (string-split line "\t")))

(define (main args)
  (define (loop acc)
    (let ((line (read-line)))
      (if (eof-object? line)
        acc
        (loop (update acc (->expr line))))))
  (print (hash-table->alist (loop (make-hash-table 'eq?))))
  0)
