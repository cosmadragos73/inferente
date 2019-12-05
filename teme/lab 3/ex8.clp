    Construiti si implementati in JESS un arbore de decizie util in luarea deciziilor
privind acordarea creditelor bancare. 
    Arborele de decizie va trebui sa permita
invatarea, adica adaugarea de noi ramuri si frunze in mod dinamic de-a lungul
existentei sale. 
    Programul JESS va trebui sa afiseze pentru ce tip de credit este
eligibila o persoana si de asemenea o lista cu acte pe care solicitantul va trebui sa
le furnizeze. 
Dat fiind faptul ca listele de acte sunt destul de lungi si anumite acte
apar in listele a numeroase tipuri sau solicitari de credite, regula care va diagnostica
tipul de credit va insera un fapt de tipul (credit (nume)) in baza de cunostinte. Pentru
fiecare act se va construi o regula care se va aprinde la prezenta faptului credit de
un anumit tip. Tiparirea listei de acte se va realiza cu ajutorul unei reguli.

SUGESTIE CREDITE BANCARE


Arborele de decizie :
    -> inserare ramuri si frunze dinamic
Programul:
    ->afiseaza tipul de credit pentru o persoana 
    -> afiseaza o lista cu acte pentru persoana care trebuiesc furnizate
! Regula care gaseste tipul de credit va insera un fap de tipul credit_bancar(nume)  in baza de cunostinte.
Pentru fiecare act se va construi o regula ce se aprinde la prezentarea lui.
Tiparirea lisdei de acte se face cu ajutorul unei reguli

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