;;;; Implements a DrScheme-based graphical driver on top of life-core
(include "life-core.scm")

;;; Displays the given grid, represented as a 2D grid, in a human-friendly
;;; format.
(define (display-2d grid)
  (map
    (lambda (row) (display row) (newline))
    grid))

;;; TODO: move this into a unit testing file and replace this with a graphics
;;; driver that call evolve, etc.
(define (simple-tests)
  (let
    ((grid '((1 0 0 0 1 0)
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
    (display "grid:") (newline)
    (display-2d grid)
    (display "alive: ")
    (display (count-alive grid)) (newline)
    (newline)

    (display "neighbors-that-kill:") (newline)
    (display-2d neighbors-that-kill)
    (display "alive: ")
    (display (count-alive neighbors-that-kill)) (newline)
    (display "1 => ")
    (display (next-gen-cell 1 neighbors-that-kill)) (newline)
    (display "0 => ")
    (display (next-gen-cell 0 neighbors-that-kill)) (newline)
    (newline)

    (display "neighbors-that-revive:") (newline)
    (display-2d neighbors-that-revive)
    (display "alive: ")
    (display (count-alive neighbors-that-revive)) (newline)
    (display "1 => ")
    (display (next-gen-cell 1 neighbors-that-revive)) (newline)
    (display "0 => ")
    (display (next-gen-cell 0 neighbors-that-revive)) (newline)
    (newline)
    (display "passive-neighbors:") (newline)
    (display-2d passive-neighbors)
    (display "alive: ")
    (display (count-alive passive-neighbors)) (newline)
    (display "1 => ")
    (display (next-gen-cell 1 passive-neighbors)) (newline)
    (display "0 => ")
    (display (next-gen-cell 0 passive-neighbors)) (newline)
    (newline)

    (display "cell at 2,2: ")
    (display (get-cell 2 2 grid)) (newline)
    (display "neighbors of 2,2:") (newline)
    (display-2d (neighbors-of 2 2 grid))
    (newline)

    (display-2d grid)
    (newline)
    (display-2d (evolve grid))))

(simple-tests)
