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

(defun reform-mqapply-bra-or-ket (form)
  (let ((bra-or-ket ($op ($op form))))
    (list '(mqapply array) (cons `(,bra-or-ket) (rest (rest form))) (cons '(mprogn) (rest (second form))))))

(defun dimension-mqapply-bra-or-ket (form result)
  (if (and (not (member 'array (car form))) (member 'array (car (second form))) (member (caar (second form)) '($bra $ket)))
    (dimension-array (reform-mqapply-bra-or-ket form) result)
    (dimension-function form result)))

;; Maybe we should try to cope with the possibility that there
;; might be a display function for MQAPPLY relevant in some other context ...
;; as it stands, any other definition is just clobbered here.

(setf (get 'mqapply 'dimension) 'dimension-mqapply-bra-or-ket)

;; arrange for braket(bra(a), ket(b)) to be displayed as <a|b>

(setf (get 'braket 'dissym) '((#\<) #\>))
(setf (get 'braket 'dimension) 'dimension-match)

(setf (get 'vbar 'dissym) '(#\|))
(setf (get 'vbar 'dimension) 'dimension-infix)

(defun reform-braket (form)
  (let*
    ((args-braket ($args form))
     (bra ($first args-braket))
     (ket ($second args-braket))
     (op-bra ($op bra))
     (op-ket ($op ket)))
    (if (and ($atom op-bra) ($atom op-ket))
      `((braket) ((vbar) ,($first bra) ,($first ket)))
      (if (and ($mapatom op-bra) ($mapatom op-ket) (every 'alike1 (rest op-bra) (rest op-ket)))
        `((mqapply array) ((braket) ((vbar) ,($first bra) ,($first ket))) ((mprogn) ,@(rest op-bra)))
        `((braket) ((vbar) ,bra ,ket))))))

(defun dimension-braket (form result)
  (let*
    ((reformed (reform-braket form))
     (helper (get (caar reformed) 'dimension)))
    (funcall helper reformed result)))

(setf (get '$braket 'dimension) 'dimension-braket)

;; arrange for dagger(a) to be displayed as a†

(setf (get '$dagger 'dissym) '(#\†))
(setf (get '$dagger 'dimension) 'dimension-postfix)

;; arrange for conjugate(a) to be displayed as a*, but only for a being a symbol or subscripted symbol;
;; otherwise display as a function (which is the current default).
;; note a* has the asterisk on the same line as a; a^* puts the asterisk too high, I believe.

(defun reform-conjugate (form)
  (if ($mapatom (second form))
    `((conjugate) ,(second form))
    ;; hmm, do we need to ensure arguments are formatted? or it will happen automatically?
    form))

(setf (get 'conjugate 'dissym) '(#\*))
(setf (get 'conjugate 'dimension) 'dimension-postfix)
