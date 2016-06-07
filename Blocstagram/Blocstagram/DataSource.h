//
//  DataSource.h
//  Blocstagram
//
//  Created by MELANIE MCGANNEY on 6/6/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataSource : NSObject
//use a singleton pattern - any code ethat needs to use this class will share this one instance

+(instancetype) sharedInstance;
//add a property to store our array of media items
@property (nonatomic, strong, readonly) NSArray *mediaItems;

@end
