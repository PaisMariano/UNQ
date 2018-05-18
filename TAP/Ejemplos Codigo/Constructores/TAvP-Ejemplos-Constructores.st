<?xml version="1.0"?>

<st-source>
<time-stamp>From VisualWorks® NonCommercial, 7.5 of April 16, 2007 on March 4, 2010 at 5:49:21 pm</time-stamp>
<!-- Package TAvP-Ejemplos-Constructores* -->


<component-property>
<name>TAvP-Ejemplos-Constructores</name> <type>package</type>
<property>comment</property> <value>'UNQ - Tecnicas Avanzadas de Programacion - 2010 semestre 1

Codigos de ejemplo : Constructores'</value>
</component-property>

<class>
<name>Empleado</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>nombre sueldo </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>TAvP-Ejemplos-Constructores</category>
<attributes>
<package>TAvP-Ejemplos-Constructores</package>
</attributes>
</class>

<class>
<name>Libro</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>titulo autor edicion </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>TAvP-Ejemplos-Constructores</category>
<attributes>
<package>TAvP-Ejemplos-Constructores</package>
</attributes>
</class>

<class>
<name>Impresora</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>nombre papel documentos </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>TAvP-Ejemplos-Constructores</category>
<attributes>
<package>TAvP-Ejemplos-Constructores</package>
</attributes>
</class>




<methods>
<class-id>Libro class</class-id> <category>instance creation</category>

<body package="TAvP-Ejemplos-Constructores" selector="new">new
	
	^self error: 'Las instancias de Libro se crean con #newTitulo:autor:edicion:'</body>

<body package="TAvP-Ejemplos-Constructores" selector="newTitulo:autor:edicion:">newTitulo: t autor: a edicion: e
	
	^super new initTitulo: t autor: a edicion: e</body>
</methods>


<methods>
<class-id>Libro</class-id> <category>initialize-release</category>

<body package="TAvP-Ejemplos-Constructores" selector="initTitulo:autor:edicion:">initTitulo: t autor: a edicion: e
	
	titulo := t.
	autor := a.
	edicion := e.
	
	^self</body>
</methods>

<methods>
<class-id>Libro</class-id> <category>accessing</category>

<body package="TAvP-Ejemplos-Constructores" selector="titulo:">titulo: anObject
	titulo := anObject</body>

<body package="TAvP-Ejemplos-Constructores" selector="autor">autor
	^autor</body>

<body package="TAvP-Ejemplos-Constructores" selector="titulo">titulo
	^titulo</body>

<body package="TAvP-Ejemplos-Constructores" selector="edicion:">edicion: anObject
	edicion := anObject</body>

<body package="TAvP-Ejemplos-Constructores" selector="autor:">autor: anObject
	autor := anObject</body>

<body package="TAvP-Ejemplos-Constructores" selector="edicion">edicion
	^edicion</body>
</methods>


<methods>
<class-id>Impresora class</class-id> <category>instance creation</category>

<body package="TAvP-Ejemplos-Constructores" selector="new">new

	^super new initialize</body>
</methods>


<methods>
<class-id>Impresora</class-id> <category>initialize-release</category>

<body package="TAvP-Ejemplos-Constructores" selector="initialize">initialize

	nombre := 'default printer'.
	papel := 'A4'.
	documentos := OrderedCollection new.  "Lista vacia"

	^self</body>
</methods>

<methods>
<class-id>Impresora</class-id> <category>accessing</category>

<body package="TAvP-Ejemplos-Constructores" selector="nombre:">nombre: anObject
	nombre := anObject</body>

<body package="TAvP-Ejemplos-Constructores" selector="papel">papel
	^papel</body>

<body package="TAvP-Ejemplos-Constructores" selector="nombre">nombre
	^nombre</body>

<body package="TAvP-Ejemplos-Constructores" selector="documentos:">documentos: anObject
	documentos := anObject</body>

<body package="TAvP-Ejemplos-Constructores" selector="papel:">papel: anObject
	papel := anObject</body>

<body package="TAvP-Ejemplos-Constructores" selector="documentos">documentos
	^documentos</body>
</methods>


<methods>
<class-id>Empleado class</class-id> <category>instance creation</category>

<body package="TAvP-Ejemplos-Constructores" selector="new">new
	^super new initialize</body>
</methods>


<methods>
<class-id>Empleado</class-id> <category>accessing</category>

<body package="TAvP-Ejemplos-Constructores" selector="nombre">nombre
	^nombre</body>

<body package="TAvP-Ejemplos-Constructores" selector="sueldo">sueldo
	^sueldo</body>
</methods>

<methods>
<class-id>Empleado</class-id> <category>initialize-release</category>

<body package="TAvP-Ejemplos-Constructores" selector="initialize">initialize
	"En este punto el objeto queda en estado inconsistente"

	nombre := nil.
	sueldo := nil.
	^self</body>
</methods>



</st-source>
