grammar cc ;


ALPHA    : [A-Za-z]+ ;
ALPHANUM : [A-Za-z0-9]+ ;
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
startRule: 'policies:' NL policy+ ;

policy: name tags resource pmodes description comments pfilters actions ;

name: DASH 'name:' pname NL ;
pname: POLICYNAME ;

tags: 'tags:' NL tag+ ; 
tag: DASH QSTRING NL ;

resource: 'resource:' rtype NL ;
rtype: ALPHA DOT ALPHANUM | ALPHANUM ;

pmodes: 'mode:' NL (typemode | tagsmode | eventsmode) ;
typemode: 'type:' STRING NL ;
tagsmode: 'tags:' NL tagtag+ ;
tagtag: STRING NL ;
eventsmode: sourceevent | eventevent | idevent ;
sourceevent: 'source:' dottedname NL ;
eventevent: 'event:' STRING NL ;
idevent: 'id:' QSTRING NL ;
dottedname: STRING (DOT STRING)? ; 

description: 'description:' NL STRING NL ;

comments: 'comments:' STRING NL ;

pfilters: 'filters:' NL pfilter+ ;
pfilter: DASH FILTERTYPE ':' FILTERVALUE NL ;

actions: 'actions:' NL action+ ;
action: DASH 'type' TYPEVALUE NL ;

POLICYNAME: ALPHA [A-Za-z\-]+ ;
FILTERTYPE: [a-z]+ ;
FILTERVALUE: [a-z\-]+ ;
TYPEVALUE: [a-z\-]+ ;

MODETYPE: [A-Za-z] ;
MODEVALUE: STRING ;

