//
//  MediaTableViewCell.h
//  Blocstagram
//
//  Created by MELANIE MCGANNEY on 6/7/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Media;

//each cell will be associated with a single media item

@interface MediaTableViewCell : UITableViewCell

@property (nonatomic, strong) Media *mediaItem;
//+ signifies that this method belongs to the class
+(CGFloat) heightForMediaItem:(Media *)mediaItem width:(CGFloat)width;

//Get Media item

-(Media *)mediaItem;


//Set Media item

-(void)setMediaItem:(Media *)mediaItem;

@end
