//
//  Comment.m
//  Blocstagram
//
//  Created by MELANIE MCGANNEY on 6/6/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "Comment.h"
#import "User.h"

@implementation Comment
- (instancetype) initWithDictionary:(NSDictionary *)commentsDictionary {
    self = [super init];
    
    if (self) {
        self.idNumber = commentsDictionary[@"id"];
        self.text = commentsDictionary[@"text"];
        self.from = [[User alloc] initWithDictionary:commentsDictionary[@"comments"]];
        NSLog(@"%@", self.idNumber);
    }
    
    return self;
}
@end
