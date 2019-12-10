(deffacts multimi
    (multime A 1 2 7)
    (multime B 3 4 5 6))
;(deftemplate suma(slot sum))
(deftemplate cardinal(slot card))
(deffacts reuniune (reuniune AB))
(reset)
;(assert (suma (sum 0)))
(assert (cardinal (card 0)))
(defrule descompunere
    (declare (salience 2))
    ?n <- (multime ?A ?p $?rest)
    (test (not (eq ?p nil)))
    => 
    (retract ?n)
    (assert (element ?p))
    (assert (multime ?A $?rest)))

(defrule reuniune
    (declare (salience 1))
    ?n <- (element ?p)
    ?m <- (reuniune  ?A $?rest)
    =>
    (retract ?m ?n)
    (assert (reuniune ?A ?p $?rest)))

(defrule cardinal
    ;(declare (salience -2))
    ?idvs <- (cardinal (card ?vs))
    ?idve <- (reuniune ?A ?p $?rest)
    =>
    (retract ?idve)
    (modify ?idvs (card (+ ?vs 1)))
    (assert (reuniune ?A $?rest)))

; (defrule suma
    ; (declare (salience -2))
    ; ?idvs <- (suma (sum ?vs))
    ; ?idve <- (reuniune ?A ?p&:(integer ?p) $?rest)
    ; =>
    ; (retract ?idve)
    ; (modify ?idvs (sum (+ ?vs ?p)))
    ; (assert (reuniune ?A $?rest))
; )
(facts)
(run)
(facts)