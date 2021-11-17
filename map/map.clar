;; map
;; A map is like a database on chain

(define-map db {key: int} {value: (string-ascii 12)})

(define-read-only (get-value (key int))
    (begin
        (match (map-get? db {key: key})
            entry (ok (get value entry))
            (err 0))))
            
(define-public (set-value (key int) (value (string-ascii 12)))
    (begin
        (map-set db {key: key} {value: value})
        (ok u1)))
