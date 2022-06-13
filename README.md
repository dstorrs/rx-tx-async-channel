rx-tx-async-channel
===================


Defines a struct containing two async-channels in order to make bi-directional communication simple.  Relies on the `struct-plus-plus` module.

The two fields of the struct are called `to-child` and `to-parent` with the intent that the struct is created in one thread (the parent) and given to another thread (the child), and the fields specify who is expected to receive the messages--the parent thread receives messages that are put on `to-parent` and vice versa.

