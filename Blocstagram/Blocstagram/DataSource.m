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


//pattern states that property can only be modified by the DataSource instance
//make mediaItems key-value compliant
@interface DataSource() {
    //an array must be accessible as an instance variable named _<key>
    NSMutableArray *_mediaItems;
    
}

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
        [self addRandomData];
    }
    
    return self;
}

//lots of methods to generate random data for us when the class gets initialized

-(void) addRandomData {
    NSMutableArray *randomMediaItems = [NSMutableArray array];
    
    for (int i = 1; i <=10; i++) {
       //loads every placeholder image
        
        NSString *imageName = [NSString stringWithFormat:@"%d.jpg", i];
        UIImage *image = [UIImage imageNamed:imageName];
        
        
        if(image) {
           //creates media model
            Media *media = [[Media alloc] init];
            
            //attaches a randomly generated user to the model
            media.user = [self randomUser];
            media.image = image;
            
            //adds a random caption
            media.caption = [self randomSentence];
            
            NSUInteger commentCount = arc4random_uniform(10) + 2;
            NSMutableArray *randomComments = [NSMutableArray array];
            
            for (int i = 0; i <= commentCount; i++ ) {
                Comment *randomComment = [self randomComment];
                [randomComments addObject:randomComment];
            }
            // attaches randomly generated number of comments
            media.comments = randomComments;
            
            [randomMediaItems addObject:media];
        }
    }
    
    self.mediaItems = randomMediaItems;
}

-(User *) randomUser {
    
    User *user = [[User alloc] init];
    
    user.userName = [self randomStringOfLength:arc4random_uniform(10) + 2];
    
    NSString *firstName = [self randomStringOfLength:arc4random_uniform(7) + 2];
    NSString *lastName = [self randomStringOfLength:arc4random_uniform(12) + 2];
    user.fullName = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    
    return user;
    
}

-(Comment *) randomComment {
    
    Comment *comment = [[Comment alloc] init];
    
    comment.from = [self randomUser];
    comment.text = [self randomSentence];
    
    return comment;
}

-(NSString *) randomSentence {
    NSUInteger wordCount = arc4random_uniform(20) +2;
    
    NSMutableString *randomSentence = [[NSMutableString alloc] init];
    
    for (int i=0; i<=wordCount; i++) {
        NSString *randomWord = [self randomStringOfLength:arc4random_uniform(12) +2];
        [randomSentence appendFormat:@"%@", randomWord];
    }
    
    return randomSentence;
}

-(NSString *) randomStringOfLength:(NSUInteger) len {
    NSString *alphabet = @"abcdefghijklmnopqrstuvwxyz";
    
    NSMutableString *s = [NSMutableString string];
    
    for(NSUInteger i =0U; i < len; i++) {
        u_int32_t r = arc4random_uniform((u_int32_t)[alphabet length]);
        unichar c = [alphabet characterAtIndex:r];
        [s appendFormat:@"%C", c];
    }
    
    return [NSString stringWithString:s];
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
        
        //#2
        //create new random media object and append it to the front of the array
        Media *media = [[Media alloc] init];
        media.user =[self randomUser];
        media.image = [UIImage imageNamed:@"10.jpg"];
        media.caption = [self randomSentence];
        
        NSMutableArray *mutableArrayWithKVO = [self mutableArrayValueForKey:@"mediaItems"];
        [mutableArrayWithKVO insertObject:media atIndex:0];
        
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
    
        Media *media = [[Media alloc] init];
        media.user = [self randomUser];
        media.image = [UIImage imageNamed:@"1.jpg"];
        media.caption = [self randomSentence];
        
        NSMutableArray *mutableArrayWithKVO = [self mutableArrayValueForKey:@"mediaItems"];
        [mutableArrayWithKVO addObject:media];
        
        self.isLoadingOlderItems = NO;
        
        if (completionHandler) {
            completionHandler(nil);
        }
    }
}









@end
