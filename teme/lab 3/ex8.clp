(deftemplate credit
(slot tip (type INTEGER))
(slot nume (type STRING))
(slot prenume (type STRING))
(slot cnp (type INTEGER))
(slot nationalitate (type INTEGER))
(slot salariu (type INTEGER))
(assert (credit (tip 0)(nume "")(prenume "")
(cnp 0)(nationalitate "")(salariu 0)))

(defrule creeaza_dosar
?id<-(credit  (tip 0)(nume "")(prenume "")
(cnp 0)(nationalitate "")(salariu 0))
=>
(printout t "Buna ziua, doriti sa creeati un nou dosar pentru un credit de nevoi personale?")
(printout t " -> Nume: -> ")
(bind ?n(read))
(printout t " -> Prenume: -> ")
(bind ?p(read))
(printout t " -> CNP: -> ")
(bind ?c(read))
(printout t " -> Nationalitate: -> ")
(bind ?t(read))
(printout t " -> Salariu: -> ")
(bind ?s(read))
(retract ?id)(assert (credit(nume ?n)(prenume ?p)(cnp ?c)(nationalitate
?t)(salariu ?s)))
)

(defrule credit_fara_acte
(credit (salariu ?m & :(>= ?m 8))(informatica ?i & :(>= 8))
(fizica ?f & :(>= ?f 8)))
=>
(printout t "Sunteti elegibil pentru un credit fara acte, pe repede-nainte, cu o limita de 4000 lei" crlf))


(defrule credit_cu_acte
(credit (salariu ?m & :(>= ?m 8))(informatica ?i & :(>= 8))
(fizica ?f & :(>= ?f 8)))
=>
(printout t "Sunteti elegibil pentru un credit, pe cu birocratie cu o limita de 10000 lei, va trebui sa ne trimiteti urmatoarele acte pentru a continua deschiderea dosarului:" crlf))
(printout t "Copie legalizata dupa buletin/pasaport" crlf))
(printout t "Copie legalizata dupa certificatul de nastere" crlf))
(printout t "Doavada ultimelor 3 salarii pentru anul curent" crlf))


(defrule credit_cu_acte_ipoteca
(credit (salariu ?m & :(>= ?m 8))(informatica ?i & :(>= 8))
(fizica ?f & :(>= ?f 8)))
=>
(printout t "Sunteti elegibil pentru un credit, pe cu birocratie cu o limita de 100000 lei, va trebui sa ne trimiteti urmatoarele acte pentru a continua deschiderea dosarului:" crlf))
(printout t "Copie legalizata dupa buletin/pasaport" crlf))
(printout t "Copie legalizata dupa certificatul de nastere" crlf))
(printout t "Copie legalizata CF-ul casei" crlf))
(printout t "Copie legalizata dupa imputernicirea/actele casei" crlf))
(printout t "Doavada ultimelor 3 salarii pentru anul curent" crlf))
(printout t "Dovada unui loc de munca pe o perioada de cel putin 1 an de zile" crlf))

(watch all)
(run)
(facts)