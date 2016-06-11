//
//  DataSource.m
//  Blocstagram
//
//  Created by MELANIE MCGANNEY on 6/6/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "DataSource.h"
#import "User.h"
#import "Media.h"
#import "Comment.h"
#import "LoginViewController.h"


//pattern states that property can only be modified by the DataSource instance
//make mediaItems key-value compliant
@interface DataSource() {
    //an array must be accessible as an instance variable named _<key>
    NSMutableArray *_mediaItems;
    
}

@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSArray *mediaItems;

//add BOOL property to track whether a refresh is already in progress
@property (nonatomic, assign) BOOL isRefreshing;

//add BOOL property to track if loading old items is in progress

@property (nonatomic, assign) BOOL isLoadingOlderItems;


@end

@implementation DataSource


+(instancetype) sharedInstance {
    //the dispatch_once function ensures we only create a single instance of this class. function takes a block of code and runs it only the first time it is called
    static dispatch_once_t once;
    
    //a static variable "sharedInstance" holds the shared instance
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    
    });
    return sharedInstance;
}

-(instancetype) init {
    self = [super init];
    
    if (self) {
        
        //register and respond to notification
        [self registerForAccessTokenNotification];
    }
    
    return self;
}


- (void) registerForAccessTokenNotification {
    [[NSNotificationCenter defaultCenter] addObserverForName:LoginViewControllerDidGetAccessTokenNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        self.accessToken = note.object;
    }];
}


#pragma mark - Key/Value Observing

//add accessor methods that will allow observers to be notified when the content of the array changes
-(NSUInteger) countOfMediaItems {
    return self.mediaItems.count;
}

-(id) objectInMediaItemsAtIndex:(NSUInteger)index {
    return [self.mediaItems objectAtIndex:index];
}

-(NSArray *) mediaItemsAtIndexes:(NSIndexSet *)indexes {
    return [self.mediaItems objectAtIndex:indexes];
}


//Add mutable accessor methods. KVC methods that allow insertion and deletion of elements from mediaItems

- (void) insertObject:(Media *)object inMediaItemsAtIndex:(NSUInteger)index {
    [_mediaItems insertObject:object atIndex:index];
}

- (void) removeObjectFromMediaItemsAtIndex:(NSUInteger)index {
    [_mediaItems removeObjectAtIndex:index];
}

- (void) replaceObjectInMediaItemsAtIndex:(NSUInteger)index withObject:(id)object {
    [_mediaItems replaceObjectAtIndex:index withObject:object];
}

//add method to DataSource that lets other classes delete a media item
-(void) deleteMediaItem:(Media *)item {
    NSMutableArray *mutableArrayWithKVO = [self mutableArrayValueForKey:@"mediaItems"];
    [mutableArrayWithKVO removeObject:item];
}

#pragma mark pull refresh

-(void) requestNewItemsWithCompletionHandler:(NewItemCompletionBlock)completionHandler {
    
    //#1
    if (self.isRefreshing == NO) {
        self.isRefreshing = YES;
        
        //TODO: Add Images
        
        //no longer in the process of refreshing
        self.isRefreshing = NO;
        
        if(completionHandler) {
            completionHandler(nil);
        }
    }
}


#pragma mark infinite scrolling

-(void) requestOldItemsWithCompletionHandler:(NewItemCompletionBlock)completionHandler {
    
    if(self.isLoadingOlderItems == NO) {
        self.isLoadingOlderItems = YES;
    
        //TODO: ADD Images
        
        self.isLoadingOlderItems = NO;
        
        if (completionHandler) {
            completionHandler(nil);
        }
    }
}

//instagram clientID

+ (NSString *) instagramClientID {
    return @"4e032fb50fa74aaf8a150e68a1cb6e48";
}

//method to request user's feed

- (void) populateDataWithParameters:(NSDictionary *)parameters {
    if (self.accessToken) {
        // only try to get the data if there's an access token
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            // do the network request in the background, so the UI doesn't lock up
            
            NSMutableString *urlString = [NSMutableString stringWithFormat:@"https://api.instagram.com/v1/users/self/feed/recent?access_token=%@", self.accessToken];
            
            for (NSString *parameterName in parameters) {
                // for example, if dictionary contains {count: 50}, append `&count=50` to the URL
                [urlString appendFormat:@"&%@=%@", parameterName, parameters[parameterName]];
            }
            
            NSURL *url = [NSURL URLWithString:urlString];
            
            if (url) {
                NSURLRequest *request = [NSURLRequest requestWithURL:url];
                
                NSURLResponse *response;
                NSError *webError;
                NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&webError];
                
                if (responseData) {
                    NSError *jsonError;
                    NSDictionary *feedDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonError];
                    
                    if (feedDictionary) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            // done networking, go back on the main thread
                            [self parseDataFromFeedDictionary:feedDictionary fromRequestWithParameters:parameters];
                        });
                    }
                }
            }
        });
    }
}

- (void) parseDataFromFeedDictionary:(NSDictionary *) feedDictionary fromRequestWithParameters:(NSDictionary *)parameters {
    NSLog(@"%@", feedDictionary);
}


@end
