(deftemplate barbat (slot b))
(deftemplate femeie (slot b))
(deftemplate tatal-lui (slot alCui) (slot t))
(deftemplate sotul-lui (slot alCui) (slot s))

(deftemplate parintele-lui (slot alCui) (slot p))
(deftemplate unchiul-lui (slot alCui) (slot u))
(deftemplate varul-lui (slot alCui) (slot v))

(deftemplate mama-lui (slot aCui) (slot m))
(deftemplate sotia-lui (slot aCui) (slot s))

(deftemplate matusa-lui (slot aCui) (slot m))
(deftemplate verisoara-lui (slot aCui) (slot v))


(deffacts arbore-genealogic
    (tatal-lui (alCui Maria) (t Mircea))
    (tatal-lui (alCui Toma) (t Vasile))
    (tatal-lui (alCui Ion) (t Toma))

    (mama-lui (aCui Ion) (m Maria))
    (mama-lui (aCui Toma) (m Ana))
    (mama-lui (aCui Maria) (m Elena))

    (sotia-lui (aCui Mircea) (s Elena))
    (sotia-lui (aCui Vasile) (s Ana))
    (sotia-lui (aCui Toma) (s Maria))

    (sotul-lui (alCui Maria) (s Toma))
    (sotul-lui (alCui Ana) (s Vasile))
    (sotul-lui (alCui Elena) (s Mircea))
)
(reset)

(defrule barbat
            (or 
                (tatal-lui (alCui ?a1) (t ?a2))
                (sotul-lui (alCui ?a1) (s ?a2))
                (unchiul-lui (alCui ?a1) (u ?a2))
                (varul-lui (alCui ?a1) (v ?a2))
            )
            => (assert (barbat (b ?a1)))            
)

(defrule femeie 
            (or
                (mama-lui (aCui ?a1) (m ?a2))
                (sotia-lui (aCui ?a1) (s ?a2))
                (matusa-lui (aCui ?a1) (m ?a2))
                (verisoara-lui (aCui ?a1) (v ?a2))
            )
            => (assert (femeie (b ?a1)))
)

(defrule parintele-lui
            (or
                (tatal-lui (alCui ?a1) (t ?a2))
                (mama-lui (aCui ?a1) (m ?a2))
            )
            => (assert (parintele-lui (alCui ?a1) (p ?a2)))
)

(defrule unchiul-lui
            (and 
                (barbat (b ?a1))
                (parintele-lui (alCui ?a3) (p ?a2))
            )
            => (assert (unchiul-lui (alCui ?a1) (u ?a2)))            
)

(defrule matusa-lui
            (and 
                (femeie (b ?a1))
                (parintele-lui (alCui ?a3) (p ?a2))
            )
            => (assert (matusa-lui (aCui ?a1) (u ?a2)))            
)

(defrule verisoara-lui 
            (and
            
            
            )
            => (assert (versioara-lui (aCui ?a1) (v ?a2)))            
)

(defrule varul-lui
            (and 
            
            )
            => (assert (varul-lui (alCui ?a1) (v ?a2)))            
)
(run)
(facts)



Scrieţi o mulţime de reguli
care determină stramoşii lui Ion (indiferent de mărimea arborelui genealogic); de
asemenea, determinaţi relaţia unchi / matusă şi relaţia văr / verişoară.


Elena sotie Mircea
Elena mama Maria

Mircea sot Elena
Mircea tata Maria

Maria sotie Toma
Maria mama Ion

Ana sotie Vasile
Ana mama Toma

Vasile sot Ana
Vasile tata Toma

Toma sot Maria
Toma tata Ion
