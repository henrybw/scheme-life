;;;; Implements a DrScheme-based graphical driver on top of life-core
(include "life-core.scm")

;; simple test
;; TODO: replace this with a graphics driver that call evolve, etc.
(count-alive '((1 0 0 0 1 0)
               (0 0 1 0 1 0)
               (1 0 0 0 1 1)
               (0 1 1 0 0 0)))

