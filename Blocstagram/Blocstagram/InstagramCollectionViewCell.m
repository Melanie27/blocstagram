//
//  InstagramCollectionViewCell.m
//  Blocstagram
//
//  Created by MELANIE MCGANNEY on 6/30/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "InstagramCollectionViewCell.h"
#import "PostToInstagramViewController.h"

@interface InstagramCollectionViewCell() 
    @property (nonatomic, strong) UIImage *sourceImage;

@end



@implementation InstagramCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
     self = [super initWithFrame:frame];
    
    if (self) {
        
        static NSInteger imageViewTag = 1000;
        static NSInteger labelTag = 1001;
        
        UIImageView *thumbnail = (UIImageView *)[self.contentView viewWithTag:imageViewTag];
        UILabel *label = (UILabel *)[self.contentView viewWithTag:labelTag];
        CGFloat thumbnailEdgeSize = 120;
        
        if (!thumbnail) {
            thumbnail = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, thumbnailEdgeSize, thumbnailEdgeSize)];
            thumbnail.contentMode = UIViewContentModeScaleAspectFill;
            thumbnail.tag = imageViewTag;
            thumbnail.clipsToBounds = YES;
            
            [self.contentView addSubview:thumbnail];
        }
        
        if (!label) {
            label = [[UILabel alloc] initWithFrame:CGRectMake(0,thumbnailEdgeSize, thumbnailEdgeSize, 20)];
            label.tag = labelTag;
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:10];
            [self.contentView addSubview:label];
        }

        
    }
    
    return self;

}

@end
