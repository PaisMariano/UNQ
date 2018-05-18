<?xml version="1.0"?>

<st-source>
<time-stamp>From VisualWorks® NonCommercial, 7.5 of April 16, 2007 on April 11, 2010 at 5:09:11 am</time-stamp>
<!-- Package Ejemplos* -->


<class>
<name>Persona</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>nombre apellido padre madre dni </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>Ejemplos</category>
<attributes>
<package>Ejemplos</package>
</attributes>
</class>

<class>
<name>Punto</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>x y </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>Ejemplos</category>
<attributes>
<package>Ejemplos</package>
</attributes>
</class>

<class>
<name>DateLapse</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>from to </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>Ejemplos</category>
<attributes>
<package>Ejemplos</package>
</attributes>
</class>




<methods>
<class-id>Persona</class-id> <category>accessing</category>

<body package="Ejemplos" selector="padre">padre
	^padre</body>

<body package="Ejemplos" selector="madre">madre
	^madre</body>

<body package="Ejemplos" selector="apellido">apellido
	^apellido</body>

<body package="Ejemplos" selector="nombre:">nombre: anObject
	nombre := anObject</body>

<body package="Ejemplos" selector="dni:">dni: anObject
	dni := anObject</body>

<body package="Ejemplos" selector="nombre">nombre
	^nombre</body>

<body package="Ejemplos" selector="madre:">madre: anObject
	madre := anObject</body>

<body package="Ejemplos" selector="dni">dni
	^dni</body>

<body package="Ejemplos" selector="apellido:">apellido: anObject
	apellido := anObject</body>

<body package="Ejemplos" selector="padre:">padre: anObject
	padre := anObject</body>
</methods>


<methods>
<class-id>Punto</class-id> <category>accessing</category>

<body package="Ejemplos" selector="x">x
	^x</body>

<body package="Ejemplos" selector="y:">y: anObject
	y := anObject</body>

<body package="Ejemplos" selector="x:">x: anObject
	x := anObject</body>

<body package="Ejemplos" selector="y">y
	^y</body>
</methods>


<methods>
<class-id>DateLapse</class-id> <category>Metodos</category>

<body package="Ejemplos" selector="includesDate:">includesDate: date

	^date between: self from and: self to.</body>

<body package="Ejemplos" selector="sizeInDays">sizeInDays

	^self from subtractDate: self to.</body>
</methods>

<methods>
<class-id>DateLapse</class-id> <category>accessing</category>

<body package="Ejemplos" selector="from">from
	^from</body>

<body package="Ejemplos" selector="to">to
	^to</body>

<body package="Ejemplos" selector="from:">from: anObject
	from := anObject</body>

<body package="Ejemplos" selector="to:">to: anObject
	to := anObject</body>
</methods>



</st-source>
