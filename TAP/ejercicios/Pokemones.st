<?xml version="1.0"?>

<st-source>
<time-stamp>From VisualWorks® NonCommercial, 7.5 of April 16, 2007 on May 26, 2010 at 5:57:45 am</time-stamp>
<!-- Package Pokemons* -->


<class>
<name>Entrenador</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>pokemons </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Pokemons</package>
</attributes>
</class>

<class>
<name>Pokemon</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>energia tipo </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Pokemons</package>
</attributes>
</class>

<class>
<name>TipoPokemon</name>
<environment>Smalltalk</environment>
<super>Pokemon</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Pokemons</package>
</attributes>
</class>

<class>
<name>Fuego</name>
<environment>Smalltalk</environment>
<super>TipoPokemon</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Pokemons</package>
</attributes>
</class>

<class>
<name>Batalla</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>entrenador1 entrenador2 </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Pokemons</package>
</attributes>
</class>

<class>
<name>Electrico</name>
<environment>Smalltalk</environment>
<super>TipoPokemon</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Pokemons</package>
</attributes>
</class>

<class>
<name>Hierba</name>
<environment>Smalltalk</environment>
<super>TipoPokemon</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Pokemons</package>
</attributes>
</class>

<class>
<name>Tierra</name>
<environment>Smalltalk</environment>
<super>TipoPokemon</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Pokemons</package>
</attributes>
</class>

<class>
<name>Agua</name>
<environment>Smalltalk</environment>
<super>TipoPokemon</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Pokemons</package>
</attributes>
</class>

<class>
<name>CrearRandom</name>
<environment>Smalltalk</environment>
<super>Entrenador</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>rand </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category></category>
<attributes>
<package>Pokemons</package>
</attributes>
</class>











<methods>
<class-id>Batalla class</class-id> <category>instance creation</category>

<body package="Pokemons" selector="new">new
	"Answer a newly created and initialized instance."

	^super new initialize</body>
</methods>


<methods>
<class-id>Batalla</class-id> <category>initialize-release</category>

<body package="Pokemons" selector="pelearRonda">pelearRonda

	| pokemon1 pokemon2 |
	pokemon1 := self entrenador1 elegirPokemons.
	pokemon2 := self entrenador2 elegirPokemons.
	self ronda: pokemon1 contra: pokemon2.</body>

<body package="Pokemons" selector="initialize">initialize
	"Initialize a newly created instance. This method must answer the receiver."

	super initialize.
	" *** Edit the following to properly initialize instance variables ***"
	entrenador1 := nil.
	entrenador2 := nil.
	" *** And replace this comment with additional initialization code *** "
	^self</body>

<body package="Pokemons" selector="ronda:contra:">ronda: pokemon1 contra: pokemon2

	[pokemon1 estaVivo &amp; pokemon2 estaVivo] whileTrue: 
			[pokemon1 atacar: pokemon2.
			pokemon2 atacar: pokemon1]</body>
</methods>

<methods>
<class-id>Batalla</class-id> <category>accessing</category>

<body package="Pokemons" selector="entrenador2">entrenador2
	^entrenador2</body>

<body package="Pokemons" selector="entrenador1:">entrenador1: anObject
	entrenador1 := anObject</body>

<body package="Pokemons" selector="entrenador1">entrenador1
	^entrenador1</body>

<body package="Pokemons" selector="entrenador2:">entrenador2: anObject
	entrenador2 := anObject</body>
</methods>


<methods>
<class-id>Pokemon class</class-id> <category>instance creation</category>

<body package="Pokemons" selector="new">new
	"Answer a newly created and initialized instance."

	^super new initialize</body>
</methods>


<methods>
<class-id>Pokemon</class-id> <category>accessing</category>

<body package="Pokemons" selector="energia:">energia: anObject
	energia := anObject</body>

<body package="Pokemons" selector="tipo:">tipo: anObject
	tipo := anObject</body>

<body package="Pokemons" selector="tipo">tipo
	^tipo</body>

<body package="Pokemons" selector="energia">energia
	^energia</body>
</methods>

<methods>
<class-id>Pokemon</class-id> <category>initialize-release</category>

<body package="Pokemons" selector="estaVivo">estaVivo

	^self energia &gt; 0</body>

<body package="Pokemons" selector="restarVida:">restarVida: unInteger

	self energia: self energia - unInteger.</body>

<body package="Pokemons" selector="atacar:">atacar: unPokemon

	| maxDamage damage |
	maxDamage := self tipo cuantoLeSacoA: unPokemon tipo.
	damage := CrearRandom new nextBetween: 0 and: maxDamage.
	unPokemon restarVida: damage</body>

<body package="Pokemons" selector="initialize">initialize
	"Initialize a newly created instance. This method must answer the receiver."

	super initialize.
	" *** Edit the following to properly initialize instance variables ***"
	energia := nil.
	tipo := nil.
	" *** And replace this comment with additional initialization code *** "
	^self</body>
</methods>


<methods>
<class-id>TipoPokemon</class-id> <category>initialize-release</category>

<body package="Pokemons" selector="initialize">initialize
	"Initialize a newly created instance. This method must answer the receiver."

	super initialize.
	" *** Replace this comment with the appropriate initialization code *** "
	^self</body>
</methods>

<methods>
<class-id>TipoPokemon</class-id> <category>damaging</category>

<body package="Pokemons" selector="cuantoMeSacaFuego">cuantoMeSacaFuego

	^self subclassResponsibility.</body>

<body package="Pokemons" selector="cuantoLeSacoA:">cuantoLeSacoA: unTipoPokemon

	^self subclassResponsibility.</body>

<body package="Pokemons" selector="cuantoMeSacaTierra">cuantoMeSacaTierra

	^self subclassResponsibility.</body>

<body package="Pokemons" selector="cuantoMeSacaHierba">cuantoMeSacaHierba

	^self subclassResponsibility.</body>

<body package="Pokemons" selector="cuantoMeSacaElectrico">cuantoMeSacaElectrico

	^self subclassResponsibility.</body>

<body package="Pokemons" selector="cuantoMeSacaAgua">cuantoMeSacaAgua

	^self subclassResponsibility.</body>
</methods>


<methods>
<class-id>Agua</class-id> <category>initialize-release</category>

<body package="Pokemons" selector="initialize">initialize
	"Initialize a newly created instance. This method must answer the receiver."

	super initialize.
	" *** Replace this comment with the appropriate initialization code *** "
	^self</body>
</methods>

<methods>
<class-id>Agua</class-id> <category>damaging</category>

<body package="Pokemons" selector="cuantoMeSacaTierra">cuantoMeSacaTierra
^1</body>

<body package="Pokemons" selector="cuantoMeSacaElectrico">cuantoMeSacaElectrico

	^3</body>

<body package="Pokemons" selector="cuantoMeSacaHierba">cuantoMeSacaHierba

	^3</body>

<body package="Pokemons" selector="cuantoMeSacaAgua">cuantoMeSacaAgua

	^2</body>

<body package="Pokemons" selector="cuantoMeSacaFuego">cuantoMeSacaFuego

	^1</body>

<body package="Pokemons" selector="cuantoLeSacoA:">cuantoLeSacoA: unTipoPokemon

	^unTipoPokemon cuantoMeSacaAgua</body>
</methods>


<methods>
<class-id>Tierra</class-id> <category>initialize-release</category>

<body package="Pokemons" selector="initialize">initialize
	"Initialize a newly created instance. This method must answer the receiver."

	super initialize.
	" *** Replace this comment with the appropriate initialization code *** "
	^self</body>
</methods>

<methods>
<class-id>Tierra</class-id> <category>damaging</category>

<body package="Pokemons" selector="cuantoMeSacaFuego">cuantoMeSacaFuego
^1</body>

<body package="Pokemons" selector="cuantoLeSacoA:">cuantoLeSacoA: unTipoPokemon

	^unTipoPokemon cuantoMeSacaTierra</body>

<body package="Pokemons" selector="cuantoMeSacaElectrico">cuantoMeSacaElectrico
^1</body>

<body package="Pokemons" selector="cuantoMeSacaHierba">cuantoMeSacaHierba
^3</body>

<body package="Pokemons" selector="cuantoMeSacaTierra">cuantoMeSacaTierra
^2</body>

<body package="Pokemons" selector="cuantoMeSacaAgua">cuantoMeSacaAgua
^3</body>
</methods>


<methods>
<class-id>Electrico</class-id> <category>initialize-release</category>

<body package="Pokemons" selector="initialize">initialize
	"Initialize a newly created instance. This method must answer the receiver."

	super initialize.
	" *** Replace this comment with the appropriate initialization code *** "
	^self</body>
</methods>

<methods>
<class-id>Electrico</class-id> <category>damaging</category>

<body package="Pokemons" selector="cuantoMeSacaFuego">cuantoMeSacaFuego
^3</body>

<body package="Pokemons" selector="cuantoLeSacoA:">cuantoLeSacoA: unTipoPokemon

	^unTipoPokemon cuantoMeSacaElectrico</body>

<body package="Pokemons" selector="cuantoMeSacaTierra">cuantoMeSacaTierra
^3</body>

<body package="Pokemons" selector="cuantoMeSacaElectrico">cuantoMeSacaElectrico
^2</body>

<body package="Pokemons" selector="cuantoMeSacaHierba">cuantoMeSacaHierba
^1</body>

<body package="Pokemons" selector="cuantoMeSacaAgua">cuantoMeSacaAgua

	^1</body>
</methods>


<methods>
<class-id>Hierba</class-id> <category>initialize-release</category>

<body package="Pokemons" selector="initialize">initialize
	"Initialize a newly created instance. This method must answer the receiver."

	super initialize.
	" *** Replace this comment with the appropriate initialization code *** "
	^self</body>
</methods>

<methods>
<class-id>Hierba</class-id> <category>damaging</category>

<body package="Pokemons" selector="cuantoMeSacaAgua">cuantoMeSacaAgua
	
	^1</body>

<body package="Pokemons" selector="cuantoMeSacaFuego">cuantoMeSacaFuego

	^3</body>

<body package="Pokemons" selector="cuantoLeSacoA:">cuantoLeSacoA: unTipoPokemon

	^unTipoPokemon cuantoMeSacaHierba</body>

<body package="Pokemons" selector="cuantoMeSacaTierra">cuantoMeSacaTierra

	^1</body>

<body package="Pokemons" selector="cuantoMeSacaHierba">cuantoMeSacaHierba
	
	^2</body>

<body package="Pokemons" selector="cuantoMeSacaElectrico">cuantoMeSacaElectrico

	^3</body>
</methods>


<methods>
<class-id>Entrenador class</class-id> <category>instance creation</category>

<body package="Pokemons" selector="new">new
	"Answer a newly created and initialized instance."

	^super new initialize</body>
</methods>


<methods>
<class-id>Entrenador</class-id> <category>accessing</category>

<body package="Pokemons" selector="pokemons:">pokemons: anObject
	pokemons := anObject</body>

<body package="Pokemons" selector="pokemons">pokemons
	^pokemons</body>
</methods>

<methods>
<class-id>Entrenador</class-id> <category>elegir</category>

<body package="Pokemons" selector="elegirPokemons">elegirPokemons

	| siguiente proxPokemon |
	siguiente := CrearRandom new nextBetween: 0 and: 6.
	proxPokemon := self pokemons at: siguiente.
	proxPokemon estaVivo ifTrue: [^proxPokemon] ifFalse: [^self elegirPokemons]</body>
</methods>

<methods>
<class-id>Entrenador</class-id> <category>initialize-release</category>

<body package="Pokemons" selector="initialize">initialize
	"Initialize a newly created instance. This method must answer the receiver."

	super initialize.
	" *** Edit the following to properly initialize instance variables ***"
	pokemons := nil.
	" *** And replace this comment with additional initialization code *** "
	^self</body>
</methods>


<methods>
<class-id>Fuego</class-id> <category>initialize-release</category>

<body package="Pokemons" selector="initialize">initialize
	"Initialize a newly created instance. This method must answer the receiver."

	super initialize.
	" *** Replace this comment with the appropriate initialization code *** "
	^self</body>
</methods>

<methods>
<class-id>Fuego</class-id> <category>damaging</category>

<body package="Pokemons" selector="cuantoMeSacaFuego">cuantoMeSacaFuego
^2</body>

<body package="Pokemons" selector="cuantoLeSacoA:">cuantoLeSacoA: unTipoPokemon
^unTipoPokemon cuantoMeSacaFuego</body>

<body package="Pokemons" selector="cuantoMeSacaTierra">cuantoMeSacaTierra
^3</body>

<body package="Pokemons" selector="cuantoMeSacaHierba">cuantoMeSacaHierba
^1</body>

<body package="Pokemons" selector="cuantoMeSacaElectrico">cuantoMeSacaElectrico
^1</body>

<body package="Pokemons" selector="cuantoMeSacaAgua">cuantoMeSacaAgua
^3</body>
</methods>


<methods>
<class-id>CrearRandom</class-id> <category>initialize-release</category>

<body package="Pokemons" selector="next">next

	^(rand * 10000) truncated</body>

<body package="Pokemons" selector="nextBetween:and:">nextBetween: x and: y

	^(rand * 10000) truncated \\ (y-x) + x.</body>

<body package="Pokemons" selector="initialize">initialize
	"Initialize a newly created instance. This method must answer the receiver."

	super initialize.
	" *** Edit the following to properly initialize instance variables ***"
	rand := FastRandom new.
	" *** And replace this comment with additional initialization code *** "
	^self</body>
</methods>



</st-source>
