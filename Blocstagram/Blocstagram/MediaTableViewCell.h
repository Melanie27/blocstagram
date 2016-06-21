//
//  MediaTableViewCell.h
//  Blocstagram
//
//  Created by MELANIE MCGANNEY on 6/7/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Media, MediaTableViewCell;

@protocol MediaTableViewCellDelegate <NSObject>

-(void) cell:(MediaTableViewCell *)cell didTapImageView:(UIImageView *)imageView;

//add delegate method for sharing

-(void) cell:(MediaTableViewCell *)cell didLongPressImageView:(UIImageView *)imageView;

//add delegate method to retry image download when user taps on cell with 2 fingers

-(void) cell:(MediaTableViewCell *)cell didDoubleFingerTapView:(UIImageView *)imageView;

@end

//each cell will be associated with a single media item

@interface MediaTableViewCell : UITableViewCell

@property (nonatomic, strong) Media *mediaItem;
@property(nonatomic, weak) id <MediaTableViewCellDelegate> delegate;
//+ signifies that this method belongs to the class
+(CGFloat) heightForMediaItem:(Media *)mediaItem width:(CGFloat)width;

//Get Media item

-(Media *)mediaItem;


//Set Media item

-(void)setMediaItem:(Media *)mediaItem;

@end
