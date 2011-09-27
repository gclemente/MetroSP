//
//  Estacao.h
//  MetrollandoSP
//
//  Created by Gustavo Clemente on 9/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Estacao : NSObject {
    
}

@property (nonatomic, retain) NSMutableArray * listaPropriedades;
@property (nonatomic, retain) NSString * estacaoId, * vertexId, * vertexType, * linhaId, *tipoId;
@property (nonatomic, retain) NSString * nome, * linha, * tipo;

-(void) geraListaPropriedades;

@end
