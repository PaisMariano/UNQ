<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><title>Data</title>
</head>
<body>
<table border=1>
<tr>{{#COLUMN}}
<td bgcolor=silver class='medium'>{{COLUMN_NAME}}</td>{{/COLUMN}}
</tr>{{#ROW}}
<tr>{{#FIELD}}
<td class='normal' valign='top'>{{FIELD_VALUE:html_escape}}</td>{{/FIELD}}
</tr>{{/ROW}}
</table>
</body></html>
