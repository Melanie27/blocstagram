//
//  DataSource.h
//  Blocstagram
//
//  Created by MELANIE MCGANNEY on 6/6/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Media;

//add new completion handler definition to our data source's header
//all instances of this actually refer to that
typedef void(^NewItemCompletionBlock)(NSError *error);


@interface DataSource : NSObject
//use a singleton pattern - any cod ethat needs to use this class will share this one instance

+(instancetype) sharedInstance;
//add a property to store our array of media items
@property (nonatomic, strong, readonly) NSArray *mediaItems;

//declare method to add to DataSource that lets other classes delete a media item
-(void) deleteMediaItem: (Media *)item;

//method for the table view to call when the user executes a pull-to-refresh gesture
-(void) requestNewItemsWithCompletionHandler:(NewItemCompletionBlock)completionHandler;

//method for the table view to call when the user scrolls past the bottom
-(void) requestOldItemsWithCompletionHandler:(NewItemCompletionBlock)completionHandler;

//we want other classes to be able to request that images be downloaded, so add this method to public interface
-(void) downloadImageForMediaItem: (Media *)mediaItem;

- (void) toggleLikeOnMediaItem:(Media *)mediaItem withCompletionHandler:(void (^)(void))completionHandler;

//handle comments
-(void) commentOnMediaItem:(Media *)mediaItem withCommentText:(NSString *)commentText;

//store Instagram Client ID
+ (NSString *) instagramClientID;

//store Instagram access token
@property (nonatomic, strong, readonly) NSString *accessToken;

@end
