//
//  ComposeCommentViewTests.m
//  Blocstagram
//
//  Created by MELANIE MCGANNEY on 7/2/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ComposeCommentView.h"

@interface ComposeCommentViewTests : XCTestCase

@end

@implementation ComposeCommentViewTests
ComposeCommentView *ccv;
- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    //init a view of the comment box and create a frame for it
    ccv = [[ComposeCommentView alloc] initWithFrame:CGRectMake(0, 0, 400, 200)];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//test to ensure that [ComposeCommentView -setText:] sets isWritingComment to Yes if there's text
-(void)testThatComposeCommentViewTracksWriting {
    //run setText method on a string
    [ccv setText:@"text comment"];
    XCTAssertTrue(ccv.isWritingComment == YES, @"There is text in the comment box");
}

//test to ensure that [ComposeCommentView -setText:] sets isWritingComent to No if there's no text
-(void)testThatComposeCommentViewSeesNoText {
    //run setText method on an empty string
    [ccv setText:@""];
    XCTAssertTrue(ccv.isWritingComment == NO, @"There is no text in the comment box");
}

@end
