;;;; Implements core logic for Conway's Game of Life. Cells are represented as
;;;; either 1 (alive) or 0 (dead), and the grid is represented as a 2D list
;;;; of cells. The main function of interest to consumers is evolve, which will
;;;; transform a 2D list of cells based on the Game of Life evolution rules.
;;;;
;;;; N.B. For the sake of simplicity, this implementation assumes every cell
;;;; outside of the grid is dead.


;;; Evolves a generation according to the Game of Life rules. Returns the next
;;; generation as a 2D list of cells, with the same dimensions as the input list.
(define (evolve cells)
  (evolve-cell-rows 0 cells cells))

(define (evolve-cell-rows y cells remaining-rows)
  (if (null? remaining-rows)
      null
      (cons (evolve-cells-in-row 0 y cells (car remaining-rows))
            (evolve-cell-rows (+ y 1) cells (cdr remaining-rows)))))

(define (evolve-cells-in-row x y cells remaining-in-row)
  (if (null? remaining-in-row)
      null
      (cons (evolve-cell x y cells)
            (evolve-cells-in-row (+ x 1) y cells (cdr remaining-in-row)))))

;;; Decides if the given cell should live, given a 2D grid of its neighbors,
;;; according to the following rules:
;;;
;;; 1. Any live cell with fewer than two live neighbors dies, as if caused by
;;;    under-population.
;;; 2. Any live cell with two or three live neighbors lives on to the next
;;;    generation.
;;; 3. Any live cell with more than three live neighbors dies, as if by
;;;    overcrowding.
;;; 4. Any dead cell with exactly three live neighbors becomes a live cell, as
;;;    if by reproduction.
(define (evolve-cell x y cells)
  (let
    ((cell (get-cell x y cells))
     (live-neighbors (count-alive (get-neighbors x y cells))))
    (if (= cell 1)
        (if (or (= live-neighbors 2) (= live-neighbors 3)) 1 0)
        (if (= live-neighbors 3) 1 0))))

(define (get-cell x y cells)
  (if (list? (car cells))
      ;; Find the correct row first
      (if (or (< y 0) (>= y (length cells)))
          0  ; Outside cell bounds, so assume dead
          (if (= y 0)
              (get-cell x y (car cells))
              (get-cell x (- y 1) (cdr cells))))
      ;; This is the correct row, so now find the correct column
      (if (or (< x 0) (>= x (length cells)))
          0  ; Outside cell bounds, so assume dead
          (if (= x 0)
              (car cells)
              (get-cell (- x 1) y (cdr cells))))))

(define (get-neighbors x y cells)
  (list
    (list (get-cell (- x 1) (- y 1) cells)
          (get-cell    x    (- y 1) cells)
          (get-cell (+ x 1) (- y 1) cells))
    (list (get-cell (- x 1)    y    cells)
          (get-cell (+ x 1)    y    cells))
    (list (get-cell (- x 1) (+ y 1) cells)
          (get-cell    x    (+ y 1) cells)
          (get-cell (+ x 1) (+ y 1) cells))))

;;; Counts the number of living cells in the given list of cells. The list
;;; can either be one or multi-dimensional.
(define (count-alive cells)
  ;(display cells) (newline)
  (if (list? (car cells))
      ;; Recursive case: aggregate the number alive in each row
      (foldr
        (lambda (row count) (+ (count-alive row) count))
        0
        cells)
      ;; Base case: count number alive in this row
      (length (filter (lambda (cell) (= cell 1)) cells))))

