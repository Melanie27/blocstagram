//
//  Media.h
//  Blocstagram
//
//  Created by MELANIE MCGANNEY on 6/6/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LikeButton.h"
// enum declares MediaDownloadState as equiv to NSInteger with 4 predefined values
typedef NS_ENUM(NSInteger, MediaDownloadState) {
    MediaDownloadStateNeedsImage             = 0,
    MediaDownloadStateDownloadInProgress     = 1,
    MediaDownloadStateNonRecoverableError    = 2,
    MediaDownloadStateHasImage               = 3
};

@class User;

@interface Media : NSObject <NSCoding>

@property (nonatomic, strong) NSString *idNumber;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSURL *mediaURL;
@property (nonatomic, strong) UIImage *image;

//track individual media item's download state in a property
//assign because it is NSInteger - a simple type
@property (nonatomic, assign) MediaDownloadState downloadState;

@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) NSArray *comments;

@property (nonatomic, assign) LikeState likeState;

- (instancetype) initWithDictionary:(NSDictionary *)mediaDictionary;

@end
