//
//  MediaTests.m
//  Blocstagram
//
//  Created by MELANIE MCGANNEY on 6/28/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Media.h"

@interface MediaTests : XCTestCase

@end

@implementation MediaTests

-(void)testThatInitializationWorks {
    NSDictionary *sourceDictionary = @{@"id":@"8675309",
                                       @"user" : @"d'oh",
                                       @"image" : @"http://www.example.com/example.jpg",
                                       
                                       @"downloadState" : @"BOOL downloadState = ",
                                       @"caption" : @"this is a caption",
                                       @"comments" : @[@"string", @"string2",@"string3"],
                                       @"likeState" : @"BOOL likeState = userHasLiked ? LikeStateLiked : LikeStateNotLiked",
                                       @"temporaray_comment": @"A temp comment here"};
    
    Media *testMedia = [[Media alloc] initWithDictionary:sourceDictionary];
    
    XCTAssertEqualObjects(testMedia.idNumber, sourceDictionary[@"id"], @"The ID number should be equal");
    
    XCTAssertEqualObjects(testMedia.user, sourceDictionary[@"user"], @"The user name should be equal");
    
    XCTAssertEqualObjects(testMedia.mediaURL, [NSURL URLWithString:sourceDictionary[@"image"]], @"The image should be equal");
    
    
    XCTAssertTrue(testMedia.downloadState == YES, @"The download state switches from downloaded to not downloaded but the method indicates that it does not");
    
    XCTAssertEqualObjects(testMedia.caption, sourceDictionary[@"caption"], @"The caption should be equal");
    
    //XCTAssertEqualObjects(testMedia.comments sourceDictionary[NSArray arrayWithObjects: @"string", @"string2", @"string3"], @"The comments array should be equal");
    
    
    XCTAssertTrue(testMedia.likeState == YES, @"The like state switches from liked to unliked but the method indicates that it does not");
    
    
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
