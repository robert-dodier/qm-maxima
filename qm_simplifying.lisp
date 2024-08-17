;; arrange for bra(a) to be displayed as <a|

(setf (get '$bra 'dissym) '((#\<) #\|))
(setf (get '$bra 'dimension) 'dimension-match)

;; arrange for ket(a) to be displayed as |a>

(setf (get '$ket 'dissym) '((#\|) #\>))
(setf (get '$ket 'dimension) 'dimension-match)

;; in addition, arrange for ket[...](a) to be displayed as
;;
;;     |a>
;;        (...)

;; the formatter function is called before op, args, and part (unless inpart = true),
;; so defining a formatter function for display has the side effect of changing
;; op(ket[...](a)), args(ket[...](a)), etc. Unless that makes sense, setting up the
;; display via the formatter property should be considered a stop-gap measure.

(defun form-mqapply (form)
  (if (and (member 'array (car (second form))) (eq (caar (second form)) '$ket))
    (nformat (list '(mqapply array) (cons '($ket) (rest (rest form))) (cons '(mprogn) (rest (second form)))))
    form))

(setf (get 'mqapply 'formatter) 'form-mqapply)

;; arrange for braket(bra(a), ket(b)) to be displayed as <a|b>

;; above comment about the formatter property applies here as well.

(defun form-braket (form) `((braket) ((vbar) ,(second (second form)) ,(second (third form)))))
(setf (get '$braket 'formatter) 'form-braket)

(setf (get 'braket 'dissym) '((#\<) #\>))
(setf (get 'braket 'dimension) 'dimension-match)

(setf (get 'vbar 'dissym) '(#\|))
(setf (get 'vbar 'dimension) 'dimension-infix)

;; arrange for dagger(a) to be displayed as a†

(setf (get '$dagger 'dissym) '(#\†))
(setf (get '$dagger 'dimension) 'dimension-postfix)

;; arrange for conjugate(a) to be displayed as a*, but only for a being a symbol or subscripted symbol;
;; otherwise display as a function (which is the current default).
;; note a* has the asterisk on the same line as a; a^* puts the asterisk too high, I believe.

;; above comment about the formatter property applies here as well.

(defun form-conjugate (form)
  (if ($mapatom (second form))
    `((conjugate) ,(second form))
    ;; hmm, do we need to ensure arguments are formatted? or it will happen automatically?
    form))

(setf (get '$conjugate 'formatter) 'form-conjugate)

(setf (get 'conjugate 'dissym) '(#\*))
(setf (get 'conjugate 'dimension) 'dimension-postfix)
