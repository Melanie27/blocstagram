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

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//test to ensure that [ComposeCommentView -setText:] sets isWritingComment to Yes if there's text
-(void)testThatComposeCommentViewTracksWriting {
  
    //when text is set, update text view
    NSString *text = @"there is text in here";
    
    BOOL isWriting = [self.composeCommentView textDidChange:text];
    XCTAssertTrue(isWriting == YES, @"There is text in the comment box");
}

//test to ensure that [ComposeCommentView -setText:] sets isWritingComent to No if there's no text
-(void)testThatComposeCommentViewSeesNoText {
    BOOL isWriting = [commentView isWritingComment:nil];
    XCTAssertTrue(isWriting == NO, @"There is no text in the comment box");
}

@end
