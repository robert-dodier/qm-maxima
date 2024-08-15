;; arrange for bra(a) to be displayed as <a|

(setf (get '$bra 'dissym) '((#\<) #\|))
(setf (get '$bra 'dimension) 'dimension-match)

;; arrange for ket(a) to be displayed as |a>

(setf (get '$ket 'dissym) '((#\|) #\>))
(setf (get '$ket 'dimension) 'dimension-match)

;; arrange for braket(bra(a), ket(b)) to be displayed as <a|b>

(defun form-braket (form) `((braket) ((vbar) ,(second (second form)) ,(second (third form)))))
(setf (get '$braket 'formatter) 'form-braket)

(setf (get 'braket 'dissym) '((#\<) #\>))
(setf (get 'braket 'dimension) 'dimension-match)

(setf (get 'vbar 'dissym) '(#\|))
(setf (get 'vbar 'dimension) 'dimension-infix)

;; arrange for dagger(a) to be displayed as a†

(setf (get '$dagger 'dissym) '(#\†))
(setf (get '$dagger 'dimension) 'dimension-postfix)
