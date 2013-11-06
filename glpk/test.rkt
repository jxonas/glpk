#lang racket

(require glpk
         ffi/cvector
         ffi/unsafe)

(define lp (create-prob))
(set-prob-name! lp "sample")
(set-obj-dir! lp MAX)

(void (add-rows! lp 3))
(set-row-name! lp 1 "p")
(set-row-bnds! lp 1 UP 0.0 100.0)
(set-row-name! lp 2 "q")
(set-row-bnds! lp 2 UP 0.0 600.0)
(set-row-name! lp 3 "r")
(set-row-bnds! lp 3 UP 0.0 300.0)

(void (add-cols! lp 3))
(set-col-name! lp 1 "x1")
(set-col-bnds! lp 1 LO 0.0 0.0)
(set-obj-coef! lp 1 10.0)
(set-col-name! lp 2 "x2")
(set-col-bnds! lp 2 LO 0.0 0.0)
(set-obj-coef! lp 2 6.0)
(set-col-name! lp 3 "x3")
(set-col-bnds! lp 3 LO 0.0 0.0)
(set-obj-coef! lp 3 4.0)

;                               a11 a12 a13 a21  a31 a22 a32 a23 a33
(define ia (cvector _int    0   1   1   1   2    3   2   3   2   3  ))
(define ja (cvector _int    0   1   2   3   1    1   2   2   3   3  ))
(define ar (cvector _double 0.0 1.0 1.0 1.0 10.0 2.0 4.0 2.0 5.0 6.0))

(unless (zero? (check-dup 3 3 9 ia ja))
  (error 'glpk-test "duplicate elements"))

(load-matrix! lp 9 ia ja ar)
(void (simplex! lp #f))

(define z (get-obj-val lp))
(define x1 (get-col-prim lp 1))
(define x2 (get-col-prim lp 2))
(define x3 (get-col-prim lp 3))

(printf "z = ~a; x1 = ~a; x2 = ~a; x3 = ~a~%"
        z x2 x2 x3)