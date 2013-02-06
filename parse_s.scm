(use util.list)

(define (update acc expr)
  (let ((key (car (assq-ref expr 'p))))
    (hash-table-update! acc key (cut + 1 <>) 0)
    acc))

(define (main args)
  (define (loop acc)
    (let ((expr (read)))
      (if (eof-object? expr)
        acc
        (loop (update acc expr)))))
  (print (hash-table->alist (loop (make-hash-table 'eq?))))
  (exit 0))
