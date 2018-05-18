<?xml version="1.0"?>

<st-source>
<time-stamp>From VisualWorks® NonCommercial, 7.5 of April 16, 2007 on July 12, 2010 at 7:58:16 am</time-stamp>
<!-- Package TPFINAL* -->


<class>
<name>Linea</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>linea </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>TPFINAL</category>
<attributes>
<package>TPFINAL</package>
</attributes>
</class>

<class>
<name>Planta</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>hp linea </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>TPFINAL</category>
<attributes>
<package>TPFINAL</package>
</attributes>
</class>

<class>
<name>Zombie</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>hp linea </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>TPFINAL</category>
<attributes>
<package>TPFINAL</package>
</attributes>
</class>

<class>
<name>NuezDefensa</name>
<environment>Smalltalk</environment>
<super>Planta</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>TPFINAL</category>
<attributes>
<package>TPFINAL</package>
</attributes>
</class>

<class>
<name>Belsprouth</name>
<environment>Smalltalk</environment>
<super>Planta</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>TPFINAL</category>
<attributes>
<package>TPFINAL</package>
</attributes>
</class>

<class>
<name>PatronBuilder</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>TPFINAL</category>
<attributes>
<package>TPFINAL</package>
</attributes>
</class>

<class>
<name>ZombieCorredor</name>
<environment>Smalltalk</environment>
<super>Zombie</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>TPFINAL</category>
<attributes>
<package>TPFINAL</package>
</attributes>
</class>

<class>
<name>ZombieComun</name>
<environment>Smalltalk</environment>
<super>Zombie</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>TPFINAL</category>
<attributes>
<package>TPFINAL</package>
</attributes>
</class>

<class>
<name>Jugada</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>coleccionIndexada </inst-vars>
<class-inst-vars>instancia </class-inst-vars>
<imports></imports>
<category>TPFINAL</category>
<attributes>
<package>TPFINAL</package>
</attributes>
</class>

<class>
<name>ZombieOgro</name>
<environment>Smalltalk</environment>
<super>Zombie</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>TPFINAL</category>
<attributes>
<package>TPFINAL</package>
</attributes>
</class>

<class>
<name>CondicionDeFin</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>jugada </inst-vars>
<class-inst-vars>instancia </class-inst-vars>
<imports></imports>
<category>TPFINAL</category>
<attributes>
<package>TPFINAL</package>
</attributes>
</class>












<methods>
<class-id>Zombie class</class-id> <category>instance creation</category>

<body package="TPFINAL" selector="new">new
	"Answer a newly created and initialized instance."

	^super new initialize</body>
</methods>


<methods>
<class-id>Zombie</class-id> <category>Metodos DoubleDisp</category>

<body package="TPFINAL" selector="cuantoLeSacoA:">cuantoLeSacoA: unaPlanta

self subclassResponsibility.</body>

<body package="TPFINAL" selector="cuantoMeSacaBelsprouth">cuantoMeSacaBelsprouth

self subclassResponsibility.</body>
</methods>

<methods>
<class-id>Zombie</class-id> <category>accessing</category>

<body package="TPFINAL" selector="hp:">hp: anObject
	hp := anObject</body>

<body package="TPFINAL" selector="linea">linea
	^linea</body>

<body package="TPFINAL" selector="hp">hp
	^hp</body>

<body package="TPFINAL" selector="linea:">linea: anObject
	linea := anObject</body>

<body package="TPFINAL" selector="sosZombie">sosZombie

^true.</body>
</methods>

<methods>
<class-id>Zombie</class-id> <category>Metodos Redefinidos</category>

<body package="TPFINAL" selector="habilidad:">habilidad: unaPosicion

|planta zombie|

planta:= (self linea linea) at: (unaPosicion - 1).
zombie := (self linea linea) at: unaPosicion.

((planta notNil) and: [(planta sosZombie) not]) ifTrue:[(planta hp &lt;= 0)ifTrue:[self linea poner: nil en: (unaPosicion - 1). planta:= nil] ifFalse: [zombie cuantoLeSacoA: planta.]].

(planta isNil) ifTrue:[(self linea poner: zombie en: (unaPosicion - 1)).
				     (self linea poner: nil en: unaPosicion).
				     (Transcript show: 'Zombie se mueve un paso' ;cr)].</body>
</methods>

<methods>
<class-id>Zombie</class-id> <category>initialize-release</category>

<body package="TPFINAL" selector="initialize">initialize
	"Initialize a newly created instance. This method must answer the receiver."
	
	hp := 100.
	" *** Replace this comment with the appropriate initialization code *** "
	^self</body>
</methods>


<methods>
<class-id>ZombieComun</class-id> <category>Metodos DoubleDisp</category>

<body package="TPFINAL" selector="cuantoLeSacoA:">cuantoLeSacoA: unaPlanta

^unaPlanta cuantoMeSacaZombieComun.</body>

<body package="TPFINAL" selector="cuantoMeSacaBelsprouth">cuantoMeSacaBelsprouth

Transcript show: 'Belsprout saca 10 al Zombie Común.' ;cr .
^self hp: self hp - 10.</body>
</methods>

<methods>
<class-id>ZombieComun</class-id> <category>initialize-release</category>

<body package="TPFINAL" selector="initialize">initialize
	"Initialize a newly created instance. This method must answer the receiver."

	^super initialize.
	
	" *** Replace this comment with the appropriate initialization code *** "</body>
</methods>


<methods>
<class-id>Linea class</class-id> <category>instance creation</category>

<body package="TPFINAL" selector="new">new

^super new initialize.</body>
</methods>


<methods>
<class-id>Linea</class-id> <category>Metodos Jugar</category>

<body package="TPFINAL" selector="jugar">jugar

|pos1 pos2|
pos1 := 0.
pos2 := 0.

"Juegan Plantas"
self linea do:[:planta | pos1 := pos1 + 1 .
					 ((planta notNil)ifTrue: [planta sosZombie]ifFalse:[true]) ifFalse: [planta habilidad: pos1]].
"Juegan Zombies"
self linea do:[:zombie | pos2 := pos2 + 1 .
					   ((zombie notNil)ifTrue: [zombie sosZombie]ifFalse:[false]) ifTrue: [zombie habilidad: pos2]].</body>
</methods>

<methods>
<class-id>Linea</class-id> <category>Metodos Ubicacion</category>

<body package="TPFINAL" selector="hayEn1raCol">hayEn1raCol

^((self linea at:1) notNil)ifTrue:[(self linea at:1) sosZombie]ifFalse: [false].</body>

<body package="TPFINAL" selector="poner:en:">poner: unaPlantaOzombie en: unaPosicion

(unaPlantaOzombie notNil) ifTrue:[unaPlantaOzombie linea: self.].
^(self linea) at: unaPosicion put: unaPlantaOzombie.</body>

<body package="TPFINAL" selector="hayZombie">hayZombie

^self linea anySatisfy: [:zombie | zombie notNil and:[zombie sosZombie]].</body>
</methods>

<methods>
<class-id>Linea</class-id> <category>initialize-release</category>

<body package="TPFINAL" selector="initialize">initialize

linea := Array new: 20.
</body>
</methods>

<methods>
<class-id>Linea</class-id> <category>accessing</category>

<body package="TPFINAL" selector="linea:">linea: anObject
	linea := anObject</body>

<body package="TPFINAL" selector="linea">linea
	^linea</body>
</methods>


<methods>
<class-id>ZombieOgro</class-id> <category>Metodos DoubleDisp</category>

<body package="TPFINAL" selector="cuantoMeSacaBelsprouth">cuantoMeSacaBelsprouth
Transcript show: 'Belsprout saca 5 al Zombie Ogro.' ;cr .
^self hp: self hp - 5.</body>

<body package="TPFINAL" selector="cuantoLeSacoA:">cuantoLeSacoA: unaPlanta

^unaPlanta cuantoMeSacaZombieOgro</body>
</methods>

<methods>
<class-id>ZombieOgro</class-id> <category>initialize-release</category>

<body package="TPFINAL" selector="initialize">initialize

^super initialize.</body>
</methods>


<methods>
<class-id>PatronBuilder class</class-id> <category>instance creation</category>

<body package="TPFINAL" selector="new">new
	"Answer a newly created and initialized instance."

	^super new initialize</body>
</methods>


<methods>
<class-id>PatronBuilder</class-id> <category>Jugadas</category>

<body package="TPFINAL" selector="modoFireAtWill">modoFireAtWill
|jugada2 linea1 linea2 linea3 linea4 linea5 zombieComun1 zombieComun2 zombieComun3 zombieComun4 zombieComun5 belsprout1 belsprout2 belsprout3 belsprout4 belsprout5 belsprout6 belsprout7 belsprout8 belsprout9 belsprout10 |

jugada2 := Jugada new.

linea1 := Linea new.
linea2 := Linea new.
linea3 := Linea new.
linea4 := Linea new.
linea5 := Linea new.

jugada2 coleccionIndexada add: linea1.
jugada2 coleccionIndexada add: linea2.
jugada2 coleccionIndexada add: linea3.
jugada2 coleccionIndexada add: linea4.
jugada2 coleccionIndexada add: linea5.

zombieComun1 := ZombieComun new.
zombieComun2 := ZombieComun new.
zombieComun3 := ZombieComun new.
zombieComun4 := ZombieComun new.
zombieComun5 := ZombieComun new.

linea1 poner: zombieComun1 en: 20.
linea2 poner: zombieComun2 en: 20.
linea3 poner: zombieComun3 en: 20.
linea4 poner: zombieComun4 en: 20.
linea5 poner: zombieComun5 en: 20.

belsprout1 := Belsprouth new.
belsprout2 := Belsprouth new.
belsprout3 := Belsprouth new.
belsprout4 := Belsprouth new.
belsprout5 := Belsprouth new.
belsprout6 := Belsprouth new.
belsprout7 := Belsprouth new.
belsprout8 := Belsprouth new.
belsprout9 := Belsprouth new.
belsprout10 := Belsprouth new.


linea1 poner: belsprout1 en:1.
linea2 poner: belsprout2 en:1.
linea3 poner: belsprout3 en:1.
linea4 poner: belsprout4 en:1.
linea5 poner: belsprout5 en:1.
linea1 poner: belsprout6 en:2.
linea2 poner: belsprout7 en:2.
linea3 poner: belsprout8 en:2.
linea4 poner: belsprout9 en:2.
linea5 poner: belsprout10 en:2.

jugada2 juego</body>

<body package="TPFINAL" selector="modoResidentEvil">modoResidentEvil
|jugada linea1 linea2 linea3 linea4 linea5 zombieComun1 zombieComun2 zombieComun3 zombieOgro1 zombieComun4 zombieComun5 zombieComun6 zombieComun7 zombieComun8 zombieComun9 belsprout1 belsprout2 belsprout3 belsprout4 belsprout5 zombieCorredor1 zombieCorredor2 zombieCorredor3 zombieCorredor4 zombieCorredor5|

jugada := Jugada new.

linea1 := Linea new.
linea2 := Linea new.
linea3 := Linea new.
linea4 := Linea new.
linea5 := Linea new.

jugada coleccionIndexada add: linea1.
jugada coleccionIndexada add: linea2.
jugada coleccionIndexada add: linea3.
jugada coleccionIndexada add: linea4.
jugada coleccionIndexada add: linea5.

zombieComun1 := ZombieComun new.
zombieComun2 := ZombieComun new.
zombieComun3 := ZombieComun new.
zombieOgro1 := ZombieOgro new.
zombieComun4 := ZombieComun new.
zombieComun5 := ZombieComun new.
zombieComun6 := ZombieComun new.
zombieComun7 := ZombieComun new.
zombieComun8 := ZombieComun new.
zombieComun9 := ZombieComun new.
zombieCorredor1 := ZombieCorredor new.
zombieCorredor2 := ZombieCorredor new.
zombieCorredor3 := ZombieCorredor new.
zombieCorredor4 := ZombieCorredor new.
zombieCorredor5 := ZombieCorredor new.

linea1 poner: zombieComun1 en: 20.
linea2 poner: zombieComun2 en: 20.
linea3 poner: zombieOgro1 en: 20.
linea4 poner: zombieComun3 en: 20.
linea5 poner: zombieComun4 en: 20.
linea1 poner: zombieComun5 en: 10.
linea2 poner: zombieComun6 en: 10.
linea3 poner: zombieComun7 en: 10.
linea4 poner: zombieComun8 en: 10.
linea5 poner: zombieComun9 en: 10.
linea1 poner: zombieCorredor1 en: 15.
linea2 poner: zombieCorredor2 en: 15.
linea3 poner: zombieCorredor3 en: 15.
linea4 poner: zombieCorredor4 en: 15.
linea5 poner: zombieCorredor5 en: 15.

belsprout1 := Belsprouth new.
belsprout2 := Belsprouth new.
belsprout3 := Belsprouth new.
belsprout4 := Belsprouth new.
belsprout5 := Belsprouth new.

linea1 poner: belsprout1 en:1.
linea2 poner: belsprout2 en:1.
linea3 poner: belsprout3 en:1.
linea4 poner: belsprout4 en:1.
linea5 poner: belsprout5 en:1.

jugada juego</body>

<body package="TPFINAL" selector="corridor">corridor
|jugada3 linea1 zombieComun1 zombieComun2 zombieComun3 zombieOgro1 zombieComun4 belsprout1 belsprout2 belsprout3 belsprout4 nuez|

jugada3 := Jugada new.

linea1 := Linea new.

jugada3 coleccionIndexada add: linea1.

zombieComun1 := ZombieComun new.
zombieComun2 := ZombieComun new.
zombieComun3 := ZombieComun new.
zombieOgro1 := ZombieOgro new.
zombieComun4 := ZombieComun new.

linea1 poner: zombieComun1 en: 16.
linea1 poner: zombieComun2 en: 17.
linea1 poner: zombieComun3 en: 18.
linea1 poner: zombieComun4 en: 19.
linea1 poner: zombieOgro1 en: 20.

belsprout1 := Belsprouth new.
belsprout2 := Belsprouth new.
belsprout3 := Belsprouth new.
belsprout4 := Belsprouth new.
nuez := NuezDefensa new.

linea1 poner: belsprout1 en:1.
linea1 poner: belsprout2 en:2.
linea1 poner: belsprout3 en:3.
linea1 poner: belsprout4 en:4.
linea1 poner: nuez en:5.

jugada3 juego</body>
</methods>

<methods>
<class-id>PatronBuilder</class-id> <category>initialize-release</category>

<body package="TPFINAL" selector="initialize">initialize
	"Initialize a newly created instance. This method must answer the receiver."

	" *** Replace this comment with the appropriate initialization code *** "
	^self</body>
</methods>


<methods>
<class-id>ZombieCorredor</class-id> <category>Metodos DoubleDisp</category>

<body package="TPFINAL" selector="cuantoLeSacoA:">cuantoLeSacoA: unaPlanta

^unaPlanta cuantoMeSacaZombieCorredor.</body>

<body package="TPFINAL" selector="cuantoMeSacaBelsprouth">cuantoMeSacaBelsprouth
Transcript show: 'Belsprout saca 15 al Zombie Corredor.' ;cr.
^self hp: self hp - 15.
</body>
</methods>

<methods>
<class-id>ZombieCorredor</class-id> <category>initialize-release</category>

<body package="TPFINAL" selector="initialize">initialize

^super initialize.</body>
</methods>


<methods>
<class-id>Jugada class</class-id> <category>instance creation</category>

<body package="TPFINAL" selector="new">new
	"Answer a newly created and initialized instance."
	^super new initialize.</body>
</methods>


<methods>
<class-id>Jugada</class-id> <category>initialize-release</category>

<body package="TPFINAL" selector="initialize">initialize

	"Inicializo todo lo que tiene que estar para que pueda iniciarse el juego."
	"|bel1 bel2 bel3 bel4 bel5 z1 z2 z3 z4 z5|"
	coleccionIndexada := OrderedCollection new.
		
	"linea := Linea new.
	jugador := Jugador new.
	bel1 := Belsprouth new.	bel2 := Belsprouth new.	bel3 := Belsprouth new.	bel4 := Belsprouth new.	bel5 := Belsprouth new.
	plantas at: 1 put: (bel1).	plantas at: 2 put: (bel2).	plantas at: 3 put: (bel3).	plantas at: 4 put: (bel4).	plantas at: 5 put: (bel5).
	zombies := Array new: 5.
	z1 := ZombieComun new. z2 := ZombieComun new. z3 := ZombieComun new.	z4 := ZombieComun new. z5 := ZombieComun new.
 	zombies at: 1 put: (z1). zombies at: 2 put: (z2). zombies at: 3 put: (z3). zombies at: 4 put: (z4). zombies at: 5 put: (z5).		"
	"escenario poner: (plantas at: 1) en: 1@1.
	escenario poner: (plantas at: 2) en: 2@1.
	escenario poner: (plantas at: 3) en: 3@1.
	escenario poner: (plantas at: 4) en: 4@1.
	escenario poner: (plantas at: 5) en: 5@1.
	escenario poner: (zombies at: 1) en: 1@20.
	escenario poner: (zombies at: 2) en: 2@20.
	escenario poner: (zombies at: 3) en: 3@20.
	escenario poner: (zombies at: 4) en: 4@20.
	escenario poner: (zombies at: 5) en: 5@20."
	
	" *** Replace this comment with the appropriate initialization code *** "
	^self</body>
</methods>

<methods>
<class-id>Jugada</class-id> <category>accessing</category>

<body package="TPFINAL" selector="coleccionIndexada:">coleccionIndexada: anObject
	coleccionIndexada := anObject</body>

<body package="TPFINAL" selector="agregarLinea:">agregarLinea: unaLinea

self coleccionIndexada add: unaLinea.</body>

<body package="TPFINAL" selector="coleccionIndexada">coleccionIndexada
	^coleccionIndexada</body>
</methods>

<methods>
<class-id>Jugada</class-id> <category>Metodos Jugada</category>

<body package="TPFINAL" selector="jugar">jugar

self coleccionIndexada do: [:ej | ej jugar].</body>

<body package="TPFINAL" selector="juego">juego

"S I N G L E T O N"

[(CondicionDeFin new noMoreZombies: self) | (CondicionDeFin new zombieAtHome: self)] whileFalse:[self jugar. Transcript show: 'Empieza en turno! ! !' ;cr.  ].

(CondicionDeFin new noMoreZombies: self) ifTrue:[ Transcript show: 'Ganaste gil! ! !' ;cr.] ifFalse:[Transcript show: 'Perdiste groso! ! !' ;cr.].</body>
</methods>


<methods>
<class-id>CondicionDeFin class</class-id> <category>instance creation</category>

<body package="TPFINAL" selector="new">new
	"Answer a newly created and initialized instance."
	(instancia isNil) ifTrue:[^super new initialize].
	^instancia</body>
</methods>


<methods>
<class-id>CondicionDeFin</class-id> <category>accessing</category>

<body package="TPFINAL" selector="jugada">jugada
	^jugada</body>

<body package="TPFINAL" selector="jugada:">jugada: anObject
	jugada := anObject</body>
</methods>

<methods>
<class-id>CondicionDeFin</class-id> <category>initialize-release</category>

<body package="TPFINAL" selector="initialize">initialize
	"Initialize a newly created instance. This method must answer the receiver."

	" *** Replace this comment with the appropriate initialization code *** "
	^self</body>
</methods>

<methods>
<class-id>CondicionDeFin</class-id> <category>Metodos De Fin</category>

<body package="TPFINAL" selector="zombieAtHome:">zombieAtHome: unaJugada

^((unaJugada) coleccionIndexada anySatisfy:[: linea | linea hayEn1raCol]).</body>

<body package="TPFINAL" selector="noMoreZombies:">noMoreZombies: unaJugada	

^((unaJugada) coleccionIndexada anySatisfy:[:linea | linea hayZombie]) not.</body>
</methods>


<methods>
<class-id>Planta class</class-id> <category>instance creation</category>

<body package="TPFINAL" selector="new">new
	"Answer a newly created and initialized instance."

	^super new initialize</body>
</methods>


<methods>
<class-id>Planta</class-id> <category>Metodos DoubleDisp</category>

<body package="TPFINAL" selector="cuantoMeSacaZombieComun">cuantoMeSacaZombieComun

self subclassResponsibility.</body>

<body package="TPFINAL" selector="cuantoMeSacaZombieCorredor">cuantoMeSacaZombieCorredor

self subclassResponsibility.</body>

<body package="TPFINAL" selector="cuantoMeSacaZombieOgro">cuantoMeSacaZombieOgro

self subclassResponsibility.</body>

<body package="TPFINAL" selector="cuantoLeSacoA:">cuantoLeSacoA: unZombie

self subclassResponsibility.</body>
</methods>

<methods>
<class-id>Planta</class-id> <category>accessing</category>

<body package="TPFINAL" selector="linea">linea
	^linea</body>

<body package="TPFINAL" selector="hp">hp
	^hp</body>

<body package="TPFINAL" selector="linea:">linea: anObject
	linea := anObject</body>

<body package="TPFINAL" selector="sosZombie">sosZombie

^false.</body>

<body package="TPFINAL" selector="hp:">hp: anObject
	hp := anObject</body>
</methods>

<methods>
<class-id>Planta</class-id> <category>Metodos Redefinidos</category>

<body package="TPFINAL" selector="habilidad:">habilidad: unaPosicion

|planta zombie pos|

pos := 0.

planta := (self linea linea)  at: unaPosicion.

zombie := (self linea linea) detect: [:unZombie | pos := pos + 1. (unZombie notNil) ifTrue:[unZombie sosZombie]ifFalse:[false]] ifNone:[nil].

(zombie notNil) ifTrue: [(zombie hp &lt;= 0)ifTrue:[(self linea) poner: nil en: pos] ifFalse: [(planta hp&lt;= 0) ifFalse:[planta cuantoLeSacoA: zombie.]].].</body>
</methods>

<methods>
<class-id>Planta</class-id> <category>initialize-release</category>

<body package="TPFINAL" selector="initialize">initialize

self hp: 40.</body>
</methods>


<methods>
<class-id>NuezDefensa</class-id> <category>Metodos DoubleDisp</category>

<body package="TPFINAL" selector="cuantoMeSacaZombieCorredor">cuantoMeSacaZombieCorredor

Transcript show: 'Zombie Corredor hace 4 a la Nuez.' ;cr.
^self hp: self hp - 4.</body>

<body package="TPFINAL" selector="cuantoMeSacaZombieOgro">cuantoMeSacaZombieOgro

Transcript show: 'Zombie Ogro hace 10 a la Nuez.' ;cr.
^self hp: self hp - 10.</body>

<body package="TPFINAL" selector="cuantoLeSacoA:">cuantoLeSacoA: unZombie

Transcript show: 'La nuez se cura 3 de HP.';cr.
^self hp: (self hp + 3).</body>

<body package="TPFINAL" selector="cuantoMeSacaZombieComun">cuantoMeSacaZombieComun

Transcript show: 'Zombie Común hace 7 a la Nuez.';cr.
^self hp: self hp - 7.</body>
</methods>

<methods>
<class-id>NuezDefensa</class-id> <category>initialize-release</category>

<body package="TPFINAL" selector="initialize">initialize
	"Initialize a newly created instance. This method must answer the receiver."

	super initialize.
	
	" *** Replace this comment with the appropriate initialization code *** "
	^self</body>
</methods>


<methods>
<class-id>Belsprouth</class-id> <category>Metodos DoubleDisp</category>

<body package="TPFINAL" selector="cuantoMeSacaZombieCorredor">cuantoMeSacaZombieCorredor

Transcript show: 'Zombie Corredor hace 5 a Belsprout.' ;cr.
^self hp: self hp - 5.</body>

<body package="TPFINAL" selector="cuantoMeSacaZombieOgro">cuantoMeSacaZombieOgro

Transcript show: 'Zombie Ogro hace 20 a la Belsprout.' ;cr.
^self hp: self hp - 20.</body>

<body package="TPFINAL" selector="cuantoLeSacoA:">cuantoLeSacoA: unZombie

^unZombie cuantoMeSacaBelsprouth.</body>

<body package="TPFINAL" selector="cuantoMeSacaZombieComun">cuantoMeSacaZombieComun

Transcript show: 'Zombie Común hace 10 a Belsprout.';cr.
^self hp: self hp - 10.</body>
</methods>

<methods>
<class-id>Belsprouth</class-id> <category>initialize-release</category>

<body package="TPFINAL" selector="initialize">initialize
	"Initialize a newly created instance. This method must answer the receiver."
	super initialize.

	" *** Replace this comment with the appropriate initialization code *** "
	^self</body>
</methods>



</st-source>
