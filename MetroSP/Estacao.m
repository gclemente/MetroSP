//
//  Estacao.m
//  MetrollandoSP
//
//  Created by Gustavo Clemente on 9/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Estacao.h"
#import <objc/runtime.h>

@implementation Estacao
@synthesize estacaoId   = _estacaoId,
            tipoId      = _tipoId,
            linhaId     = _linhaId,
            vertexId    = _vertexId,
            vertexType  = _vertexType,
            nome        = _nome,
            linha       = _linha,
            tipo        = _tipo,
            listaPropriedades = _listaPropriedades
;



-(id) init {
    
    if (self = [super init]) 
    {
        _listaPropriedades = [[NSMutableArray alloc] init];
        
   
        [self geraListaPropriedades];
        
    }
    
    
    return self;
}

-(void) geraListaPropriedades {
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for(i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        [self.listaPropriedades addObject:[NSString stringWithUTF8String:property_getName(property)]];
        //fprintf(stdout, "%s %s\n", property_getName(property), property_getAttributes(property));
    }
    free(properties);
    
    
}

-(void) dealloc {
    [_listaPropriedades release];
    
    [_estacaoId release];
    [_tipoId release];
    [_linhaId release];
    [_vertexId release];
    [_vertexType release];
    [_nome release];
    [_linha release];
    [_tipo release];
    
    [super dealloc];
    
}



@end
