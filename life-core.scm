;;;; Implements core logic for Conway's Game of Life. Cells are represented as
;;;; either 1 (alive) or 0 (dead), and the field is represented as a 2D list
;;;; of cells. The main function of interest to consumers is evolve, which will
;;;; transform a 2D list of cells based on the Game of Life evolution rules.

;;; Evolves a generation according to the Game of Life rules. Returns the next
;;; generation as a 2D list of cells, with the same dimensions as the input list.
(define (evolve cells)
  ;; TODO:
  ;; map over each cell:
  ;;   get neighbors at x,y => ((* * *) (* * *))
  ;;   count live neighbors
  ;;   set state of cell based on neighbor count
  cells)

;;; TODO: write this
(define (neighbors x y cells)
  ;; TODO: apparently DrScheme doesn't have sublist?
  ;(sublist
  ;  (sublist
  ;    cells
  ;    (max (- x 1) 0)
  ;    (min (+ x 1) (length cells)))
  cells)

;;; Decides if the given cell should live, given a 2D grid
;;; of its neighbors, according to the following rules:
;;;
;;; 1. Any live cell with fewer than two live neighbors dies, as if caused by
;;;    under-population.
;;; 2. Any live cell with two or three live neighbors lives on to the next
;;;    generation.
;;; 3. Any live cell with more than three live neighbors dies, as if by
;;;    overcrowding.
;;; 4. Any dead cell with exactly three live neighbors becomes a live cell, as
;;;    if by reproduction.
(define (next-gen-cell cell neighbors)
  (let
    ((alive-neighbors (count-alive neighbors)))
    (if (= cell 1)
        (if (or (= alive-neighbors 2) (= alive-neighbors 3)) 1 0)
        (if (= alive-neighbors 3) 1 0))))

;;; Counts the number of living cells in the given list of cells. The list
;;; can either be one or multi-dimensional.
(define (count-alive cells)
  (if (list? (car cells))
      ;; Recursive case: aggregate the number alive in each row
      (foldr
        (lambda (row count) (+ (count-alive row) count))
        0
        cells)
      ;; Base case: count number alive in this row
      (length (filter (lambda (cell) (= cell 1)) cells))))

