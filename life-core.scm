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
  ;; TODO:
  ;; map over each cell:
  ;;   get neighbors at x,y => ((* * *) (* * *))
  ;;   count live neighbors
  ;;   set state of cell based on neighbor count
  ;(let
  ;  ((height (length cells))
  ;   (width (length (car cells))))
  ;  (map
  ;    (lambda (row)
  ;        ;(- (length row) width)  ; x
  ;      )
  ;    (map
  ;      (lambda (cell)
  ;      )))))
  cells)

(define (get-cell x y cells)
  (if (list? (car cells))
      ; Find the correct row first
      (if (= y 0)
          (get-cell x y (car cells))
          (get-cell x (- y 1) (cdr cells)))
      ; This is the correct row, so now find the correct column
      (if (= x 0)
          (car cells)
            (get-cell (- x 1) y (cdr cells)))))

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

(define (neighbors-of x y cells)
  (slice
    (map
      (lambda (row)
        (slice
          row
          (max (- x 1) 0)
          (min (+ x 1) (length row))))
      cells)
    (max (- y 1) 0)
    (min (+ y 1) (length cells))))

(define (slice lst start end)
  (if (= end 0)
      (list (car lst))
      (if (= start 0)
          (cons (car lst) (slice (cdr lst) start (- end 1)))
          (slice (cdr lst) (- start 1) (- end 1)))))

