(use util.list)

(define (update acc line)
  (let ((key (car (string-split (car (string-split line "\t")) ":"))))
    (hash-table-update! acc key (cut + 1 <>) 0)
    acc))

(define (main args)
  (define (loop acc)
    (let ((line (read-line)))
      (if (eof-object? line)
        acc
        (loop (update acc line)))))
  (print (hash-table->alist (loop (make-hash-table 'eq?))))
  0)
