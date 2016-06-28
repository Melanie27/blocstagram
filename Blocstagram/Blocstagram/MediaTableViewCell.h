//
//  MediaTableViewCell.h
//  Blocstagram
//
//  Created by MELANIE MCGANNEY on 6/7/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Media, MediaTableViewCell, ComposeCommentView;

@protocol MediaTableViewCellDelegate <NSObject>

-(void) cell:(MediaTableViewCell *)cell didTapImageView:(UIImageView *)imageView;

//add delegate method for sharing

-(void) cell:(MediaTableViewCell *)cell didLongPressImageView:(UIImageView *)imageView;

- (void) cellDidPressLikeButton:(MediaTableViewCell *)cell;

- (void) cellWillStartComposingComment:(MediaTableViewCell *)cell;
- (void) cell:(MediaTableViewCell *)cell didComposeComment:(NSString *)comment;

@end

//each cell will be associated with a single media item

@interface MediaTableViewCell : UITableViewCell

@property (nonatomic, strong) Media *mediaItem;
@property(nonatomic, weak) id <MediaTableViewCellDelegate> delegate;
@property (nonatomic, strong, readonly) ComposeCommentView *commentView;

@property (nonatomic, strong) UITraitCollection *overrideTraitCollection;



//+ signifies that this method belongs to the class
//+(CGFloat) heightForMediaItem:(Media *)mediaItem width:(CGFloat)width;
+(CGFloat) heightForMediaItem:(Media *)mediaItem width:(CGFloat)width traitCollection:(UITraitCollection *) traitCollection;

-(void) stopComposingComment;

//Get Media item

-(Media *)mediaItem;


//Set Media item

-(void)setMediaItem:(Media *)mediaItem;

@end
