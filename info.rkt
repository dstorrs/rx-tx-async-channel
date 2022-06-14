#lang info
(define collection "rx-tx-async-channel")
(define deps '("base" "struct-plus-plus"))
(define build-deps '("test-more"  "sandbox-lib" "racket-doc" "scribble-lib"))

(define scribblings '(("scribblings/rx-tx-async-channel.scrbl" ())))
(define pkg-desc "A struct that packages two async-channels to enable bi-directional communication")
(define version "1.0")
(define pkg-authors '("David K. Storrs"))
(define license '(Apache-2.0 OR MIT))
