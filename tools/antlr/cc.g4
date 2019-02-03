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
LETTER : [a-zA-Z] ;
DIGIT : [0-9]+ ;
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


tags: TAGS NL (tag NL)+ ; 
tag: ;

pmodes: MODE NL;

description: DESCRIPTIONS NL ;

comments: COMMENTS NL ;

pfilters: FILTERS NL (pfilter NL)+ ;
pfilter: ;

actions: ACTIONS NL (action NL)+ ;
action:  ;

