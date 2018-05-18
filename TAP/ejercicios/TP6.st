<?xml version="1.0"?>

<st-source>
<time-stamp>From VisualWorks® NonCommercial, 7.5 of April 16, 2007 on May 7, 2010 at 5:53:03 pm</time-stamp>
<!-- Package TP6* -->


<class>
<name>Compu</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>tamaño mMother pCargados </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>TP6</category>
<attributes>
<package>TP6</package>
</attributes>
</class>

<class>
<name>Pedido</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>tamañoPed programaPed </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>TP6</category>
<attributes>
<package>TP6</package>
</attributes>
</class>

<class>
<name>Ciber</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>agregarCompu progAUsar eRequerido programaPed tamañoPed </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>TP6</category>
<attributes>
<package>TP6</package>
</attributes>
</class>

<class>
<name>Programa</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>programa </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>TP6</category>
<attributes>
<package>TP6</package>
</attributes>
</class>


<shared-variable>
<name>tamaño</name>
<environment>Ciber</environment>
<private>false</private>
<constant>false</constant>
<category>As yet unclassified</category>
<attributes>
<package>TP6</package>
</attributes>
</shared-variable>





<methods>
<class-id>Compu</class-id> <category>accessing</category>

<body package="TP6" selector="tamaño:">tamaño: unEntero
	
	tamaño := unEntero</body>

<body package="TP6" selector="tamaño">tamaño

	^tamaño</body>

<body package="TP6" selector="mMother:">mMother: anObject
	mMother := anObject</body>

<body package="TP6" selector="pCargados:">pCargados: anObject
	pCargados := anObject</body>

<body package="TP6" selector="pCargados">pCargados
	^pCargados</body>

<body package="TP6" selector="mMother">mMother
	^mMother</body>
</methods>


<methods>
<class-id>Pedido</class-id> <category>accessing</category>

<body package="TP6" selector="tamañoPed">tamañoPed
	^tamañoPed</body>

<body package="TP6" selector="tamañoPed:">tamañoPed: anObject
	tamañoPed := anObject</body>

<body package="TP6" selector="programaPed">programaPed
	^programaPed</body>

<body package="TP6" selector="programaPed:">programaPed: anObject
	programaPed := anObject</body>
</methods>


<methods>
<class-id>Ciber</class-id> <category>accessing</category>

<body package="TP6" selector="tamañoPed:">tamañoPed: unEntero
	tamañoPed := unEntero</body>

<body package="TP6" selector="programaPed">programaPed
	^programaPed</body>

<body package="TP6" selector="programaPed:">programaPed: unaColeccion
	programaPed := unaColeccion</body>

<body package="TP6" selector="tamañoPed">tamañoPed
	^tamañoPed</body>
</methods>

<methods>
<class-id>Ciber</class-id> <category>preguntas</category>

<body package="TP6" selector="sumaEspacio:">sumaEspacio: unaColeccion
	|c|
	c := 0.
	unaColeccion do:[:sum | c := c + sum tamaño ].
	^c</body>

<body package="TP6" selector="satisfacenPedidos:deLista:">satisfacenPedidos: unaColeccion deLista: unPedido
	
	unaColeccion select: [:prog :tam | (prog pCargados includes: [ unPedido programaPed]) &amp; (tam tamaño &gt;= unPedido tamañoPed)].</body>

<body package="TP6" selector="tiene:esteProg:">tiene: unaColeccion esteProg: unProg
	
	^unaColeccion detect:[:prog | prog pCargados select:[:p | p programa = unProg]] ifNone: ['Nill']</body>

<body package="TP6" selector="marcasMother:">marcasMother: unaColeccion
	
	^unaColeccion select:[:p | p mMother ].</body>

<body package="TP6" selector="cantDe:deTamaño:">cantDe: unaColeccion deTamaño: unEntero
	|cant|
	
	cant := unaColeccion select:[:tam | tam tamaño &gt; unEntero].

	^cant size.</body>

<body package="TP6" selector="agregarA:unaCompu:">agregarA: unaColeccion unaCompu: unaCompu

	unaColeccion add: unaCompu.</body>

<body package="TP6" selector="compusCopadas:">compusCopadas: unaColeccion
	
	^unaColeccion select:[:mot :pgr |  mot mMother = 'Asus' &amp; pgr size &gt; 4 ].</body>

<body package="TP6" selector="satisfacenPedidos:">satisfacenPedidos: unaColeccion
	
	unaColeccion select: [:prog :tam | (prog pCargados includes: [self programaPed]) &amp; (tam tamaño &gt;= self tamañoPed)].</body>
</methods>


<methods>
<class-id>Programa</class-id> <category>accessing</category>

<body package="TP6" selector="programa">programa
	^programa</body>

<body package="TP6" selector="programa:">programa: unaColeccion
	programa := unaColeccion</body>
</methods>



</st-source>
