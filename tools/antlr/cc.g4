grammar cc ;


ALPHA    : [A-Za-z]+ ;
ALPHANUM : [A-Za-z0-9]+ ;
COLON    : ':' ;
DASH     : '-' ;
DOT      : '.' ;
DQUOTE   : '"' ;
STRING   : [A-Za-z0-9 ]+ ;
TEXT     : [A-Za-z0-9\r\n\t] ;
NL       : '\r' ;
WS       : [ \t]+ -> skip ;

/**
  Start of policy file grammar
**/
start: 'policies' COLON NL policy+ ;
policy: DASH name tags resource modes description comments pfilters actions ;
name: 'name' COLON POLICYNAME NL ;

tags: 'tags' NL DASH quotedString NL ;
quotedstring: DQUOTE STRING DQUOTE ;

resource: 'resource' COLON rtype NL ;
rtype: ALPHA DOT ALPHANUM | ALPHANUM ;

modes: 'mode' COLON NL mode ;
mode: MODETYPE COLON MODEVALUE NL ;

description: 'description' COLON NL STRING NL ;

comments: 'comments' COLON TEXT NL ;

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

