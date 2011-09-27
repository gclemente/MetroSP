//
//  getDirectionsViewController.m
//  MetroSP
//
//  Created by Gustavo Clemente on 9/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "getDirectionsViewController.h"

#define kOrigem  0
#define kDestino 1

@implementation getDirectionsViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        TBXML * tbmxml = [[TBXML alloc] initWithXMLFile:@"stations.xml"];
        
        
        listaEstacoes = [[NSMutableArray alloc] init];
        
        
        
        if (tbmxml.rootXMLElement) {
            
            TBXMLElement * elemento = tbmxml.rootXMLElement -> firstChild;
            
            while (elemento) {
                Estacao * estacao = [[Estacao alloc] init];
                for (NSString * nome in estacao.listaPropriedades){                
                    NSString * valor = [TBXML valueOfAttributeNamed:nome forElement:elemento]; 
                    
                    //verificar se Propriedade existe antes de atribuir
                    if (valor) {
                        [estacao setValue:valor forKey:nome];
                    }
                    NSLog(@"Nome: %@ / Valor: %@", nome, valor);
                }
                
                [listaEstacoes addObject:estacao];
                [estacao release];
                
                elemento = elemento -> nextSibling;
            }
        }
        
        [self iniciaAutoComplete];
        
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

    
    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


/*AUTOCOMPLETE*/

float tableHeight = 30;

- (void) finishedSearching {
	[txtField resignFirstResponder];
	autoCompleteTableView.hidden = YES;
    
    
}



/*teste auto complete*/

-(void) iniciaAutoComplete {
    
    dic = [[NSMutableDictionary alloc] init];
    
	elementArray = [[NSMutableArray alloc] init];
    
    for (Estacao * estacao in listaEstacoes) {
        
        
        //        
        //        NSString *decodedString = [NSString stringWithUTF8String:[[estacao tipo] cStringUsingEncoding:NSUTF8StringEncoding]];
        //        NSLog(@"%@",decodedString);
        //
        //       char * teste =  [decodedString UTF8String];
        
        
        
        //  NSString * nomeFormatado = [NSString  stringWithFormat:@"%@ (%@)", [estacao nome], [NSString stringWithUTF8String:teste] ];
        
        NSString * nomeFormatado = [NSString  stringWithFormat:@"%@ (%@)", [estacao nome], [estacao tipo] ];
        
        
        [elementArray addObject:nomeFormatado];
        [dic setValue:[estacao vertexId] forKey:nomeFormatado ];
    }
    
    
	autoCompleteArray = [[NSMutableArray alloc] init];
    
	
	//Autocomplete Table
	autoCompleteTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 260, tableHeight) style:UITableViewStylePlain];
	autoCompleteTableView.delegate = self;
	autoCompleteTableView.dataSource = self;
	autoCompleteTableView.scrollEnabled = YES;
	autoCompleteTableView.hidden = YES; 
	autoCompleteTableView.rowHeight = tableHeight;
	[self.view addSubview:autoCompleteTableView];
	[autoCompleteTableView release];
    
    
}



// Take string from Search Textfield and compare it with autocomplete array
- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring {
	
	// Put anything that starts with this substring into the autoCompleteArray
	// The items in this array is what will show up in the table view
	
	[autoCompleteArray removeAllObjects];
    
	for(NSString *curString in elementArray) {
        
        //Remove acentos
        NSData *stringAsciiData = [curString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString * semAcento =  [[[NSString alloc] initWithData:stringAsciiData encoding:NSUTF8StringEncoding] autorelease];
        
        
        
        if ([semAcento rangeOfString:substring options:NSCaseInsensitiveSearch].location == NSNotFound) {
            // NSLog(@"%@ does not contain %@", curString,substring);
        } else {
            [autoCompleteArray addObject:curString];
            NSLog(@"%@ contains %@", curString ,substring);
        }
        //        
        //        
        //        NSRange substringRangeLowerCase = [curString rangeOfString:[substring lowercaseString]];
        //		NSRange substringRangeUpperCase = [curString rangeOfString:[substring uppercaseString]];
        //        
        //		if (substringRangeLowerCase.length != 0 || substringRangeUpperCase.length != 0) {
        //            NSLog(@"filter: %@", curString);
        //			[autoCompleteArray addObject:curString];
        //		}
	}
	
	//autoCompleteTableView.hidden = NO;
	//[autoCompleteTableView reloadData];
}

// Close keyboard if the Background is touched
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[self.view endEditing:YES];
	[super touchesBegan:touches withEvent:event]; //super?
	[self finishedSearching];
}

#pragma mark UITextFieldDelegate methods

// Close keyboard when Enter or Done is pressed
- (BOOL)textFieldShouldReturn:(UITextField *)textField {    
	BOOL isDone = YES;
	
	if (isDone) {
		[self finishedSearching];
		return YES;
	} else {
		return NO;
	}	
} 

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    //atualiza o textView atual
    textoAtual = textField.tag;
    
    //zera o texto do textfield ao entrar.
    textField.text = @"";
    
    return YES;
    
}

// String in Search textfield
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	NSString *substring = [NSString stringWithString:textField.text];
	substring = [substring stringByReplacingCharactersInRange:range withString:string];
	[self searchAutocompleteEntriesWithSubstring:substring];
    
    
    
    //seta a posica do table baseado no textfield
    //    [autoCompleteTableView  setFrame:CGRectMake(textField.frame.origin.x ,
    //                                              textField.frame.origin.y + textField.frame.size.height , 
    //                                              autoCompleteTableView.frame.size.width,
    //                                               autoCompleteTableView.frame.size.height)];
    autoCompleteTableView.hidden = NO;
	[autoCompleteTableView reloadData];
    
    
    
    
	return YES;
}

#pragma mark UITableViewDelegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
    //qual texto chamou a table? //define local da table
    CGFloat x, y, yOffSet =0;
    yOffSet = 10.0f;
    
    if (textoAtual == kOrigem) {
        x = textOrigem.frame.origin.x;
        y = textOrigem.frame.origin.y  + textOrigem.frame.size.height + yOffSet;        
    }
    else{
        x = textDestino.frame.origin.x;
        y = textDestino.frame.origin.y + textDestino.frame.size.height + yOffSet;        
        
    }
    
    
	//Resize auto complete table based on how many elements will be displayed in the table
	if (autoCompleteArray.count >=3) {
		autoCompleteTableView.frame = CGRectMake(x, y, 259, tableHeight*3);
		return autoCompleteArray.count;
	}
	
	else if (autoCompleteArray.count == 2) {
		autoCompleteTableView.frame = CGRectMake(x, y, 259, tableHeight*2);
		return autoCompleteArray.count;
	}	
	
	else {
		autoCompleteTableView.frame = CGRectMake(x, y, 259, tableHeight);
		return autoCompleteArray.count;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = nil;
	static NSString *AutoCompleteRowIdentifier = @"AutoCompleteRowIdentifier";
	cell = [tableView dequeueReusableCellWithIdentifier:AutoCompleteRowIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AutoCompleteRowIdentifier] autorelease];
	}
    
    // [cell.imageView setImage:[UIImage imageNamed:@"icon_stations.png"]];
	cell.textLabel.text = [autoCompleteArray objectAtIndex:indexPath.row];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (textoAtual == kOrigem) 
    {
        //procura o vertexID do texto no dicionario
        idVertexOrigem = [[dic objectForKey:selectedCell.textLabel.text] integerValue];
        textOrigem.text = selectedCell.textLabel.text; 
    }
    else 
    {
        //procura o vertexID do texto no dicionario
        idVertexDestino = [[dic objectForKey:selectedCell.textLabel.text] integerValue];
        textDestino.text = selectedCell.textLabel.text;        
    }
    
    
	[self finishedSearching];
}


@end
