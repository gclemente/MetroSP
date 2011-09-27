//
//  RootViewController.h
//  MetroSP
//
//  Created by Gustavo Clemente on 9/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController {

}

-(void) criaVisual ;
-(void) montaDashBoardWith:(NSMutableArray *) lista andMinimalX:(CGFloat ) x andMinimalY:(CGFloat ) y;


-(void) openGetDirections;
-(void) openNetworkMap;
@end
