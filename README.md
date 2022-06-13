rx-tx-async-channel
===================

Racket library that defines a struct containing two async-channels in order to make bi-directional communication simple.  Relies on the `struct-plus-plus` module.

The two fields of the struct are called `to-child` and `to-parent` with the intent that the struct is created in one thread (the parent) and given to another thread (the child), and the fields specify who is expected to receive the messages--the parent thread receives messages that are put on `to-parent` and vice versa.

; create one using the struct-plus-plus keyword constructor and specifying the fields

(rx-tx-async-channel++ #:to-child (make-async-channel) #:to-parent (make-async-channel))
(define ch (rx-tx-async-channel++)) ; Allow both fields to default. You can also specify only one.

; retrieve the async-channels from within the struct

(rx-tx-async-channel.to-parent ch) ; returns an async-channel?
(rx-tx-async-channel.to-child ch) ; returns an async-channel?

; return latest message from an async channel, discarding everything along the way.
; If no message available, returns #f

(async-channel-most-recent-message (rx-tx-async-channel.to-child ch)) 