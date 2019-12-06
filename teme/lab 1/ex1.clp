;Template
(deftemplate membru-familie (slot copil)(slot mama) (slot tata) (slot sex))
;Facts

(deffacts familia-popescu
    (membru-familie (copil "Cristian Popescu")(mama "Maria Popescu") (tata "Ion Popescu") (sex barbat))
    (membru-familie (copil "Adrian Popescu") (mama "Maria Popescu") (tata "Ion Popescu") (sex barbat))
    (membru-familie (copil "Ciprian Popescu") (mama "Maria Popescu") (tata "Ion Popescu") (sex barbat))
    (membru-familie (copil "Maria Andreescu") (mama "Maria Popescu") (tata "Ion Popescu") (sex femeie))
    (membru-familie (copil "Tudor Popescu") (mama "Cristina Popescu") (tata "Adrian Popescu") (sex barbat))
    (membru-familie (copil "Ionel Avram") (mama "Maria Andreescu") (tata "Petre Andreescu") (sex barbat))
    ; (membru )
    ; (bunicul-lui (b1 "Ion Popescu") (b2 "Ionel Andreescu"))
    ; (sotul-lui (s1 "Maria Popescu") (s2 "Ion Popescu"))
    ; (sotul-lui (s1 "Maria Andreescu") (f2 "Petre Andreescu"))
    ; (sotia-lui (s1 "Ion Popescu") (s2 "Maria Popescu"))
    ; (sotia-lui (s1 "Cristian Popescu") (s2 "Elena Popescu"))
    ; (fiul-lui (f1 "Maria Andreescu") (f2 "Ionel Avram"))
    ; (matusa-lui (m1 "Ionel Avram") (m2 "Elena Popescu"))
    ; (matusa-lui (m1 "Ionel Avram") (m2 "Cristina Popescu"))
    ; (matusa-lui (m1 "Ionel Avram") (m2 "Adriana Popescu"))
    ; (verisorul-lui (v1 "Ionel Avram") (v2 "Tudor Popescu"))
)
(reset)
;Functii
(deffunction alege-relatie(?sex ?relatie)
;frate sau sora?
(if (eq ?sex femeie)
then
;avem reguli de if pentru femei
    ;regula pt sora
    (if (eq ?relatie "frate")
    then
    (return "sora"))
    ;regula pt matusa
    (if (eq ?relatie "matusa-unchi")
    then
    (return "matusa"))
else
;avem reguli de if pt barbati
    (if (eq ?relatie "frate")
    then
    (return "fratesu"))
    (if (eq ?relatie "matusa-unchi")
    then
    (return "unchi"))
))

;Reguli
;gaseste mama copil
(defrule gaseste-mi-mama
    (declare (salience 50))
    (membru-familie (mama ?m) (copil ?c))
    (ask ?c)
    =>
    (printout t "Mama copilului " ?c " este " ?m crlf))

;gaseste tata copil
(defrule gaseste-mi-tata
    (declare (salience 40))
    (membru-familie (tata ?t) (copil ?c))
    (ask ?c)
    =>
    (printout t "Tatal copilului " ?c " este " ?t crlf))

;gaseste frate copil
(defrule gaseste-mi-fratele
    (declare (salience 30))
    (membru-familie (tata ?t) (copil ?frate))
    (membru-familie (tata ?t) (copil ?c))
    (membru-familie (sex ?s) (copil ?frate))
    (ask ?c)
    (ask ~?frate)
    =>
    (printout t "Fratele lui " ?c (alege-relatie ?sex "frate") " este "?frate crlf))

;gaseste bunic/bunica copil

(defrule gaseste-mi-bunic
    (declare (salience 20))
    (ask ?c)
    (membru-familie (tata ?t) (mama ?m) (copil ?c))
    (or (membru-familie (copil ?t) (mama ?bm) (tata ?bt))
        (membru-familie (copil ?m) (mama ?bm) (tata ?bt)))
    =>
    (printout t "Bunicul copilului " ?c " este " ?bt crlf " Bunica copilului " ?c " este " ?bm crlf)
)

;gaseste matusa/unchi copil

(defrule gaseste-mi-matusa-unchi
    (declare (salience 10))
    (ask ?c)
    (membru-familie (tata ?t) (mama ?m) (copil ?c))
    (or (membru-familie (copil ?t) (mama ?mm) (tata ?ut))
        (membru-familie (copil ?m) (mama ?mm) (tata ?ut)))
    (membru-familie (mama ?mm) (copil ?matusa) (copil ~?t) (copil ~?m) (sex ?sex))
    (membru-familie (mama ?matusa) (copil ?verisor))
    =>
    (printout t " Verisorul copilului " ?c " este " ?verisor crlf ))

;afiseaza lista copii
(defrule afiseaza_copii
    (membru-familie (copil ?da))
    (ask list)
    =>
    (printout t ?da ",")
)

(defrule intrebari

    =>
    (printout t crlf "*************************" crlf
    "Nume copil pt a afla rudele sale" crlf)
    (assert (ask (read)))
)

(facts)
(reset)
(run)
; (deftemplate sotul-lui (slot s1) (slot s2))
; (deftemplate sotia-lui (slot s1) (slot s2))
; (deftemplate fiu-lui (slot f1) (slot f2))
; (deftemplate fiica-lui (slot f1) (slot f2))
; (deftemplate bunicul-lui (slot b1) (slot b2))
; (deftemplate verisor-lui (slot v1) (slot v2))
; (deftemplate matusa-lui (slot m1) (slot m2))
; (deftemplate barbat (slot b))
; (deftemplate femeie (slot f))



; (deffacts familia-popescu
;     (bunicul-lui (b1 "Ion Popescu") (b2 "Ionel Andreescu"))
;     (sotul-lui (s1 "Maria Popescu") (s2 "Ion Popescu"))
;     (sotul-lui (s1 "Maria Andreescu") (f2 "Petre Andreescu"))
;     (sotia-lui (s1 "Ion Popescu") (s2 "Maria Popescu"))
;     (sotia-lui (s1 "Cristian Popescu") (s2 "Elena Popescu"))
;     (fiul-lui (f1 "Ion Popescu") (f2 "Cristian Popescu"))
;     (fiul-lui (f1 "Ion Popescu") (f2 "Adrian Popescu"))
;     (fiul-lui (f1 "Ion Popescu") (f2 "Cristian Popescu"))
;     (fiul-lui (f1 "Adrian Popescu") (f2 "Tudor Popescu"))
;     (fiul-lui (f1 "Maria Andreescu") (f2 "Ionel Avram"))
;     (fiica-lui (f1 "Ion Popescu") (f2 "Maria Andreescu"))
;     (matusa-lui (m1 "Ionel Avram") (m2 "Elena Popescu"))
;     (matusa-lui (m1 "Ionel Avram") (m2 "Cristina Popescu"))
;     (matusa-lui (m1 "Ionel Avram") (m2 "Adriana Popescu"))
;     (verisorul-lui (v1 "Ionel Avram") (v2 "Tudor Popescu"))

; )
; (reset)

; (defrule barbat
;     (or
;         (bunicul-lui (b1 ?a1) (b2 ?a2))
;         (sotul-lui (s1 ?a1) (s2 ?a2))
;         (fiul-lui (f1 ?a1) (f2 ?a2))
;     )
;     => (assert (barbat (b ?a1)))
; )

; (defrule femeie
;     (or
;         (sotia-lui (s1 ?a1) (s2 ?a2))
;         (fiica-lui (f1 ?a1) (f2 ?a2))
;         (matusa-lui (m1 ?a1) (m2 ?a2))
;     )
;     =>(assert (femeie (f ?a1)))
; )

; (defrule bunicul-lui
;         (and
;             ()
        
;         )
; )

; (defrule matusa-lui
;     (and 
;         (femeie (f ?a1))
        
;     )
;     => (assert (matusa-lui (m1 ?a1) (m2 ?a2)))
; )

; (defrule sotul-lui
;     (and
;         (barbat (b ?a1))
;     )
;     => (assert (sotul-lui (s1 ?a1) (s2 ?a2)))
; )

; (run)
; (facts)