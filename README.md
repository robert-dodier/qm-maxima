Package qm
**********

1 Package qm
************

1.1 Introduction to package qm
==============================

Package version: 0.5

   The ‘qm’ package provides functions and standard definitions to solve
quantum mechanics problems in a finite dimensional Hilbert space.  One
can calculate the outcome of Stern-Gerlach experiments using the
built-in definition of the Sx, Sy, and Sz for arbitrary spin, e.g.
‘s={1/2, 1, 3/2, ...}’.  One can create ket vectors with arbitrary but
finite dimension and perform standard computations.  Angular momentum
representation of kets is available as well.

   With this package it is also possible to create tensor product states
for multiparticle systems and to perform calculations on those systems.

   The package is loaded with: ‘load(qm);’

   The ‘qm’ package was written by Eric Majzoub, University of Missouri.
Email: majzoube-at-umsystem.edu

1.2 Functions and Variables for qm
==================================

 -- Function: cvec (a_{1},a_{2},...)
     ‘cvec’ creates a _column_ vector of arbitrary dimension.  The
     entries ‘a_{i}’ can be any Maxima expression.

     (%i4) cvec(1,2,3);
                                          [ 1 ]
                                          [   ]
     (%o4)                                [ 2 ]
                                          [   ]
                                          [ 3 ]

 -- Function: rvec (a_{1},a_{2},...)
     ‘rvec’ creates a _row_ vector of arbitrary dimension.  The entries
     ‘a_{i}’ can be any Maxima expression.

     (%i4) rvec(1,2,3);
     (%o4)                             [ 1  2  3 ]

 -- Function: ket (c_{1},c_{2},...)
     ‘ket’ creates a _column_ vector of arbitrary dimension.  The
     entries ‘c_{i}’ can be any Maxima expression.  If the entries are
     simple symbols or coefficients of simple functions then they will
     be ‘declare’-ed complex.  If one is having difficulty with getting
     the correct constants declared complex then one is suggested to use
     the ‘cvec’ and ‘rvec’ functions.

     (%i4) ket(c1,c2);
                                         [ c1 ]
     (%o4)                               [    ]
                                         [ c2 ]
     (%i5) facts();
     (%o5) [kind(hbar, real), hbar > 0, kind(c1, complex), kind(c2, complex)]

 -- Function: bra (c_{1},c_{2},...)
     ‘bra’ creates a _row_ vector of arbitrary dimension.  The entries
     ‘c_{i}’ can be any Maxima expression.  If the entries are simple
     symbols or coefficients of simple functions then they will be
     ‘declare’-ed complex.  If one is having difficulty with getting the
     correct constants declared complex then one is suggested to use the
     ‘cvec’ and ‘rvec’ functions.

     (%i4) bra(c1,c2);
     (%o4)                             [ c1  c2 ]

 -- Function: ketp (_vector_)
     ‘ketp’ is a predicate function that checks if its input is a ket,
     in which case it returns ‘true’, else it returns ‘false’.

     (%i4) b:bra(a,b);
     (%o4)                              [ a  b ]
     (%i5) ketp(b);
     (%o5)                                false

 -- Function: brap (_vector_)
     ‘brap’ is a predicate function that checks if its input is a bra,
     in which case it returns ‘true’, else it returns ‘false’.

     (%i4) b:bra(a,b);
     (%o4)                              [ a  b ]
     (%i5) brap(b);
     (%o5)                                true

 -- Function: dag (_vector_)
     ‘dag’ returns the ‘conjugate’ ‘transpose’ of its input.

     (%i4) dag(bra(%i,2));
                                        [ - %i ]
     (%o4)                              [      ]
                                        [  2   ]

 -- Function: braket (psi,phi)
     Given two kets ‘psi’ and ‘phi’, ‘braket’ returns the quantum
     mechanical bracket ‘<psi|phi>’.  The vector ‘psi’ may be input as
     either a ‘ket’ or ‘bra’.  If it is a ‘ket’ it will be turned into a
     ‘bra’ with the ‘dag’ function before the inner product is taken.
     The vector ‘phi’ must always be a ‘ket’.

     (%i4) braket(ket(a,b,c),ket(a,b,c));
     (%o4)          c conjugate(c) + b conjugate(b) + a conjugate(a)

 -- Function: norm (psi)
     Given a ‘ket’ or ‘bra’ ‘psi’, ‘norm’ returns the square root of the
     quantum mechanical bracket ‘<psi|psi>’.  The vector ‘psi’ must
     always be a ‘ket’, otherwise the function will return ‘false’.

     (%i4) norm(ket(a,b,c));
     (%o4)       sqrt(c conjugate(c) + b conjugate(b) + a conjugate(a))

1.2.1 Simple examples
---------------------

The following additional examples show how to input vectors of various
kinds and to do simple manipulations with them.

     (%i4) rvec(a,b,c);
     (%o4)                             [ a  b  c ]
     (%i5) facts();
     (%o5)                    [kind(hbar, real), hbar > 0]
     (%i6) bra(a,b,c);
     (%o6)                             [ a  b  c ]
     (%i7) facts();
     (%o7) [kind(hbar, real), hbar > 0, kind(a, complex), kind(b, complex),
                                                                   kind(c, complex)]
     (%i8) braket(bra(a,b,c),ket(a,b,c));
                                       2    2    2
     (%o8)                            c  + b  + a
     (%i9) braket(ket(a,b,c),ket(a,b,c));
     (%o9)          c conjugate(c) + b conjugate(b) + a conjugate(a)

1.2.2 Spin-1/2 state kets and associated operators
--------------------------------------------------

Spin-1/2 particles are characterized by a simple 2-dimensional Hilbert
space of states.  It is spanned by two vectors.  In the <z>-basis these
vectors are ‘{zp,zm}’, and the basis kets in the <z>-basis are ‘{xp,xm}’
and ‘{yp,ym}’ respectively.

 -- Function: zp,zm,xp,xm,yp,ym
     Return the ket of the corresponding vector in the <z>-basis.

     (%i4) zp;
                                          [ 1 ]
     (%o4)                                [   ]
                                          [ 0 ]
     (%i5) zm;
                                          [ 0 ]
     (%o5)                                [   ]
                                          [ 1 ]
     (%i4) yp;
                                       [    1    ]
                                       [ ------- ]
                                       [ sqrt(2) ]
     (%o4)                             [         ]
                                       [   %i    ]
                                       [ ------- ]
                                       [ sqrt(2) ]
     (%i5) ym;
                                      [     1     ]
                                      [  -------  ]
                                      [  sqrt(2)  ]
     (%o5)                            [           ]
                                      [     %i    ]
                                      [ - ------- ]
                                      [   sqrt(2) ]
     (%i4) braket(xp,zp);
                                            1
     (%o4)                               -------
                                         sqrt(2)

   Switching bases is done in the following example where a <z>-basis
ket is constructed and the <x>-basis ket is computed.

     (%i4) psi:ket(a,b);
                                          [ a ]
     (%o4)                                [   ]
                                          [ b ]
     (%i5) psi_x:'xp*braket(xp,psi)+'xm*braket(xm,psi);
                         b         a              a         b
     (%o5)           (------- + -------) xp + (------- - -------) xm
                      sqrt(2)   sqrt(2)        sqrt(2)   sqrt(2)

1.2.3 Pauli matrices and Sz, Sx, Sy operators
---------------------------------------------

 -- Function: sigmax, sigmay, sigmaz
     Returns the Pauli <x,y,z> matrix.

 -- Function: Sx, Sy, Sz
     Returns the spin-1/2 <Sx,Sy,Sz> matrix.

     (%i4) sigmay;
                                      [ 0   - %i ]
     (%o4)                            [          ]
                                      [ %i   0   ]
     (%i5) Sy;
                                 [            %i hbar ]
                                 [    0     - ------- ]
                                 [               2    ]
     (%o5)                       [                    ]
                                 [ %i hbar            ]
                                 [ -------      0     ]
                                 [    2               ]

1.2.4 SX, SY, SZ operators for any spin
---------------------------------------

 -- Function: SX, SY, SZ (s)
     ‘SX(s)’ for spin ‘s’ returns the matrix representation of the spin
     operator ‘Sx’, and similarly for ‘SY(s)’ and ‘SZ(s)’.  Shortcuts
     for spin-1/2 are ‘Sx,Sy,Sz’, and for spin-1 are ‘Sx1,Sy1,Sz1’.

   Example:

     (%i4) SY(1/2);
                                 [            %i hbar ]
                                 [    0     - ------- ]
                                 [               2    ]
     (%o4)                       [                    ]
                                 [ %i hbar            ]
                                 [ -------      0     ]
                                 [    2               ]
     (%i5) SX(1);
                              [           hbar            ]
                              [    0     -------     0    ]
                              [          sqrt(2)          ]
                              [                           ]
                              [  hbar              hbar   ]
     (%o5)                    [ -------     0     ------- ]
                              [ sqrt(2)           sqrt(2) ]
                              [                           ]
                              [           hbar            ]
                              [    0     -------     0    ]
                              [          sqrt(2)          ]

1.2.5 Expectation value and variance
------------------------------------

 -- Function: expect (O,psi)
     Computes the quantum mechanical expectation value of the operator
     ‘O’ in state ‘psi’, ‘<psi|O|psi>’.

     (%i4) ev(expect(Sy,xp+ym),ratsimp);
     (%o4)                               - hbar

 -- Function: qm_variance (O,psi)
     Computes the quantum mechanical variance of the operator ‘O’ in
     state ‘psi’, ‘sqrt(<psi|O^{2}|psi> - <psi|O|psi>^{2})’.

     (%i4) ev(qm_variance(Sy,xp+ym),ratsimp);
                                         %i hbar
     (%o4)                               -------
                                            2

1.2.6 Angular momentum representation of kets and bras
------------------------------------------------------

To create kets and bras in the <|j,m>> you can use the following
functions.

 -- Function: jm_ket (j,m)
     ‘jm_ket’ creates the ket <|j,m>> for total spin <j> and
     <z>-component <m>.

 -- Function: jm_bra (j,m)
     ‘jm_bra’ creates the bra <<j,m|> for total spin <j> and
     <z>-component <m>.

     (%i4) jm_bra(3/2,1/2);
                                            [ 3  1 ]
     (%o4)                          [jmbra, [ -  - ]]
                                            [ 2  2 ]

 -- Function: jm_ketp (jmket)
     ‘jm_ketp’ checks to see that the ket has the 'jmket' marker.

 -- Function: jm_brap (jmbra)
     ‘jm_brap’ checks to see that the bra has the 'jmbra' marker.

 -- Function: jm_check (j,m)
     ‘jm_check’ checks to see that <m> is one of {-j, ..., +j}.

 -- Function: jm_braket (jmbra,jmket)
     ‘jm_braket’ takes the inner product of the jm-kets.

     (%i4) K:jm_ket(zp,zm);
                                           [ [ 1 ] ]
                                           [ [   ] ]
                                           [ [ 0 ] ]
     (%o4)                         [jmket, [       ]]
                                           [ [ 0 ] ]
                                           [ [   ] ]
                                           [ [ 1 ] ]
     (%i5) B:jm_bra(zp,zm);
                                        [ [ 1 ]  [ 0 ] ]
     (%o5)                      [jmbra, [ [   ]  [   ] ]]
                                        [ [ 0 ]  [ 1 ] ]
     (%i6) jm_braket(B,K);
     (%o6)                                  1

1.2.7 Angular momentum and ladder operators
-------------------------------------------

 -- Function: SP (s)
     ‘SP’ is the raising ladder operator <S_{+}> for spin ‘s’.

 -- Function: SM (s)
     ‘SM’ is the raising ladder operator <S_{-}> for spin ‘s’.

   Examples of the ladder operators:

     (%i4) SP(1);
                            [ 0  sqrt(2) hbar       0       ]
                            [                               ]
     (%o4)                  [ 0       0        sqrt(2) hbar ]
                            [                               ]
                            [ 0       0             0       ]
     (%i5) SM(1);
                            [      0             0        0 ]
                            [                               ]
     (%o5)                  [ sqrt(2) hbar       0        0 ]
                            [                               ]
                            [      0        sqrt(2) hbar  0 ]

1.3 Rotation operators
======================

 -- Function: RX, RY, RZ (s,t)
     ‘RX(s)’ for spin ‘s’ returns the matrix representation of the
     rotation operator ‘Rx’ for rotation through angle ‘t’, and
     similarly for ‘RY(s,t)’ and ‘RZ(s,t)’.

     (%i4) RZ(1/2,t);
     Proviso: assuming 64*t # 0
                                  [     %i t         ]
                                  [   - ----         ]
                                  [      2           ]
                                  [ %e          0    ]
     (%o4)                        [                  ]
                                  [             %i t ]
                                  [             ---- ]
                                  [              2   ]
                                  [    0      %e     ]

1.4 Time-evolution operator
===========================

 -- Function: UU (H,t)
     ‘UU(H,t)’ is the time evolution operator for Hamiltonian ‘H’.  It
     is defined as the matrix exponential ‘matrixexp(-%i*H*t/hbar)’.

     (%i4) UU(w*Sy,t);
     Proviso: assuming 64*t*w # 0
                                [     t w         t w  ]
                                [ cos(---)  - sin(---) ]
                                [      2           2   ]
     (%o4)                      [                      ]
                                [     t w        t w   ]
                                [ sin(---)   cos(---)  ]
                                [      2          2    ]

1.5 Tensor products
===================

Tensor products are represented as lists in Maxima.  The ket tensor
product ‘|z+,z+>’ is represented as ‘[tpket,zp,zp]’, and the bra tensor
product ‘<a,b|’ is represented as ‘[tpbra,a,b]’ for kets ‘a’ and ‘b’.
The list labels ‘tpket’ and ‘tpbra’ ensure calculations are performed
with the correct kind of objects.

 -- Function: ketprod (k_{1}, k_{2}, ...)
     ‘ketprod’ produces a tensor product of kets ‘k_{i}’.  All of the
     elements must pass the ‘ketp’ predicate test to be accepted.

 -- Function: braprod (b_{1}, b_{2}, ...)
     ‘braprod’ produces a tensor product of bras ‘b_{i}’.  All of the
     elements must pass the ‘brap’ predicate test to be accepted.

 -- Function: braketprod (B,K)
     ‘braketprod’ takes the inner product of the tensor products ‘B’ and
     ‘K’.  The tensor products must be of the same length (number of
     kets must equal the number of bras).

   Examples below show how to create tensor products and take the
bracket of tensor products.

     (%i4) ketprod(zp,zm);
                                          [ 1 ]  [ 0 ]
     (%o4)                       [tpket, [[   ], [   ]]]
                                          [ 0 ]  [ 1 ]
     (%i5) ketprod('zp,'zm);
     (%o5)                          [tpket, [zp, zm]]
     (%i4) kill(a,b,c,d);
     (%i5) braprod(bra(a,b),bra(c,d));
     (%o5)                    [tpbra, [[ a  b ], [ c  d ]]]
     (%i6) braprod(dag(zp),bra(c,d));
     (%o6)                    [tpbra, [[ 1  0 ], [ c  d ]]]
     (%i4) zpb:dag(zp);
     (%o4)                              [ 1  0 ]
     (%i5) zmb:dag(zm);
     (%o5)                              [ 0  1 ]
     (%i6) K:ketprod('zp,'zm);
     (%o6)                          [tpket, [zp, zm]]
     (%i7) B:braprod(zpb,zmb);
     (%o7)                    [tpbra, [[ 1  0 ], [ 0  1 ]]]
     (%i8) B:braprod('zpb,'zmb);
     (%o8)                         [tpbra, [zpb, zmb]]
     (%i9) braketprod(K,B);
     (%o9)                                false
     (%i10) braketprod(B,K);
     (%o10)                       (zmb . zm) (zpb . zp)

Appendix A Function and variable index
**************************************

* Menu:

* bra:                                   Functions and variables for qm.
                                                              (line  63)
* braket:                                Functions and variables for qm.
                                                              (line 100)
* braketprod:                            Functions and variables for qm.
                                                              (line 387)
* brap:                                  Functions and variables for qm.
                                                              (line  83)
* braprod:                               Functions and variables for qm.
                                                              (line 383)
* cvec:                                  Functions and variables for qm.
                                                              (line  30)
* dag:                                   Functions and variables for qm.
                                                              (line  92)
* expect:                                Functions and variables for qm.
                                                              (line 247)
* jm_bra:                                Functions and variables for qm.
                                                              (line 273)
* jm_braket:                             Functions and variables for qm.
                                                              (line 291)
* jm_brap:                               Functions and variables for qm.
                                                              (line 285)
* jm_check:                              Functions and variables for qm.
                                                              (line 288)
* jm_ket:                                Functions and variables for qm.
                                                              (line 269)
* jm_ketp:                               Functions and variables for qm.
                                                              (line 282)
* ket:                                   Functions and variables for qm.
                                                              (line  48)
* ketp:                                  Functions and variables for qm.
                                                              (line  74)
* ketprod:                               Functions and variables for qm.
                                                              (line 379)
* norm:                                  Functions and variables for qm.
                                                              (line 110)
* qm_variance:                           Functions and variables for qm.
                                                              (line 254)
* rvec:                                  Functions and variables for qm.
                                                              (line  41)
* RX, RY, RZ:                            Functions and variables for qm.
                                                              (line 336)
* sigmax, sigmay, sigmaz:                Functions and variables for qm.
                                                              (line 194)
* SM:                                    Functions and variables for qm.
                                                              (line 315)
* SP:                                    Functions and variables for qm.
                                                              (line 312)
* Sx, Sy, Sz:                            Functions and variables for qm.
                                                              (line 197)
* SX, SY, SZ:                            Functions and variables for qm.
                                                              (line 216)
* UU:                                    Functions and variables for qm.
                                                              (line 356)
* zp,zm,xp,xm,yp,ym:                     Functions and variables for qm.
                                                              (line 147)

