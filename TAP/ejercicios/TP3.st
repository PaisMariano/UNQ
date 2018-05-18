<?xml version="1.0"?>

<st-source>
<time-stamp>From VisualWorks® NonCommercial, 7.5 of April 16, 2007 on April 17, 2010 at 4:18:27 am</time-stamp>
<!-- Package TP3* -->


<class>
<name>Micro</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>sentados cantAsientos parados cantParados volumen </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>TP3</category>
<attributes>
<package>TP3</package>
</attributes>
</class>

<class>
<name>Fiacas</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>TP3</category>
<attributes>
<package>TP3</package>
</attributes>
</class>

<class>
<name>Moderados</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>quiereSubir x </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>TP3</category>
<attributes>
<package>TP3</package>
</attributes>
</class>

<class>
<name>Obsecuentes</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>quiereSubir jefe </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>TP3</category>
<attributes>
<package>TP3</package>
</attributes>
</class>

<class>
<name>Apurados</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>puedeSubir </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>TP3</category>
<attributes>
<package>TP3</package>
</attributes>
</class>

<class>
<name>Claustrofobicos</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>quiereSubir </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>TP3</category>
<attributes>
<package>TP3</package>
</attributes>
</class>







<methods>
<class-id>Fiacas</class-id> <category>accessing</category>

<body package="TP3" selector="quiereSubir:">quiereSubir: unMicro

^(unMicro cantAsientos &gt; unMicro sentados)</body>
</methods>


<methods>
<class-id>Micro</class-id> <category>accessing</category>

<body package="TP3" selector="parados:">parados: anObject
	parados := anObject</body>

<body package="TP3" selector="puedeSubir:">puedeSubir: unaPersona

^(((sentados &lt; cantAsientos) or:[(parados &lt; cantParados)]) and: [unaPersona quiereSubir: self])

</body>

<body package="TP3" selector="volumen">volumen
	^volumen</body>

<body package="TP3" selector="cantParados:">cantParados: anObject
	cantParados := anObject</body>

<body package="TP3" selector="BajarPasajero:">BajarPasajero: unaPersona

((self puedeBajar: unaPersona) and: [sentados == 0])ifTrue:[parados := parados - 1].

((self puedeBajar: unaPersona) and: [sentados &gt; 0])ifTrue:[sentados := sentados - 1].

</body>

<body package="TP3" selector="cantAsientos:">cantAsientos: anObject
	cantAsientos := anObject</body>

<body package="TP3" selector="cantParados">cantParados
	^cantParados</body>

<body package="TP3" selector="parados">parados
	^parados</body>

<body package="TP3" selector="sentados:">sentados: anObject
	sentados := anObject</body>

<body package="TP3" selector="cantAsientos">cantAsientos
	^cantAsientos</body>

<body package="TP3" selector="puedeBajar:">puedeBajar: unaPersona

^(((sentados &gt; 0) or:[(parados &gt; 0)]))</body>

<body package="TP3" selector="SubirPasajero:">SubirPasajero: unaPersona

((self puedeSubir: unaPersona) and: [sentados == cantAsientos])ifTrue:[parados := parados + 1].

((self puedeSubir: unaPersona) and:[sentados &lt; cantAsientos])ifTrue:[sentados := sentados + 1].

</body>

<body package="TP3" selector="sentados">sentados
	^sentados</body>

<body package="TP3" selector="volumen:">volumen: anObject
	volumen := anObject</body>
</methods>


<methods>
<class-id>Moderados</class-id> <category>accessing</category>

<body package="TP3" selector="quiereSubir:">quiereSubir: unMicro

^((unMicro cantAsientos - unMicro sentados) &gt;= x ) or: [(unMicro cantParados - unMicro parados) &gt;= x]</body>

<body package="TP3" selector="x:">x: anObject
	x := anObject</body>
</methods>


<methods>
<class-id>Obsecuentes</class-id> <category>accessing</category>

<body package="TP3" selector="quiereSubir:">quiereSubir: unMicro	

^self jefe quiereSubir: unMicro.</body>

<body package="TP3" selector="jefe:">jefe: unaPersona

jefe := unaPersona.</body>

<body package="TP3" selector="jefe">jefe
	^jefe</body>
</methods>


<methods>
<class-id>Apurados</class-id> <category>accessing</category>

<body package="TP3" selector="quiereSubir:">quiereSubir: unMicro

^True</body>
</methods>


<methods>
<class-id>Claustrofobicos</class-id> <category>accessing</category>

<body package="TP3" selector="quiereSubir:">quiereSubir: unMicro
	^(unMicro volumen &gt;= 120)</body>
</methods>



</st-source>
