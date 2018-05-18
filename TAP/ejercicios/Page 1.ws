100 kilometros + 45 metros

^3 + 4
^[3 + 4]value

bl :=[:x | x * 3] value: 8

bx := [ :b1 :b2 | (b1) min: (b2)]value:6*7 value: 20+7

8 min: 15

|i| i := 0.
[i < 10]
whileTrue: [
i := i + 1.
Transcript show: i printString; cr.
].

|i| i := 0.
[i := i + 1.
Transcript show: i printString; cr.
i < 10.]
whileTrue: [].

Transcript clear
alAzar := FastRandom new

alAzar next

#(1 2 3 4)inject:1 into:[:a :b | a+b]

|b|

b := Bag new

#(1 2 3 4) Select: 2

Array new: 10

SortedCollection SortBlock: [:a :b | a < b]

#(1 2 3) yourself

s := SortedCollection new

s add: 'a'

rapido := FastRandom new

rapido next

miConjunto := Set new.
miConjunto isEmpty.
miConjunto notEmpty.
miConjunto add:2.
miConjunto add:1
miConjunto add: 3
miConjunto size
miConjunto inject: 0 into: [:i :j | i+j]
miConjunto detect: [:i | i >1 ]


mariano := OrderedCollection new.
mariano1 := SortedCollection new.
mariano2 := Array new: 25.
mariano3 := Dictionary new.
mariano4 := Bag new.
mariano5 := Set new.

mariano add: 1.
mariano1  add:1.
mariano2  add:1.
mariano3  add:1.
mariano4  add:1.
mariano5  add:1.

mariano at:1.
mariano1 at:1.
mariano2 at:1.
mariano3 at:1.
mariano4 at:1.
mariano5 at:1.

mariano at:1 put:2.
mariano1 at:1 put:2.
mariano2 at:1 put:2.
mariano3 at:1 put:2.
mariano4 at:1 put:2.
mariano5 at:1 put:2.

mariano do:1.
mariano1 do:1.
mariano2 do:1.
mariano3 do:1.
mariano4 do:1.
mariano5 do:1.

mariano size.
mariano1 size.
mariano2 size.
mariano3 size.
mariano4 size.
mariano5 size.

mariano detect:3.
mariano1 detect:3.
mariano2 detect:3.
mariano3 detect:3.
mariano4 detect:3.
mariano5 detect:3.

mariano select:3.
mariano1 select:3.
mariano2 select:3.
mariano3 select:3.
mariano4 select:3.
mariano5 select:3.

mariano collect:3.
mariano1 collect:3.
mariano2 collect:3.
mariano3 collect:3.
mariano4 collect:3.
mariano5 collect:3.

mariano reject:3.
mariano1 reject:3.
mariano2 reject:3.
mariano3 reject:3.
mariano4 reject:3.
mariano5 reject:3.

mariano Inject:3. into:2.
mariano1 Inject:3. into:2.
mariano2 Inject:3. into:2.
mariano3 Inject:3. into:2.
mariano4 Inject:3. into:2.
mariano5 Inject:3. into:2.

mariano includes:3.
mariano1 includes:3.
mariano2 includes:3.
mariano3 includes:3.
mariano4 includes:3.
mariano5 includes:3.

mariano isEmpty.
mariano1 isEmpty.
mariano2 isEmpty.
mariano3 isEmpty.
mariano4 isEmpty.
mariano5 isEmpty.





