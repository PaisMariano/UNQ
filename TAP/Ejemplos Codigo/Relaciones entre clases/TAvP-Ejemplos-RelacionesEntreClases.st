<?xml version="1.0"?>

<st-source>
<time-stamp>From VisualWorks® NonCommercial, 7.5 of April 16, 2007 on March 16, 2010 at 6:01:39 am</time-stamp>
<!-- Package TAvP-Ejemplos-RelacionesEntreClases* -->


<class>
<name>ProductoVendido</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>descripcion detalle </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>TAvP-Ejemplos-RelacionesEntreClases</category>
<attributes>
<package>TAvP-Ejemplos-RelacionesEntreClases</package>
</attributes>
</class>

<class>
<name>Empleado</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>nombre antiguedad sector jefe </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>TAvP-Ejemplos-RelacionesEntreClases</category>
<attributes>
<package>TAvP-Ejemplos-RelacionesEntreClases</package>
</attributes>
</class>

<class>
<name>Persona</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>nombre edad area </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>TAvP-Ejemplos-RelacionesEntreClases</category>
<attributes>
<package>TAvP-Ejemplos-RelacionesEntreClases</package>
</attributes>
</class>

<class>
<name>Area</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>nombre </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>TAvP-Ejemplos-RelacionesEntreClases</category>
<attributes>
<package>TAvP-Ejemplos-RelacionesEntreClases</package>
</attributes>
</class>

<class>
<name>ElementoLista</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>detalle anterior siguiente </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>TAvP-Ejemplos-RelacionesEntreClases</category>
<attributes>
<package>TAvP-Ejemplos-RelacionesEntreClases</package>
</attributes>
</class>

<class>
<name>DetalleFactura</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>precioVenta nroOrden producto </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>TAvP-Ejemplos-RelacionesEntreClases</category>
<attributes>
<package>TAvP-Ejemplos-RelacionesEntreClases</package>
</attributes>
</class>







<methods>
<class-id>ProductoVendido class</class-id> <category>instance creation</category>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="new">new
	^self error: 'No se puede instanciar de esta manera.'</body>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="newDescripcion:">newDescripcion: desc

	^super new initDescripcion: desc</body>
</methods>


<methods>
<class-id>ProductoVendido</class-id> <category>initialize-release</category>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="initDescripcion:">initDescripcion: desc

	descripcion := desc.
	
	"detalle queda inconsistente, pero con la seguridad de que 
	DetalleFactura se encarga de darle el valor correcto"
	detalle := nil.

	^self</body>
</methods>

<methods>
<class-id>ProductoVendido</class-id> <category>accessing</category>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="detalle:">detalle: anObject
	detalle := anObject</body>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="descripcion">descripcion
	^descripcion</body>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="descripcion:">descripcion: anObject
	descripcion := anObject</body>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="detalle">detalle
	^detalle</body>
</methods>


<methods>
<class-id>Empleado class</class-id> <category>instance creation</category>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="newNombre:antig:sector:jefe:">newNombre: n antig: a sector: s jefe: j

	^super new initNombre: n antig: a sector: s jefe: j</body>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="new">new
	^self error: 'No se puede instanciar de esta manera.'</body>
</methods>


<methods>
<class-id>Empleado</class-id> <category>initialize-release</category>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="initNombre:antig:sector:jefe:">initNombre: n antig: a sector: s jefe: j

	nombre := n.
	antiguedad := a.
	sector := s.
	jefe := j.

	^self</body>
</methods>

<methods>
<class-id>Empleado</class-id> <category>accessing</category>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="jefe:">jefe: anObject
	jefe := anObject</body>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="antiguedad:">antiguedad: anObject
	antiguedad := anObject</body>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="antiguedad">antiguedad
	^antiguedad</body>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="jefe">jefe
	^jefe</body>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="nombre:">nombre: anObject
	nombre := anObject</body>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="sector:">sector: anObject
	sector := anObject</body>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="nombre">nombre
	^nombre</body>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="sector">sector
	^sector</body>
</methods>


<methods>
<class-id>Persona class</class-id> <category>instance creation</category>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="newNombre:edad:area:">newNombre: n edad: e area: a

	^super new initNombre: n edad: e area: a</body>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="new">new
	^self error: 'No se puede instanciar de esta manera.'</body>
</methods>


<methods>
<class-id>Persona</class-id> <category>initialize-release</category>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="initNombre:edad:area:">initNombre: n edad: e area: a

	nombre := n.
	edad := e.
	area := a.

	^self</body>
</methods>

<methods>
<class-id>Persona</class-id> <category>accessing</category>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="edad">edad
	^edad</body>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="nombre:">nombre: anObject
	nombre := anObject</body>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="area:">area: anObject
	area := anObject</body>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="nombre">nombre
	^nombre</body>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="edad:">edad: anObject
	edad := anObject</body>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="area">area
	^area</body>
</methods>


<methods>
<class-id>Area class</class-id> <category>instance creation</category>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="newNombre:">newNombre: n
	
	^super new initNombre: n</body>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="new">new
	^self error: 'No se puede instanciar de esta manera.'</body>
</methods>


<methods>
<class-id>Area</class-id> <category>accessing</category>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="nombre">nombre
	^nombre</body>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="nombre:">nombre: anObject
	nombre := anObject</body>
</methods>

<methods>
<class-id>Area</class-id> <category>initialize-release</category>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="initNombre:">initNombre: n

	nombre := n.

	^self</body>
</methods>


<methods>
<class-id>ElementoLista class</class-id> <category>instance creation</category>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="newDetalle:anterior:siguiente:">newDetalle: det anterior: ant siguiente: sig

	^super new initDetalle: det anterior: ant siguiente: sig</body>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="new">new
	^self error: 'No se puede instanciar de esta manera.'</body>
</methods>


<methods>
<class-id>ElementoLista</class-id> <category>initialize-release</category>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="initDetalle:anterior:siguiente:">initDetalle: det anterior: ant siguiente: sig

	detalle := det.
	anterior := ant.
	siguiente := sig.
	
	"Hay que enganchar el anterior y el siguiente al nuevo 
	elemento, si es posible."
	anterior notNil ifTrue: [anterior siguiente: self].
	siguiente notNil ifTrue: [siguiente anterior: self].
	
	^self</body>
</methods>

<methods>
<class-id>ElementoLista</class-id> <category>accessing</category>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="anterior:">anterior: anObject
	anterior := anObject</body>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="detalle:">detalle: anObject
	detalle := anObject</body>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="siguiente:">siguiente: anObject
	siguiente := anObject</body>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="siguiente">siguiente
	^siguiente</body>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="anterior">anterior
	^anterior</body>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="detalle">detalle
	^detalle</body>
</methods>


<methods>
<class-id>DetalleFactura class</class-id> <category>instance creation</category>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="newPrecio:orden:producto:">newPrecio: precio orden: nro producto: prod

	^super new initPrecio: precio orden: nro producto: prod</body>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="new">new
	^self error: 'No se puede instanciar de esta manera.'</body>
</methods>


<methods>
<class-id>DetalleFactura</class-id> <category>accessing</category>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="precioVenta:">precioVenta: anObject
	precioVenta := anObject</body>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="precioVenta">precioVenta
	^precioVenta</body>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="producto:">producto: anObject
	producto := anObject</body>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="nroOrden:">nroOrden: anObject
	nroOrden := anObject</body>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="nroOrden">nroOrden
	^nroOrden</body>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="producto">producto
	^producto</body>
</methods>

<methods>
<class-id>DetalleFactura</class-id> <category>initialize-release</category>

<body package="TAvP-Ejemplos-RelacionesEntreClases" selector="initPrecio:orden:producto:">initPrecio: precio orden: nro producto: prod

	precioVenta := precio.
	nroOrden := nro.
	producto := prod.
	
	"Aqui se establece la relacion bidireccional, 
	ya que ambas partes se conocen mutuamente"
	producto detalle: self.

	^self</body>
</methods>



</st-source>
