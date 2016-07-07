//
//  MediaTests.m
//  Blocstagram
//
//  Created by MELANIE MCGANNEY on 6/28/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Media.h"
#import "Comment.h"
#import "User.h"

@interface MediaTests : XCTestCase

@end

@implementation MediaTests

-(void)testThatInitializationWorks {
    NSDictionary *sourceDictionary = @{@"id":@"8675309",
                                       @"user":@{
                                               @"id":@11,
                                               @"username":@"user45",
                                               @"fullname":@"Person 45"
                                               },

                                       @"image" : @"http://www.example.com/example.jpg",
                                       
                                       @"downloadState" : @"BOOL downloadState = ",
                                       @"caption" : @{
                                                    @"text":@"a caption"
                                                    },
                                       @"comments" : @{@"data":@[
                                                               @{@"id":@45,
                                                                 @"text":@"Here is the actual comment",
                                                                 @"user":@{
                                                                     @"id":@10,
                                                                     @"username":@"user4",
                                                                     @"fullname":@"Person 4"
                                                                     }
                                                                 }
                                                               ]},
                                       @"likeState" : @"BOOL likeState = userHasLiked ? LikeStateLiked : LikeStateNotLiked",
                                       @"temporaray_comment": @"A temp comment here"};
    
    Media *testMedia = [[Media alloc] initWithDictionary:sourceDictionary];
    
    XCTAssertEqualObjects(testMedia.idNumber, sourceDictionary[@"id"], @"The ID number should be equal");
    
    XCTAssertEqualObjects(testMedia.user.userName, sourceDictionary[@"user"][@"username"], @"The user name should be equal");
    
   
    XCTAssertTrue(testMedia.downloadState == MediaDownloadStateNonRecoverableError, @"There is no standard resolution image");
    
    XCTAssertEqualObjects(testMedia.caption, sourceDictionary[@"caption"][@"text"], @"The caption should be equal");
    
 
    XCTAssertTrue([testMedia.comments[0].text isEqualToString:@"Here is the actual comment"]);
    
    XCTAssertTrue(testMedia.likeState == NO, @"The like state switches from liked to unliked but the method indicates that it does not");
    
    
    XCTAssertEqualObjects(testMedia.temporaryComment, sourceDictionary[@"temporary_comment"], @"The temp comments should be equal");
}



- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}




@end
