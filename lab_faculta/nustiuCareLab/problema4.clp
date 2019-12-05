(defglobal ?*TASK_PRIORITY_1* = 5)
(defglobal ?*TASK_PRIORITY_2* = 2)

(deftemplate animal
    (slot denumire)
    (slot mancare)
    (slot modViata)
	(slot mediuViaa)
    (slot modalitateReproducere)
    (slot zona)
    (slot mediuViata)    
    (slot putere)
)

(assert (animal (denumire leu) 
        		(mancare carnivor) 
        		(putere 2)
        )
)
(assert (animal (denumire hiena) 
        		(mancare carnivor) 
        		(putere 1)
   		)
)
(assert (animal (denumire caprioara)
         		(mancare vegetarian)
        )
)
(assert (animal (denumire broasca) 
        		(mancare carnivor) 
        		(mancare vegetarian) 
        		(modViata diurn)
        		(mediuViata semiacvatic)
        		(modalitateReproducere oua)
        )
)
(assert (animal (denumire ariciMare) 
        		(mancare vegetarian) 
        		(modViata diurn)
        		(mediuViata semiacvatic)
        		(zona meditereaneana)
        )
)
(assert (animal (denumire foca) 
        		(zona polara)
        )
)
(assert (animal (denumire ursPolar) 
        		(zona polara)
        )
)


(defrule antipattern
?p <- (animal{zona == polara}(denumire ?name))
=>
    (printout t " *** Animale polare " ?name crlf)
)
(defrule MediuSemiacvatic
    (declare (salience ?*TASK_PRIORITY_1*))
?p <- (animal {mediuViata == semiacvatic} (denumire ?name))
=>
	(printout t " **** Animalul care are mediul de viata semiacvatic este " ?name crlf)
)

(defrule VegetarianMediteranean
    (declare (salience ?*TASK_PRIORITY_2*))
 ?p <- (animal {mancare == vegetarian && zona == mediteraneana} (denumire ?name))
 =>
    (printout t " *** Animalul care e vegetarian si traieste in zona meditaraneana este " ?name crlf)
)

(defrule pradator-prada
    ?animal1 <- (animal)
    ?animal2 <- (animal {mancare == animal1.mancare && mancare == carnivor && (putere < animal1.putere)})
    ?animal3 <- (animal {mancare == carnivor})
    ?animal4 <- (animal {mancare == vegetarian})
=> 
    (printout t " ** Pradatorul este " ?animal1.denumire " si prada " ?animal2.denumire crlf)
    (printout t " ** Pradatorul " ?animal3.denumire " si prada " ?animal4.denumire crlf)    
)

(run)
(facts)
    