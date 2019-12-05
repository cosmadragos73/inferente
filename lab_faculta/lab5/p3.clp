(deffunction det-distance ($?lista)
        (bind ?x1 (nth$ 1 ?lista))
        (bind ?y1 (nth$ 2 ?lista))
        (bind ?x2 (nth$ 3 ?lista))
        (bind ?y2 (nth$ 4 ?lista))
        (bind ?x3 (nth$ 5 ?lista))
        (bind ?y3 (nth$ 6 ?lista))
        (printout t ?x1 ", " ?y1 crlf)
        (printout t ?x2 ", " ?y2 crlf)
        (printout t ?x3 ", " ?y3 crlf)
        (bind ?d1 (sqrt(+(**(- ?x2 ?x1) 2)(**(- ?y2 ?y1) 2))))
        (bind ?d2 (sqrt(+(**(- ?x3 ?x1) 2)(**(- ?y3 ?y1) 2))))
        (bind ?d3 (sqrt(+(**(- ?x3 ?x2) 2)(**(- ?y3 ?y2) 2))))
        (printout t " Distanta dintre A si B este " ?d1 crlf)
        (printout t " Distanta dintre C si A este " ?d2 crlf)
        (printout t " Distanta dintre C si B este " ?d3 crlf)
        (if (or (= (* ?d1 ?d2 ) (+ (* ?d2 ?d2) (* ?d3 ?d3)))
                (= (* ?d2 ?d2 ) (+ (* ?d1 ?d1) (* ?d3 ?d3)))
                (= (* ?d3 ?d3 ) (+ (* ?d2 ?d2) (* ?d1 ?d1)))
        )then
                (printout t " Triunghiul dreptunghi " crlf)
                (bind ?b dreptunghic)

        else (if (= ?d1 ?d2 ?d3) then
                (printout t " Triunghi echilateral " crlf)
                (bind ?b echilateral)
                else (if (or (= ?d1 ?d2) (=?d3 ?d2) (= ?d1 ?d3)) then
                        (printout t " Triunghi isoscel " crlf)
                        (bind ?b isoscel)
                        else
                        (printout t " Triunghi oarecare " crlf)
                        (bind ?b oarecare))))
        (return ?b))

(deftemplate figuri (slot tip) (multislot coordonate))
(assert(figuri(tip triunghi) (coordonate 2 7 7 2 2 5)));oarecer
(assert(figuri(tip triunghi) (coordonate 3 4 2 6 1 6)));isoscel
(assert(figuri(tip triunghi) (coordonate 5 0 -2 4 2 -2)));dreptunghic
(assert(figuri(tip triunghi) (coordonate 2 0 3 3 3 3)));dreptunghic

(defrule determinare_tip_triunghi
        ?id <- (figuri (tip ?m) (coordonate $?lista))
        =>
        (printout t crlf)
        (bind ?t (det-distance $?lista))
        (modify ?id (tip ?t))
        (retract ?id))
(run)