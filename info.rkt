#lang info
(define collection "rx-tx-async-channel")
(define deps '("base" struct-plus-plus))
(define build-deps '("scribble-lib" "racket-doc" "rackunit-lib"))
(define scribblings '(("scribblings/rx-tx-async-channel.scrbl" ())))
(define pkg-desc "A struct that packages two async-channels to enable bi-directional communication")
(define version "0.1")
(define pkg-authors '("David K. Storrs"))
(define license '(Apache-2.0 OR MIT))
