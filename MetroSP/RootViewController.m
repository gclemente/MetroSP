//
//  RootViewController.m
//  MetroSP
//
//  Created by Gustavo Clemente on 9/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "getDirectionsViewController.h"

@implementation RootViewController



-(void) criaVisual {
    
    NSMutableArray * lista = [[NSMutableArray alloc] init];
    
    UIButton * btnTrajeto = [[UIButton buttonWithType:UIButtonTypeCustom]retain];
    [btnTrajeto setFrame:CGRectMake(0, 0, 100, 120)];
    [btnTrajeto setImage:[UIImage imageNamed:@"icon_direction_text.png"] forState:UIControlStateNormal];
    [btnTrajeto addTarget:self action:@selector(openGetDirections) forControlEvents:UIControlEventTouchUpInside];
    [lista addObject:btnTrajeto];
    [btnTrajeto release];
    
    
    UIButton * btnLinhasEstacoes = [[UIButton buttonWithType:UIButtonTypeCustom]retain];
    [btnLinhasEstacoes setFrame:CGRectMake(0, 0, 100, 120)];
    [btnLinhasEstacoes setImage:[UIImage imageNamed:@"icon_stations_text.png"] forState:UIControlStateNormal];
    [btnLinhasEstacoes setImage:[UIImage imageNamed:@"icon_stations_text.png"] forState:UIControlStateSelected];
    [btnLinhasEstacoes addTarget:self action:@selector(teste) forControlEvents:UIControlEventTouchUpInside];
    [lista addObject:btnLinhasEstacoes];
    [btnLinhasEstacoes release];
    
    UIButton * btnMapaLinha = [[UIButton buttonWithType:UIButtonTypeCustom]retain];
    [btnMapaLinha setFrame:CGRectMake(0, 0, 100, 120)];
    [btnMapaLinha setImage:[UIImage imageNamed:@"icon_map_text.png"] forState:UIControlStateNormal];
    [btnMapaLinha addTarget:self action:@selector(teste) forControlEvents:UIControlEventTouchUpInside];
    [lista addObject:btnMapaLinha];
    [btnMapaLinha release];
    
    UIButton * btnTempoReal = [[UIButton buttonWithType:UIButtonTypeCustom]retain];
    [btnTempoReal setFrame:CGRectMake(0, 0, 100, 120)];
    [btnTempoReal setImage:[UIImage imageNamed:@"icon_realtime_text.png"] forState:UIControlStateNormal];
    [btnTempoReal addTarget:self action:@selector(teste) forControlEvents:UIControlEventTouchUpInside];
    [lista addObject:btnTempoReal];
    [btnTempoReal release];
    
    UIButton * btnSMS = [[UIButton buttonWithType:UIButtonTypeCustom]retain];
    [btnSMS setFrame:CGRectMake(0, 0, 100, 120)];
    [btnSMS setTitle:@"SMS Den√∫ncia" forState:UIControlStateNormal];
    [btnSMS addTarget:self action:@selector(teste) forControlEvents:UIControlEventTouchUpInside];
    [lista addObject:btnSMS];
    [btnSMS release];
    
    UIButton * btnSobre = [[UIButton buttonWithType:UIButtonTypeCustom]retain];
    [btnSobre setFrame:CGRectMake(0, 0, 100, 120)];
    [btnSobre setTitle:@"Sobre" forState:UIControlStateNormal];
    [btnSobre addTarget:self action:@selector(teste) forControlEvents:UIControlEventTouchUpInside];
    [lista addObject:btnSobre];
    [btnSobre release];
    
    
    [self montaDashBoardWith:lista andMinimalX:20.0f andMinimalY:10.0f];
}

-(void) montaDashBoardWith:(NSMutableArray *) lista andMinimalX:(CGFloat ) x andMinimalY:(CGFloat ) y {
    int linhaAtual = 0;
    int colunaAtual = 0;
    
    
    for (UIView * vc in lista){
        //descobre o numero de componentes por linha (supoe que todos tenham o mesmo tamanho)
        int numeroColuna = (int)(self.view.frame.size.width / (vc.frame.size.width + x)) ;
        int numeroLinha = (int)(self.view.frame.size.height / (vc.frame.size.height + y)) ;        
        
        
        //quantidade de espaco vazio 
        int espacoX = numeroColuna + 1;        
        //quantidade de espaco tomado pelos componentes
        CGFloat tamanhoTomadoX = numeroColuna * vc.frame.size.width;
        //tamanho do espaco (numero de espacos (componentes + 1) dividido por espaco vazio )
        CGFloat tamanhoEspacoX =  (self.view.frame.size.width - tamanhoTomadoX) / espacoX;
        //quantidade de espaco vazio 
        int espacoY = numeroLinha + 1;
        //quantidade de espaco tomado pelos componentes
        CGFloat tamanhoTomadoY = numeroLinha * vc.frame.size.height;
        //tamanho do espaco (numero de espacos (componentes + 1) dividido por espaco vazio )
        CGFloat tamanhoEspacoY =  (self.view.frame.size.height - tamanhoTomadoY) / espacoY;
        
        [vc setFrame:CGRectMake((tamanhoEspacoX * (colunaAtual + 1)) + (vc.frame.size.width * colunaAtual), 
                                (tamanhoEspacoY * (linhaAtual + 1)) + (vc.frame.size.height * linhaAtual), 
                                vc.frame.size.width, vc.frame.size.height)];
        
        if ((colunaAtual + 1) == numeroColuna) {
            colunaAtual = 0;//zera
            linhaAtual++;     
        }
        else {
            colunaAtual++;            
        }
        
        
        //adiciona na view
        [self.view addSubview:vc];
        [vc release];
    }
    
}


-(void) openGetDirections {
    
    getDirectionsViewController * gdIpod = [[getDirectionsViewController alloc] initWithNibName:@"getDirectionsViewController" bundle:nil];

    [self.navigationController pushViewController:gdIpod animated:TRUE];
  
    //-(void) iniciaAutoComplete [gdIpod release];
    
}
-(void) teste {
    
    //inicia as classes de scroller
    
    
    //ziminji para gravar cada instancia num bd..
    
    
    //fara filtros por tipo, linha, estacao
    
    
    
    NSLog(@"teste");
}





- (void)viewDidLoad
{
    [super viewDidLoad];
    
     [self criaVisual];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationItem setTitle:@""];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    [self.navigationItem setTitle:@"Voltar"];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc
{
    [super dealloc];
}

@end
