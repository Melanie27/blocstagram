//
//  DataSource.h
//  Blocstagram
//
//  Created by MELANIE MCGANNEY on 6/6/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Media;
@interface DataSource : NSObject
//use a singleton pattern - any cod ethat needs to use this class will share this one instance

+(instancetype) sharedInstance;
//add a property to store our array of media items
@property (nonatomic, strong, readonly) NSArray *mediaItems;

//declare method to add to DataSource that lets other classes delete a media item
-(void) deleteMediaItem: (Media *)item;

//declare method to add to DataSource that lets other classes move media item to the top
-(void) moveMediaItem: (Media *)item;


@end
