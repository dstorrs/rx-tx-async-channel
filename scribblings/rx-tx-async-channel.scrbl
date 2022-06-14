#lang scribble/manual

@(require (for-label racket rx-tx-async-channel)
          racket/sandbox
          scribble/example)

@title{rx-tx-async-channel}

@author{David K. Storrs}

@defmodule[rx-tx-async-channel]

@section{Description}

Defines a struct containing two async-channels in order to make bi-directional communication simple.  Relies on the @racketmodname[struct-plus-plus] module.

The two fields are called @racketid[to-child] and @racketid[to-parent] with the intent that the struct is created in one thread (the parent) and given to another thread (the child), and the fields specify who is expected to receive the messages--the parent thread receives messages that are put on @racketid[to-parent] and vice versa.

@section{Synopsis}

@(define eval
   (call-with-trusted-sandbox-configuration
    (lambda ()
      (parameterize ([sandbox-output 'string]
                     [sandbox-error-output 'string]
                     [sandbox-memory-limit 50])
        (make-evaluator 'racket)))))

@examples[
 #:eval eval
 #:label #f
 (require struct-plus-plus racket/async-channel rx-tx-async-channel)

(code:comment "The rx-tx-async-channel struct was defined via struct-plus-plus, meaning")
(code:comment "it has a keyword constructor and dotted accessors in addition to the normal")
(code:comment "`struct`-generated versions.")
(code:comment " ")
(code:comment "Both #:to-child and #:to-parent are optional, so the following are essentially equivalent:")
(define x1 (rx-tx-async-channel++ #:to-child (make-async-channel) #:to-parent (make-async-channel)))
(define ch (rx-tx-async-channel++))

(code:comment "Obviously, you can also specify one argument and let the other default.")

(rx-tx-async-channel? ch)
   (async-channel? (rx-tx-async-channel.to-child ch))
   (async-channel? (rx-tx-async-channel.to-parent ch))
   (define parent (rx-tx-async-channel.to-parent ch))
   (define child (rx-tx-async-channel.to-child ch))

   (async-channel-put parent 1)
   (async-channel-put parent 2)
   (async-channel-put parent 3)
   (async-channel-put child  'a)
   (async-channel-put child  'b)
   (async-channel-put child  'c)

   (async-channel-get parent)
   (async-channel-get child)

   (async-channel-most-recent-message parent)
   (async-channel-most-recent-message child)
]

@section{API}

@defproc[(rx-tx-async-channel++ [#:to-child async-channel? (make-async-channel)]  [#:to-parent async-channel (make-async-channel)]) rx-tx-async-channel?]{Keyword constructor.}

@defproc[(rx-tx-async-channel.to-child [rtc rx-tx-async-channel?]) async-channel?]{Dotted accessor created by @racketmodname[struct-plus-plus].}

@defproc[(rx-tx-async-channel.to-parent [rtc rx-tx-async-channel?]) async-channel?]{Dotted accessor created by @racketmodname[struct-plus-plus].}

@defproc[(async-channel-most-recent-message [ch async-channel?]) any/c]{Read from the async channel.  If no messages are available, return #f.  Otherwise, read repeatedly until no messages remain, then return the last message.}
