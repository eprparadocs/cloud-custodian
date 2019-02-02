grammar cc ;


ALPHA    : [A-Za-z]+ ;
ALPHANUM : [A-Za-z0-9]+ ;
COLON    : ':' ;
DASH     : '-' ;
DOT      : '.' ;
DQUOTE   : '"' ;
QSTRING  : '"' ~('\r' | '\n' | '"')* '"' ;
STRING   : ~('\r' | '\n' | '"')* ;
NL       : '\n' ;
WS       : [ \t]+ -> skip ;

/**
  Start of policy file grammar
**/
start: 'policies' COLON NL policy+ ;

policy: DASH name tags resource pmodes description comments pfilters actions ;

name: 'name' COLON pname NL ;
pname: POLICYNAME ;

tags: 'tags' NL tag+ ; 
tag: DASH QSTRING NL ;

resource: 'resource' COLON rtype NL ;
rtype: ALPHA DOT ALPHANUM | ALPHANUM ;

pmodes: 'mode' COLON NL (typemode | tagsmode | eventsmode) ;
typemode: 'type' COLON STRING NL ;
tagsmode: 'tags' COLON NL tagtag+ ;
tagtag: STRING NL ;
eventsmode: sourceevent | eventevent | idevent ;
sourceevent: 'source' COLON dottedname NL ;
eventevent: 'event' COLON STRING NL ;
idevent: 'id' COLON QSTRING NL ;
dottedname: STRING (DOT STRING)? ; 

description: 'description' COLON NL STRING NL ;

comments: 'comments' COLON STRING NL ;

pfilters: 'filters' COLON NL pfilter+ ;
pfilter: DASH FILTERTYPE COLON FILTERVALUE NL ;

actions: 'actions' COLON NL action+ ;
action: DASH 'type' TYPEVALUE NL ;

POLICYNAME: ALPHA [A-Za-z\-]+ ;
FILTERTYPE: [a-z]+ ;
FILTERVALUE: [a-z\-]+ ;
TYPEVALUE: [a-z\-]+ ;

MODETYPE: [A-Za-z] ;
MODEVALUE: STRING ;

