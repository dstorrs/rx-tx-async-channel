#lang racket/base

(require struct-plus-plus racket/async-channel racket/contract)

(provide (all-defined-out))

(struct++ rx-tx-async-channel ([(to-child  (make-async-channel))  async-channel?]
                               [(to-parent (make-async-channel))  async-channel?]))

(define/contract (async-channel-most-recent-message the-channel)
  (-> async-channel? any)
  ; Return the most recently sent message on the specified channel, or #f if no message is on the
  ; channel
  (let loop ([result #f])
    (define new-result (async-channel-try-get the-channel))
    (if new-result
        (loop new-result)
        result)))


(module+ test
  (require test-more)

  (test-suite
   "basic tests"
   
   (define ch (rx-tx-async-channel++))
   (is-type (rx-tx-async-channel.to-child ch)  async-channel?  "to-child  is an async-channel")
   (is-type (rx-tx-async-channel.to-parent ch) async-channel?  "to-parent is an async-channel")
   (define parent (rx-tx-async-channel.to-parent ch))
   (define child (rx-tx-async-channel.to-child ch))

   (async-channel-put parent 1)
   (async-channel-put parent 2)
   (async-channel-put parent 3)
   (async-channel-put child  'a)
   (async-channel-put child  'b)
   (async-channel-put child  'c)

   (is (async-channel-get parent) 1 "on a straight get from parent, received 1, as expected")
   (is (async-channel-get child) 'a "on a straight get from child, received 'a, as expected")

   (is (async-channel-most-recent-message parent) 3 "most recent message on parent was 'c, as expected")
   (is (async-channel-most-recent-message child) 'c "most recent message on child was 'c, as expected"))

  
  )
