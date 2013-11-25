;;;; Core logic for Conway's Game of Life

;;; Evolves a generation according to the Game of Life rules:
;;;
;;; 1. Any live cell with fewer than two live neighbors dies, as if caused by
;;;    under-population.
;;; 2. Any live cell with two or three live neighbors lives on to the next
;;;    generation.
;;; 3. Any live cell with more than three live neighbors dies, as if by
;;;    overcrowding.
;;; 4. Any dead cell with exactly three live neighbors becomes a live cell, as
;;;    if by reproduction.
;;;
;;; Parameters:
;;;    cells - 2D grid of cells, where 1's are live cells and 0's are dead cells
;;;
;;; Returns:
;;;    The next generation as a 2D list of cells, with the same dimension as the
;;;    input list.
(define (evolve cells)
  ;; TODO:
  ;; map over each cell:
  ;;   get neighbors at x,y => ((* * *) (* * *))
  ;;   count live neighbors
  ;;   set state of cell based on neighbor count
  cells)

(define (neighbors x y cells)
  ;; TODO: implement this
  0)

;; TODO: write comments
(define (count-alive cells)
  (foldr
    (lambda (row count) (+ (alive-in-row row) count))
    0
    cells))

;; TODO: fold this into count-alive?
(define (alive-in-row row)
  (foldr
    (lambda (cell count) (if (eq? cell 1) (+ count 1) count))
    0
    row))

