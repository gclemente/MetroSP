//
//  getDirectionsViewController.h
//  MetroSP
//
//  Created by Gustavo Clemente on 9/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBXMLEx.h"
#import "Estacao.h"


@interface getDirectionsViewController : UIViewController  <UITableViewDelegate, UITextFieldDelegate, UITableViewDataSource> {
    NSMutableArray * listaEstacoes;
	NSMutableArray *autoCompleteArray; 
	NSMutableArray *elementArray, *lowerCaseElementArray;
	UITextField *txtField;
	UITableView *autoCompleteTableView;
    NSMutableDictionary * dic;
    
    int textoAtual;
    
    
    int idVertexOrigem, idVertexDestino;
    
    IBOutlet UITextField * textOrigem, * textDestino;
}


-(void) iniciaAutoComplete;

@end
