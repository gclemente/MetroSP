//
//  networkMapViewController.h
//  MetroSP
//
//  Created by Gustavo Clemente on 9/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface networkMapViewController : UIViewController <UIScrollViewDelegate, UIGestureRecognizerDelegate> {
 
    CGFloat lastScale;    
    
}

@property (nonatomic, retain) UIImageView * mapa;
@property (nonatomic, retain) IBOutlet UIScrollView * scroll;


-(void) iniciaMapa ;
@end
