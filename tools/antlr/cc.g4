grammar cc ;

@members {
DEF_CLOUD_PROVIDER = 'aws'
cloud_provider = None
}

/*
 * Some single letter lex tokens
 */
DASH : '-' ;
DOT  : '.' ;

/*
 * Whitespace and end of line lexer tokens.
 */
NL       : '\n' | '\r' | '\r''\n' ;
WS       : [ \t]+ -> skip ;


/*
 * Definitions of various identifiers.
 */
fragment LETTER : [a-zA-Z] ;
fragment DIGIT : [0-9]+ ;
ID : LETTER (LETTER | DIGIT)* ;
PNAME : ID (ID | DASH)* ;


/*
 * Fixed words in the policy yaml files.
POLICIES : 'policies:' ;
NAME     : 'name:' ;
RESOURCE : 'resource:' ;
TAGS     : 'tags:' ;

/*
 * Supported Cloud Providers
 */
AWS      : 'aws' ;
GCP      : 'gcp' ;
AZURE    ; 'azure' ;
CLOUDPROVIDER : AWS | GCP | AZURE ;


/**
  Start of policy file grammar
**/
startRule:      POLICIES NL policy+ ;


policy: DASH NAME PNAME NL 
	RESOURCE (CLOUDPROVIDER DOT)? NL
	rest+
	;
rest: tags |  pmodes | description | comments | pfilters | actions ;


rtype: CLOUDPROVIDER DOT ID | ID;

tags: TAGS NL tag+ ; 
tag: DASH QSTRING NL ;CLOUDPROVIDER DOT ID | ID

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

FILTERTYPE: [a-z]+ ;
FILTERVALUE: [a-z\-]+ ;
TYPEVALUE: [a-z\-]+ ;

MODETYPE: [A-Za-z] ;
MODEVALUE: STRING ;

