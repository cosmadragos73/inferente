(deftemplate element(slot item) (slot multime) (slot folosit (default FALSE)))
(assert (element (item 1) (multime A)))
(assert (element (item 2) (multime A)))
(assert (element (item 3) (multime A)))
(assert (element (item 4) (multime A)))
(assert (element (item 5) (multime A)))
(assert (element (item 6) (multime A)))
(assert (element (item 7) (multime A)))
(assert (element (item 8) (multime A)))
(assert (element (item 9) (multime A)))
(assert (element (item 10) (multime A)))
(assert (element (item 2) (multime A)))
(assert (element (item 4) (multime A)))
(assert (element (item 6) (multime A)))
(assert (element (item 8) (multime A)))
(assert (element (item 10) (multime A)))
(assert (element (item 12) (multime A)))
(assert (element (item 14) (multime A)))
(assert (element (item 16) (multime A)))

(defrule intersecite
    ?idmf  <- (element (item ?i) (multime ?m) (folosit FALSE))
    ?idmfo <- (element (item ?i) (multime ?m & ~?m) (folosit FALSE))
    =>
    (modify ?idmf (folosit TRUE))
    (modify ?idmfo (folosit TRUE))
    (assert (element (item ?i) (multime I)))
    (printout t "Elementele multimii I "?i crlf)
    )
(run)

(deftemplate suma (slot valoare))
(assert (suma (valoare 9)))

(defrule duplicat 
    ?idm <- (element (item ?i) (multime ?m & ~R) (folosit FALSE))
    ?idm1 <- (element (item ?i) (multime ?m1 & ~?m1 & ~R) (folosit FALSE))
    =>
    (modify ?idm (folosit TRUE))
    (modify ?idm1 (folosit TRUE))
    (assert (element (item ?i) (multime R))))

(defrule reuniune
    ?idr <- (element (item ?i) (multime ?m & ~R) (folosit FALSE))
    =>
    (assert (element (item ?i) (multime R)))
    (modify ?idr (folosit TRUE)))

(defrule printare
    (element (item ?i) (multime R) (folosit FALSE))
    =>
    (printout t "Elementele multimii R= " ?i crlf))

(defrule CalculSuma
    ?idi <- (element (item ?i))
    ?idvs <- (suma (valoare ?vs))
    (element (item ?i &: (> ?i 10) &: (< ?i 50)))
    =>
    (modify ?idvs (valoare (+ ?i ?vs)))
    (retract ?idi))

(defrule afisaresuma
    (suma (valoare ?vs))
    =>
    (printout t " suma = " ?vs crlf))
(run)

)