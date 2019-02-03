grammar cc ;

@members {
DEF_CLOUD_PROVIDER = 'aws'
cloud_provider = None
}

LETTER : [a-zA-Z] ;
fragment DIGIT : [0-9]+ ;
DASH : '-' ;
ID : LETTER (LETTER | DIGIT)* ;

CLOUDPROVIDER : ('aws' | 'gcp' | 'azure') ;

PNAME : ID (ID | DASH)* ;

DOT      : '.' ;
NL       : '\n' | '\r' | '\r''\n' ;
WS       : [ \t]+ -> skip ;


POLICIES : 'policies:' ;
NAME     : 'name:' ;
RESOURCE : 'resource:' ;

/**
  Start of policy file grammar
**/
startRule: POLICIES NL 
		policyname NL
		resource NL ;

policyname: DASH NAME PNAME {
print('POLICY NAME '+ $PNAME.text)
};


resource: RESOURCE rtype  {
print('CLOUD PROVIDER ' + self.cloud_provider)
print('RESOURCE TYPE ' + self.resource_type)
};

rtype: CLOUDPROVIDER DOT ID {
print('DOTTED')
self.cloud_provider = $CLOUDPROVIDER.text
self.resource_type = $ID.text
}
   | ID {
self.cloud_provider = self.DEF_CLOUD_PROVIDER
self.resource_type = $ID.text
};


