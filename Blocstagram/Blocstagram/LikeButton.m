//
//  LikeButton.m
//  Blocstagram
//
//  Created by MELANIE MCGANNEY on 6/20/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "LikeButton.h"
#import "CircleSpinnerView.h"

//define image names
#define kLikedStateImage @"heart-full"
#define kUnlikedStateImage @"heart-empty"

@interface LikeButton ()

@property (nonatomic, strong) CircleSpinnerView *spinnerView;

@end

@implementation LikeButton

//create the spinner view and set up like button

-(instancetype) init {
    self = [super init];
    
    if(self) {
        self.spinnerView = [[CircleSpinnerView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [self addSubview:self.spinnerView];
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        //provides a buffer between the edge of the button and the content
        self.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        //specifies the alignment of the button's content, centered by default
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        
        self.likeButtonState = LikeStateNotLiked;
    }
    
    return self;
}

//the spinner view's frame should be updated whenever the button's frame changes
-(void) layoutSubviews {
    [super layoutSubviews];
    self.spinnerView.frame = self.imageView.frame;
}

//this setter updates the button's appearance based on the set state passed in and hide/shows spinner
-(void) setLikeButtonState:(LikeState)likeState {
   _likeButtonState = likeState;
    
    NSString *imageName;
    
    switch (_likeButtonState) {
        case LikeStateLiked:
        case LikeStateUnliking:
            imageName = kLikedStateImage;
            break;
            
        case LikeStateNotLiked:
        case LikeStateLiking:
            imageName = kUnlikedStateImage;
    }
    
    switch (_likeButtonState) {
        case LikeStateLiking:
        case LikeStateUnliking:
            self.spinnerView.hidden = NO;
            self.userInteractionEnabled = NO;
            break;
            
        case LikeStateLiked:
        case LikeStateNotLiked:
            self.spinnerView.hidden = YES;
            self.userInteractionEnabled = YES;
    }
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

@end
