;;;; Implements a DrScheme-based graphical driver on top of life-core
(include "life-core.scm")

;;; Displays the given field, represented as a 2D grid, in a human-friendly
;;; format.
(define (debug-display field)
  (map
    (lambda (row) (display row) (newline))
    field))

;;; simple tests
;;; TODO: move this into a unit testing file and replace this with a graphics
;;; driver that call evolve, etc.
(let
  ((field '((1 0 0 0 1 0)
            (0 0 1 0 1 0)
            (1 0 0 0 1 1)
            (0 1 1 0 0 0)))
   (neighbors-that-kill '((1 1 1)
                          (0 1)
                          (1 0 0)))
   (neighbors-that-revive '((1 0 0)
                            (0 1)
                            (1 0 0)))
   (passive-neighbors '((1 0 0)
                        (0 1)
                        (0 0 0))))
  (display "field:") (newline)
  (debug-display field)
  (display "alive: ")
  (display (count-alive field)) (newline)
  (newline)

  (display "neighbors-that-kill:") (newline)
  (debug-display neighbors-that-kill)
  (display "alive: ")
  (display (count-alive neighbors-that-kill)) (newline)
  (display "1 => ")
  (display (next-gen-cell 1 neighbors-that-kill)) (newline)
  (display "0 => ")
  (display (next-gen-cell 0 neighbors-that-kill)) (newline)
  (newline)

  (display "neighbors-that-revive:") (newline)
  (debug-display neighbors-that-revive)
  (display "alive: ")
  (display (count-alive neighbors-that-revive)) (newline)
  (display "1 => ")
  (display (next-gen-cell 1 neighbors-that-revive)) (newline)
  (display "0 => ")
  (display (next-gen-cell 0 neighbors-that-revive)) (newline)
  (newline)

  (display "passive-neighbors:") (newline)
  (debug-display passive-neighbors)
  (display "alive: ")
  (display (count-alive passive-neighbors)) (newline)
  (display "1 => ")
  (display (next-gen-cell 1 passive-neighbors)) (newline)
  (display "0 => ")
  (display (next-gen-cell 0 passive-neighbors)) (newline)
  (newline))

