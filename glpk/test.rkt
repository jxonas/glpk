#lang racket

(require (prefix-in glp: glpk))

(define lp (glp:create-prob))
(glp:set-prob-name! lp "sample")
(glp:set-obj-dir! lp glp:MAX)

(glp:add-rows! lp 3)
(glp:set-row-name! lp 1 "p")
(glp:set-row-bnds! lp 1 glp:UP 0.0 100.0)
(glp:set-row-name! lp 2 "q")
(glp:set-row-bnds! lp 2 glp:UP 0.0 600.0)
(glp:set-row-name! lp 3 "r")
(glp:set-row-bnds! lp 3 glp:UP 0.0 300.0)

(glp:add-cols! lp 3)