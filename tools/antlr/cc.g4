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
COLON: ':' ;


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
POLICIES    : 'policies:' ;
NAME        : 'name:' ;
RESOURCE    : 'resource:' ;
TAGS        : 'tags:' ;
MODE        : 'mode:' ;
TYPE        : 'type:' ;
TYPENOCOLON : 'type' ;
SOURCE      : 'source:';
EVENT       : 'event:' ;
ID          : 'id:' ;
DESCRIPTION : 'description:' ;
COMMENTS    : 'comments: ' ;
FILTERS     : 'filters:' ;
ACTIONS     : 'actions:' ;

/*
 * Supported Cloud Providers
 */
AWS      : 'aws' ;
GCP      : 'gcp' ;
AZURE    : 'azure' ;
CLOUDPROVIDER : AWS | GCP | AZURE ;


/**
  Start of policy file grammar
**/
startRule:      POLICIES NL policy+ ;


policy: DASH NAME PNAME NL 
	RESOURCE (CLOUDPROVIDER DOT)? ID NL
	rest+
	;
rest: tags |  pmodes | description | comments | pfilters | actions ;


tags: TAGS NL tag+ ; 
tag: DASH QSTRING NL ;

pmodes: MODE NL (typemode | tagsmode | eventsmode) ;
typemode: TYPE STRING NL ;
tagsmode: TAGS NL tagtag+ ;
tagtag: STRING NL ;
eventsmode: sourceevent | eventevent | idevent ;
sourceevent: SOURCE dottedname NL ;
eventevent: EVENT STRING NL ;
idevent: ID QSTRING NL ;
dottedname: STRING (DOT STRING)? ; 

description: DESCRIPTION NL STRING NL ;

comments: COMMENTS STRING NL ;

pfilters: FILTERS NL pfilter+ ;
pfilter: DASH FILTERTYPE COLON FILTERVALUE NL ;

actions: ACTIONS NL action+ ;
action: DASH TYPEBOCOLON TYPEVALUE NL ;

FILTERTYPE: [a-z]+ ;
FILTERVALUE: [a-z\-]+ ;
TYPEVALUE: [a-z\-]+ ;

MODETYPE: [A-Za-z] ;
MODEVALUE: STRING ;

