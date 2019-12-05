(deftemplate element (slot valoare) (slot nume))
	(assert (element (valoare 2) (nume A)))
	(assert (element (valoare 3) (nume A)))
	(assert (element (valoare 7) (nume A)))
	(assert (element (valoare 1001) (nume A)))
	(assert (element (valoare 1002) (nume A)))

(deftemplate suma(slot valoare))
	(assert (suma(valoare 0)))

(defrule CalculSuma
    ?idve <- (element(valoare ?ve))
    ?idvs <- (suma(valoare ?vs))
    =>
    (modify ?idvs(valoare (+ ?ve ?vs)))
    (retract ?idve)
    )

(defrule AfisareSuma
    (suma (valoare ?vs))
    
    =>
    (printout t " Suma = " ?vs crlf)
    )

(watch rules)
(run)
(facts)