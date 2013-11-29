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
  (evolve-cell-rows cells 0 cells))

;;; Evolves each row in the given list of remaining rows to evolve. 'y' and
;;; 'cells' are used to track state: 'y' tells us which row we are currently
;;; processing, and 'cells' is the full 2D grid of cells we are evolving.
(define (evolve-cell-rows remaining-rows y cells)
  (if (null? remaining-rows)
      null
      (cons (evolve-cells-in-row (car remaining-rows) 0 y cells)
            (evolve-cell-rows (cdr remaining-rows) (+ y 1) cells))))

;;; Evolves each cell in the given row of cells to evolve. 'x', 'y' and 'cells'
;;; are used to track state: 'x' and 'y' tells us which row and column we are
;;; currently processing, and 'cells' is the full 2D grid of cells we are
;;; evolving.
(define (evolve-cells-in-row remaining-in-row x y cells)
  (if (null? remaining-in-row)
      null
      (cons (evolve-cell x y cells)
            (evolve-cells-in-row (cdr remaining-in-row) (+ x 1) y cells))))

;;; Decides if the given cell, in the context of the 2D grid it is in, should
;;; live, according to the following rules:
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
  (let ((cell (get-cell x y cells))
        (live-neighbors (count-alive (get-neighbors x y cells))))
       (if (= cell 1)
           (if (or (= live-neighbors 2) (= live-neighbors 3)) 1 0)
           (if (= live-neighbors 3) 1 0))))

;;; Returns the cell at (x,y) in the given grid. If the requested cell is
;;; outside the grid bounds, this just assumes that the cell is dead.
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

;;; Returns a 2D list representing the neighbors of the cell at (x,y) in the
;;; given grid.
(define (get-neighbors x y cells)
  (list (list (get-cell (- x 1) (- y 1) cells)
              (get-cell    x    (- y 1) cells)
              (get-cell (+ x 1) (- y 1) cells))
        (list (get-cell (- x 1)    y    cells)
              ;; This space intentionally left blank
              (get-cell (+ x 1)    y    cells))
        (list (get-cell (- x 1) (+ y 1) cells)
              (get-cell    x    (+ y 1) cells)
              (get-cell (+ x 1) (+ y 1) cells))))

;;; Counts the number of living cells in the given list of cells. The list
;;; can either be one or multi-dimensional.
(define (count-alive cells)
  (if (list? (car cells))
      ;; Recursive case: aggregate the number alive in each row
      (foldr (lambda (row count) (+ (count-alive row) count))
             0
             cells)
      ;; Base case: count number alive in this row
      (length (filter (lambda (cell) (= cell 1)) cells))))

