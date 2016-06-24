//
//  MediaFullScreenViewController.h
//  Blocstagram
//
//  Created by MELANIE MCGANNEY on 6/15/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Media;

@interface MediaFullScreenViewController : UIViewController

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;

//property to store the media object - in header now so that subclass can access it
@property (nonatomic, strong) Media *media;

//custom initializer you pass media object to display
 - (instancetype) initWithMedia:(Media *)media;

- (void) centerScrollView;

//add a method to allow subclasses to request recalculation of the zoom scales
-(void) recalculateZoomScale;

@end
