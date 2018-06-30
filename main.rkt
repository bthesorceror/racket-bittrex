#lang racket/base

(require simple-http)
(require threading)

(provide get-currencies)
(provide get-markets)
(provide get-ticker)
(provide get-market-summaries)
(provide get-market-summary)
(provide get-market-history)
(provide get-order-book)

(define get-markets-url
  "/api/v1.1/public/getmarkets")

(define get-market-summaries-url
  "/api/v1.1/public/getmarketsummaries")

(define get-currencies-url
  "/api/v1.1/public/getcurrencies")

(define get-ticker-url
  "/api/v1.1/public/getticker")

(define get-market-summary-url
  "/api/v1.1/public/getmarketsummary")

(define get-order-book-url
  "/api/v1.1/public/getorderbook")

(define get-market-history-url
  "/api/v1.1/public/getmarkethistory")

(define bittrex
  (~> (update-host json-requester
                   "bittrex.com")
      (update-ssl #t)))

(define (make-request url params)
  (let* ((response (get bittrex url #:params params))
         (body (json-response-body response))
         (success? (hash-ref body 'success)))
    (if success?
        (hash-ref body 'result)
        (raise "Request Failed"))))

(define (get-markets)
  (make-request get-markets-url null))

(define (get-market-summaries)
  (make-request get-market-summaries-url null))

(define (get-currencies)
  (make-request get-currencies-url null))

(define (get-ticker market)
  (~>> (list (cons 'market market))
       (make-request get-ticker-url)))

(define (get-market-summary market)
  (~>> (list (cons 'market market))
       (make-request get-market-summary-url)))

(define (get-order-book market type)
  (~>> (list (cons 'market market)
             (cons 'type type))
       (make-request get-order-book-url)))

(define (get-market-history market)
  (~>> (list (cons 'market market))
       (make-request get-market-history-url)))

(module+ test
  (require rackunit)
  (check-pred number?
              (~> "BTC-LTC"
                  get-market-history
                  first
                  (hash-ref 'Price))
              "returns correct market history data"))
