//
//  LikeButton.h
//  Blocstagram
//
//  Created by MELANIE MCGANNEY on 6/20/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>
//define 4 possible states and expose a property for storing this state

typedef NS_ENUM(NSInteger, LikeState) {
    LikeStateNotLiked = 0,
    LikeStateLiking = 1,
    LikeStateLiked = 2,
    LikeStateUnliking = 3
};

@interface LikeButton : UIButton

//the current state of the like button
@property(nonatomic, assign) LikeState likeButtonState;

@end
