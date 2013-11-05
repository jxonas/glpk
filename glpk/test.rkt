#lang racket

(require glpk)

(define lp (create-prob))
(set-prob-name! lp "sample")
(set-obj-dir! lp MAX)

(add-rows! lp 3)
(set-row-name! lp 1 "p")
(set-row-bnds! lp 1 UP 0.0 100.0)
(set-row-name! lp 2 "q")
(set-row-bnds! lp 2 UP 0.0 600.0)
(set-row-name! lp 3 "r")
(set-row-bnds! lp 3 UP 0.0 300.0)

(add-cols! lp 3)