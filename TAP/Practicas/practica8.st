<?xml version="1.0"?>

<st-source>
<time-stamp>From VisualWorks® NonCommercial, 7.3.1 of mié 20 /20/e abril de 2005 on vie 28 /28/e mayo de 2010 at 20:10:07</time-stamp>
<!-- Package practica8* -->


<class>
<name>Bulto</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>cantidad material </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>practica8</category>
<attributes>
<package>practica8</package>
</attributes>
</class>

<comment>
<class-id>Bulto</class-id>
<body>Instance Variables:
	cantidad	&lt;Object&gt; undocumented
	material	

</body>
</comment>

<class>
<name>Material</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>pesoUnitario precioUnitario </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>practica8</category>
<attributes>
<package>practica8</package>
</attributes>
</class>

<comment>
<class-id>Material</class-id>
<body>Instance Variables:
	pesoUnitario	&lt;Object&gt; undocumented
	precioUnitario	

</body>
</comment>

<class>
<name>Pizza</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>tiempoPreparacion esPulenta complementos pesoExtra ingredientes fueAmasada pizzero horno </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>practica8</category>
<attributes>
<package>practica8</package>
</attributes>
</class>

<comment>
<class-id>Pizza</class-id>
<body>Instance Variables:
	tiempoPreparacion	&lt;Object&gt; undocumented
	esPulenta	&lt;Object&gt; undocumented
	complementos	&lt;Object&gt; undocumented
	pesoExtra	&lt;Object&gt; undocumented
	ingredientes	&lt;Object&gt; undocumented
	fueAmasada	pizzero &lt;Object&gt; undocumented
	horno	

</body>
</comment>

<class>
<name>Programa</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>horaInicio horaFin tipoDePrograma presupuesto </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>practica8</category>
<attributes>
<package>practica8</package>
</attributes>
</class>

<comment>
<class-id>Programa</class-id>
<body>Instance Variables:
	horaInicio	horaFin &lt;Object&gt; undocumented
	tipoDePrograma	presupuesto &lt;Object&gt; undocumented

</body>
</comment>

<class>
<name>BloqueDeNoticias</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>horaInicio duracion costo </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>practica8</category>
<attributes>
<package>practica8</package>
</attributes>
</class>

<comment>
<class-id>BloqueDeNoticias</class-id>
<body>Instance Variables:
	horaInicio	duracion &lt;Object&gt; undocumented
	costo	

</body>
</comment>

<class>
<name>Horno</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>practica8</category>
<attributes>
<package>practica8</package>
</attributes>
</class>

<class>
<name>Productos</name>
<environment>Smalltalk</environment>
<super>Horno</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>practica8</category>
<attributes>
<package>practica8</package>
</attributes>
</class>

<class>
<name>Radio</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>programas tiposDeProgramaAceptables </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>practica8</category>
<attributes>
<package>practica8</package>
</attributes>
</class>

<comment>
<class-id>Radio</class-id>
<body>Instance Variables:
	programas	tiposDeProgramaAceptables &lt;Object&gt; undocumented

</body>
</comment>

<class>
<name>PaqueteSencillo</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>peso costo </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>practica8</category>
<attributes>
<package>practica8</package>
</attributes>
</class>

<comment>
<class-id>PaqueteSencillo</class-id>
<body>Instance Variables:
	peso	&lt;Object&gt;
	costo	

</body>
</comment>

<class>
<name>Pizzero</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>practica8</category>
<attributes>
<package>practica8</package>
</attributes>
</class>

<class>
<name>Caja</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>contenidos pesoMaximo </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>practica8</category>
<attributes>
<package>practica8</package>
</attributes>
</class>

<comment>
<class-id>Caja</class-id>
<body>Instance Variables:
	contenidos	&lt;Object&gt; undocumented
	pesoMaximo	

</body>
</comment>












<methods>
<class-id>Programa class</class-id> <category>instance creation</category>

<body package="practica8" selector="new">new
	"Answer a newly created and initialized instance."

	^super new initialize</body>

<body package="practica8" selector="newEmpieza:termina:tipo:presupuesto:">newEmpieza: hora1 termina: hora2 tipo: unString presupuesto: unNumero
	"crea un nuevo Programa con los valores indicados"

	^self new
		horaInicio: hora1;
		horaFin: hora2;
		tipoDePrograma: unString;
		presupuesto: unNumero;
		yourself</body>
</methods>


<methods>
<class-id>Programa</class-id> <category>initialize-release</category>

<body package="practica8" selector="initialize">initialize
	"Initialize a newly created instance. This method must answer the receiver."

	" *** Replace this comment with the appropriate initialization code *** "
	^self</body>
</methods>

<methods>
<class-id>Programa</class-id> <category>accessing</category>

<body package="practica8" selector="horaInicio:">horaInicio: anObject
	horaInicio := anObject</body>

<body package="practica8" selector="tipoDePrograma">tipoDePrograma
	^tipoDePrograma</body>

<body package="practica8" selector="presupuesto">presupuesto
	^presupuesto</body>

<body package="practica8" selector="tipoDePrograma:">tipoDePrograma: anObject
	tipoDePrograma := anObject</body>

<body package="practica8" selector="presupuesto:">presupuesto: anObject
	presupuesto := anObject</body>

<body package="practica8" selector="horaFin">horaFin
	^horaFin</body>

<body package="practica8" selector="horaInicio">horaInicio
	^horaInicio</body>

<body package="practica8" selector="horaFin:">horaFin: anObject
	horaFin := anObject</body>
</methods>


<methods>
<class-id>BloqueDeNoticias class</class-id> <category>instance creation</category>

<body package="practica8" selector="newInicio:duracion:costo:">newInicio: hora duracion: dur costo: guita
	"crea un BloqueDeNoticias con los valores indicados"

	^self new
		horaInicio: hora;
		duracion: dur;
		costo: guita;
		yourself</body>

<body package="practica8" selector="new">new
	"Answer a newly created and initialized instance."

	^super new initialize</body>
</methods>


<methods>
<class-id>BloqueDeNoticias</class-id> <category>initialize-release</category>

<body package="practica8" selector="initialize">initialize
	"Initialize a newly created instance. This method must answer the receiver."

	" *** Replace this comment with the appropriate initialization code *** "
	^self</body>
</methods>

<methods>
<class-id>BloqueDeNoticias</class-id> <category>accessing</category>

<body package="practica8" selector="costo">costo
	^costo</body>

<body package="practica8" selector="horaInicio">horaInicio
	^horaInicio</body>

<body package="practica8" selector="costo:">costo: anObject
	costo := anObject</body>

<body package="practica8" selector="horaInicio:">horaInicio: anObject
	horaInicio := anObject</body>

<body package="practica8" selector="duracion">duracion
	^duracion</body>

<body package="practica8" selector="duracion:">duracion: anObject
	duracion := anObject</body>
</methods>


<methods>
<class-id>PaqueteSencillo class</class-id> <category>instance creation</category>

<body package="practica8" selector="newPeso:costo:">newPeso: unPeso costo: unCosto
	"creo un paquete con peso y costo indicados"

	^self new peso: unPeso; costo: unCosto; yourself</body>

<body package="practica8" selector="new">new
	"Answer a newly created and initialized instance."

	^super new initialize</body>
</methods>


<methods>
<class-id>PaqueteSencillo</class-id> <category>initialize-release</category>

<body package="practica8" selector="initialize">initialize
	"Initialize a newly created instance. This method must answer the receiver."

	" *** Replace this comment with the appropriate initialization code *** "
	^self</body>
</methods>

<methods>
<class-id>PaqueteSencillo</class-id> <category>accessing</category>

<body package="practica8" selector="peso">peso
	^peso</body>

<body package="practica8" selector="peso:">peso: anObject
	peso := anObject</body>

<body package="practica8" selector="costo">costo
	^costo</body>

<body package="practica8" selector="costo:">costo: anObject
	costo := anObject</body>
</methods>


<methods>
<class-id>Horno class</class-id> <category>instance creation</category>

<body package="practica8" selector="new">new
	"Answer a newly created and initialized instance."

	^super new initialize</body>
</methods>


<methods>
<class-id>Horno</class-id> <category>acciones</category>

<body package="practica8" selector="cocinar:durante:">cocinar: unProducto durante: unosMinutos
	"me piden que labure un rato"

	unProducto agregarTiempoDePreparacion: unosMinutos</body>
</methods>

<methods>
<class-id>Horno</class-id> <category>initialize-release</category>

<body package="practica8" selector="initialize">initialize
	"Initialize a newly created instance. This method must answer the receiver."

	" *** Replace this comment with the appropriate initialization code *** "
	^self</body>
</methods>


<methods>
<class-id>Productos class</class-id> <category>productos</category>

<body package="practica8" selector="palmitos">palmitos
	"eso"

	^#palmitos</body>

<body package="practica8" selector="tomates">tomates
	"eso"

	^#tomates</body>

<body package="practica8" selector="jamon">jamon
	"eso"

	^#jamon</body>

<body package="practica8" selector="muzza">muzza
	"eso"

	^#muzza</body>

<body package="practica8" selector="cebolla">cebolla
	"eso"

	^#cebolla</body>

<body package="practica8" selector="aceitunas">aceitunas
	"eso"

	^#aceitunas</body>

<body package="practica8" selector="morron">morron
	"eso"

	^#morron</body>
</methods>


<methods>
<class-id>Productos</class-id> <category>initialize-release</category>

<body package="practica8" selector="initialize">initialize
	"Initialize a newly created instance. This method must answer the receiver."

	super initialize.
	" *** Replace this comment with the appropriate initialization code *** "
	^self</body>
</methods>


<methods>
<class-id>Caja</class-id> <category>acciones</category>

<body package="practica8" selector="agregarContenido:">agregarContenido: unContenido
	"me agregan algo"

	contenidos add: unContenido</body>
</methods>

<methods>
<class-id>Caja</class-id> <category>initialize-release</category>

<body package="practica8" selector="initialize">initialize
	"Initialize a newly created instance. This method must answer the receiver."

	super initialize.
	" *** Edit the following to properly initialize instance variables ***"
	contenidos := OrderedCollection new.
	" *** And replace this comment with additional initialization code *** "
	^self</body>
</methods>

<methods>
<class-id>Caja</class-id> <category>accessing</category>

<body package="practica8" selector="contenidos">contenidos
	^contenidos</body>

<body package="practica8" selector="contenidos:">contenidos: anObject
	contenidos := anObject</body>

<body package="practica8" selector="necesitaSerAsegurada">necesitaSerAsegurada
	"eso"

	^self contenidos size &gt; 6 
		| ((self contenidos select: [:cont | cont costo &gt; 1000]) size &gt; 3)</body>

<body package="practica8" selector="pesoMaximo">pesoMaximo
	^pesoMaximo</body>

<body package="practica8" selector="estaSobrecargada">estaSobrecargada
	"el peso total de lo que tengo adentro"

	^self pesoContenidos &gt; self pesoMaximo </body>

<body package="practica8" selector="pesoMaximo:">pesoMaximo: anObject
	pesoMaximo := anObject</body>

<body package="practica8" selector="pesoContenidos">pesoContenidos
	"el peso total de lo que tengo adentro"

	^contenidos inject: 0 into: [:total :cont | total + cont peso]</body>
</methods>


<methods>
<class-id>Bulto class</class-id> <category>instance creation</category>

<body package="practica8" selector="newCantidad:de:">newCantidad: unNumero de: unMaterial
	"creo un nuevo Bulto que tiene una cantidad determinada de un material determinado"

	^self new cantidad: unNumero; material: unMaterial; yourself</body>

<body package="practica8" selector="new">new
	"Answer a newly created and initialized instance."

	^super new initialize</body>
</methods>


<methods>
<class-id>Bulto</class-id> <category>info</category>

<body package="practica8" selector="pesoTotal">pesoTotal
	"cuanto pesa el bulto"

	"las bolsas pesan todas 100 gramos"
	^100 + (self cantidad * self material pesoUnitario)</body>

<body package="practica8" selector="precio">precio
	"cuanto sale el bulto"

	"las bolsas salen todas 20 pesos"
	^20 + (self cantidad * self material precioUnitario)</body>
</methods>

<methods>
<class-id>Bulto</class-id> <category>initialize-release</category>

<body package="practica8" selector="initialize">initialize
	"Initialize a newly created instance. This method must answer the receiver."

	" *** Replace this comment with the appropriate initialization code *** "
	^self</body>
</methods>

<methods>
<class-id>Bulto</class-id> <category>accessing</category>

<body package="practica8" selector="cantidad">cantidad
	^cantidad</body>

<body package="practica8" selector="material:">material: anObject
	material := anObject</body>

<body package="practica8" selector="material">material
	^material</body>

<body package="practica8" selector="cantidad:">cantidad: anObject
	cantidad := anObject</body>
</methods>


<methods>
<class-id>Pizza class</class-id> <category>instance creation</category>

<body package="practica8" selector="new">new
	"Answer a newly created and initialized instance."

	^super new initialize</body>
</methods>


<methods>
<class-id>Pizza</class-id> <category>peso</category>

<body package="practica8" selector="pesoExtra">pesoExtra
	^pesoExtra</body>

<body package="practica8" selector="pesoIngredientes">pesoIngredientes
	^self ingredientes inject: 0 into: [:total :peso | total + peso]</body>

<body package="practica8" selector="peso">peso
	^self pesoIngredientes + self pesoExtra</body>

<body package="practica8" selector="pesoExtra:">pesoExtra: anObject
	pesoExtra := anObject</body>
</methods>

<methods>
<class-id>Pizza</class-id> <category>acciones</category>

<body package="practica8" selector="agregar:de:">agregar: cantidad de: unProducto 
	"me agregan algo arriba"

	(ingredientes includesKey: unProducto) 
		ifFalse: [ingredientes at: unProducto put: 0].
	ingredientes at: unProducto put: (ingredientes at: unProducto + cantidad).</body>

<body package="practica8" selector="agregarComplemento:">agregarComplemento: unComplemento
	"me agregan unComplemento"

	complementos add: unComplemento</body>

<body package="practica8" selector="agregarPesoExtra:">agregarPesoExtra: unPeso
	"me dicen que estoy pesando unPeso más de lo que ya sé que peso"

	pesoExtra := unPeso</body>

<body package="practica8" selector="agregarTiempoDePreparacion:">agregarTiempoDePreparacion: unosMinutos
	"me informan de una preparacion que llevo unosMinutos"

	tiempoPreparacion := tiempoPreparacion + unosMinutos</body>
</methods>

<methods>
<class-id>Pizza</class-id> <category>initialize-release</category>

<body package="practica8" selector="initialize">initialize
	"Initialize a newly created instance. This method must answer the receiver."

	" *** Edit the following to properly initialize instance variables ***"
	tiempoPreparacion := 0.
	esPulenta := false.
	complementos := Set new.
	pesoExtra := 0.
	ingredientes := Dictionary new.
	pizzero := Pizzero new.
	horno := Horno new.
	" *** And replace this comment with additional initialization code *** "
	^self</body>
</methods>

<methods>
<class-id>Pizza</class-id> <category>accessing</category>

<body package="practica8" selector="esPulenta">esPulenta
	^esPulenta</body>

<body package="practica8" selector="esPulenta:">esPulenta: anObject
	esPulenta := anObject</body>

<body package="practica8" selector="tiempoPreparacion:">tiempoPreparacion: anObject
	tiempoPreparacion := anObject</body>

<body package="practica8" selector="complementos">complementos
	^complementos</body>

<body package="practica8" selector="ingredientes:">ingredientes: anObject
	ingredientes := anObject</body>

<body package="practica8" selector="tiempoPreparacion">tiempoPreparacion
	^tiempoPreparacion</body>

<body package="practica8" selector="ingredientes">ingredientes
	^ingredientes</body>

<body package="practica8" selector="pizzero:">pizzero: anObject
	pizzero := anObject</body>

<body package="practica8" selector="horno:">horno: anObject
	horno := anObject</body>

<body package="practica8" selector="fueAmasada">fueAmasada
	^fueAmasada</body>

<body package="practica8" selector="horno">horno
	^horno</body>

<body package="practica8" selector="complementos:">complementos: anObject
	complementos := anObject</body>

<body package="practica8" selector="fueAmasada:">fueAmasada: anObject
	fueAmasada := anObject</body>

<body package="practica8" selector="pizzero">pizzero
	"el que me arma"

	^pizzero</body>
</methods>


<methods>
<class-id>Radio class</class-id> <category>instance creation</category>

<body package="practica8" selector="new">new
	"Answer a newly created and initialized instance."

	^super new initialize</body>
</methods>


<methods>
<class-id>Radio</class-id> <category>programacion</category>

<body package="practica8" selector="estaLibreEntre:y:">estaLibreEntre: hora1 y: hora2
	"true si no hay nada programado entre hora1 y hora2"

	^programas allSatisfy: [:prog | prog horaInicio &gt;= hora2 | prog horaFin &lt;= hora1]</body>

<body package="practica8" selector="sePuedeIncorporar:">sePuedeIncorporar: unPrograma 
	"si o no"

	^(self estaLibreEntre: unPrograma horaInicio y: unPrograma horaFin) 
		&amp; (self tiposDeProgramaAceptables includes: unPrograma tipoDePrograma)</body>

<body package="practica8" selector="agregarPrograma:">agregarPrograma: unPrograma 
	"si se puede lo agrega, si no error"

	(self sePuedeIncorporar: unPrograma) 
		ifTrue: [programas add: unPrograma]
		ifFalse: [Error raiseSignal]</body>
</methods>

<methods>
<class-id>Radio</class-id> <category>finanzas</category>

<body package="practica8" selector="presupuesto">presupuesto
	"cuanto me sale la radio"
	^self programas inject: 0 into: [:prog | prog presupuesto]</body>
</methods>

<methods>
<class-id>Radio</class-id> <category>initialize-release</category>

<body package="practica8" selector="initialize">initialize
	"Initialize a newly created instance. This method must answer the receiver."

	programas := Set new.
	^self</body>
</methods>

<methods>
<class-id>Radio</class-id> <category>accessing</category>

<body package="practica8" selector="tiposDeProgramaAceptables:">tiposDeProgramaAceptables: anObject
	tiposDeProgramaAceptables := anObject</body>

<body package="practica8" selector="tiposDeProgramaAceptables">tiposDeProgramaAceptables
	^tiposDeProgramaAceptables</body>

<body package="practica8" selector="programas">programas
	"los programas que forman parte de mi programacion"

	^programas</body>

<body package="practica8" selector="agregarTipoDeProgramaAceptables:">agregarTipoDeProgramaAceptables: unString
	"me dicen que los programas de tipo unString tambien son aceptables para mi"
	tiposDeProgramaAceptables add: unString</body>
</methods>


<methods>
<class-id>Pizzero class</class-id> <category>instance creation</category>

<body package="practica8" selector="new">new
	"Answer a newly created and initialized instance."

	^super new initialize</body>
</methods>


<methods>
<class-id>Pizzero</class-id> <category>acciones</category>

<body package="practica8" selector="echarAceiteEn:">echarAceiteEn: pizza
	"eso"

	pizza agregarComplemento: 'aceite'; esPulenta: true</body>

<body package="practica8" selector="echarSalsaDeTomatesA:">echarSalsaDeTomatesA: pizza
	"eso"

	pizza agregarComplemento: 'salsa'; agregarPesoExtra: 100</body>

<body package="practica8" selector="echarSalsaGolfA:">echarSalsaGolfA: pizza
	"eso"

	pizza agregarComplemento: 'salsaGolf'; agregarPesoExtra: 150</body>

<body package="practica8" selector="hacerTajitosEn:">hacerTajitosEn: pizza
	"eso"

	pizza agregarTiempoDePreparacion: 3</body>

<body package="practica8" selector="echarAjoEn:">echarAjoEn: pizza
	"eso"

	pizza agregarComplemento: 'ajo'; esPulenta: true</body>

<body package="practica8" selector="amasar:durante:">amasar: pizza durante: minutos
	"amasa que te amasa"

	pizza fueAmasada: true; agregarTiempoDePreparacion: minutos</body>
</methods>

<methods>
<class-id>Pizzero</class-id> <category>initialize-release</category>

<body package="practica8" selector="initialize">initialize
	"Initialize a newly created instance. This method must answer the receiver."

	" *** Replace this comment with the appropriate initialization code *** "
	^self</body>
</methods>


<methods>
<class-id>Material class</class-id> <category>instance creation</category>

<body package="practica8" selector="newPeso:precio:">newPeso: unPeso precio: unPrecio
	"creo un nuevo Material con peso y precio especificados"

	^self new pesoUnitario: unPeso; precioUnitario: unPrecio; yourself</body>

<body package="practica8" selector="new">new
	"Answer a newly created and initialized instance."

	^super new initialize</body>
</methods>


<methods>
<class-id>Material</class-id> <category>accessing</category>

<body package="practica8" selector="precioUnitario:">precioUnitario: anObject
	precioUnitario := anObject</body>

<body package="practica8" selector="pesoUnitario:">pesoUnitario: anObject
	pesoUnitario := anObject</body>

<body package="practica8" selector="pesoUnitario">pesoUnitario
	^pesoUnitario</body>

<body package="practica8" selector="precioUnitario">precioUnitario
	^precioUnitario</body>
</methods>

<methods>
<class-id>Material</class-id> <category>initialize-release</category>

<body package="practica8" selector="initialize">initialize
	"Initialize a newly created instance. This method must answer the receiver."

	" *** Replace this comment with the appropriate initialization code *** "
	^self</body>
</methods>



</st-source>
