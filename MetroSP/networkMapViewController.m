//
//  networkMapViewController.m
//  MetroSP
//
//  Created by Gustavo Clemente on 9/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "networkMapViewController.h"


@implementation networkMapViewController
@synthesize mapa = _mapa,
scroll = _scroll
;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [_scroll release];
    [_mapa release];
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
    
    [self iniciaMapa];
    
}


// call when zoom level or page size changes (i.e. after zooming or after rotation)
- (void)updateContentInsetForPageScrollView:(UIScrollView *)pageScrollView {

	CGFloat zoomScale = pageScrollView.zoomScale;
    
	CGSize imageSize = self.mapa.bounds.size;
	CGSize zoomedImageSize = CGSizeMake(imageSize.width * zoomScale, imageSize.height * zoomScale);
	CGSize pageSize = pageScrollView.bounds.size;
    
	UIEdgeInsets inset = UIEdgeInsetsZero;
	if (pageSize.width > zoomedImageSize.width) {
		inset.left = (pageSize.width - zoomedImageSize.width) / 2;
		inset.right = -inset.left;
	}
	if (pageSize.height > zoomedImageSize.height) {
		inset.top = (pageSize.height - zoomedImageSize.height) / 2;
		inset.bottom = -inset.top;
	}
	pageScrollView.contentInset = inset;
}

-(void)scrollViewDidZoom:(UIScrollView *)pageScrollView {
	[self updateContentInsetForPageScrollView:pageScrollView];
}



- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	// loop through all pages, adjusting their sizes
	// and calling updateContentInsetForPageScrollView for each
}



- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    CGRect innerFrame = view.frame;
    CGRect scrollerBounds = scrollView.bounds;
    
    if ( ( innerFrame.size.width < scrollerBounds.size.width ) || ( innerFrame.size.height < scrollerBounds.size.height ) )
    {
        CGFloat tempx = view.center.x - ( scrollerBounds.size.width / 2 );
        CGFloat tempy = view.center.y - ( scrollerBounds.size.height / 2 );
        CGPoint myScrollViewOffset = CGPointMake( tempx, tempy);
        
        scrollView.contentOffset = myScrollViewOffset;
        
    }
    
    UIEdgeInsets anEdgeInset = { 0, 0, 0, 0};
    if ( scrollerBounds.size.width > innerFrame.size.width )
    {
        anEdgeInset.left = (scrollerBounds.size.width - innerFrame.size.width) / 2;
        anEdgeInset.right = -anEdgeInset.left; // I don't know why this needs to be negative, but that's what works
    }
    if ( scrollerBounds.size.height > innerFrame.size.height )
    {
        anEdgeInset.top = (scrollerBounds.size.height - innerFrame.size.height) / 2;
        anEdgeInset.bottom = -anEdgeInset.top; // I don't know why this needs to be negative, but that's what works
    }
    scrollView.contentInset = anEdgeInset;
    
    NSLog(@"Zoomed Scale: %f", scale);
}




- (UIView *) viewForZoomingInScrollView:(UIScrollView *)containerView
{
    NSLog(@"Zoom");
    return self.mapa;
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
}




-(void) iniciaMapa {

//    self.mapa = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 600, 500)];
//    
////    self.mapa = [[UIImageView alloc]initWithImage:[UIImage imageWithContentsOfFile:@"mapa_atualizado.png"]];
//  //  [self.mapa setFrame:CGRectMake(0, 0, 500, 600)];
//    
    
//	UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL fileURLWithPath:@"mapa_incompleto.png"]]]];
	UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mapa_incompleto.png"]];

	
    [self setMapa:tempImageView];
    
	[tempImageView release];

    [self.scroll addSubview:self.mapa];
    
    [self.scroll setContentSize:CGSizeMake(self.mapa.frame.size.width, self.mapa.frame.size.height)];        
    self.scroll.backgroundColor = [UIColor clearColor];
    self.scroll.maximumZoomScale = 3.0f;
    self.scroll.minimumZoomScale = 0.25f;
    self.scroll.clipsToBounds = YES;
    self.scroll.zoomScale = 0.5;

    
    self.scroll.scrollEnabled = YES;
//    self.scroll.scrollsToTop = NO;
    self.scroll.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.scroll.delegate = self;
    

    //centraliza o mapa
    
    
    
    
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

@end
