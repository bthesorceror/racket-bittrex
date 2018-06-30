#lang info
(define collection "racket-bittrex")
(define deps '("base" "threading" "simple-http"))
(define build-deps '("scribble-lib" "racket-doc" "rackunit-lib"))
(define scribblings '(("scribblings/racket-bittrex.scrbl" ())))
(define pkg-desc "simple wrapper for bittrex api")
(define version "0.01")
(define pkg-authors '("Brandon Farmer"))
