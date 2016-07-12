//
//  MediaTableViewCellTests.m
//  Blocstagram
//
//  Created by MELANIE MCGANNEY on 7/5/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MediaTableViewCell.h"
#import "Media.h"

@interface MediaTableViewCellTests : XCTestCase
@property (nonatomic, strong) UIImage *test1;
@property (nonatomic, strong) Media *mediaItem1;
@property (nonatomic, strong) UITraitCollection *tc;

@end


@implementation MediaTableViewCellTests
MediaTableViewCell *mtvc;
- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.

    //self.test1 = [UIImage imageNamed:@"test1.jpg"];
     //NSLog(@"image height: %f", _test1.size.height);

    
    NSDictionary *sourceDictionary = @{@"id":@"8675309",
                                       @"user":@{
                                               @"id":@11,
                                               @"username":@"user45",
                                               @"fullname":@"Person 45"
                                               },
                                       
                                       @"images" : @{ @"standard_resolution" : @{ @"url" : @"https://scontent-lax3-1.cdninstagram.com/t51.2885-15/s640x640/sh0.08/e35/12445948_1723725777916979_1650061249_n.jpg?ig_cache_key=MTI4MTM4MTQ2MTAzMDYxOTM2MA%3D%3D.2" } },
                                       
                                       @"downloadState" : @"BOOL downloadState = ",
                                       @"caption" : @{
                                               @"text":@"a caption"
                                               },
                                       @"comments" : @{@"data":@[
                                                               @{@"id":@45,
                                                                 @"text":@"Here is the actual comment",
                                                                 @"from":@{
                                                                         @"id":@10,
                                                                         @"username":@"user4",
                                                                         @"fullname":@"Person 4"
                                                                         }
                                                                 }
                                                               ]},
                                       @"likeState" : @"BOOL likeState = userHasLiked ? LikeStateLiked : LikeStateNotLiked",
                                       @"temporaray_comment": @"A temp comment here"};
    self.mediaItem1 = [[Media alloc] initWithDictionary:sourceDictionary];
    self.tc = [UITraitCollection traitCollectionWithDisplayScale:2.0];
    self.tc = [UITraitCollection traitCollectionWithVerticalSizeClass:UIUserInterfaceSizeClassRegular];
    self.tc = [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassRegular];
    self.tc = [UITraitCollection traitCollectionWithUserInterfaceIdiom:UIUserInterfaceIdiomPad];
    
    mtvc = [[MediaTableViewCell alloc] init];
    [mtvc setMediaItem:self.mediaItem1];
    
    // download image here
   
    NSString *urlString = @"https://scontent-lax3-1.cdninstagram.com/t51.2885-15/s640x640/sh0.08/e35/12445948_1723725777916979_1650061249_n.jpg?ig_cache_key=MTI4MTM4MTQ2MTAzMDYxOTM2MA%3D%3D.2";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}



// test to ensure that [MediaTableViewCell+heightForMediaItem:width:] returns accurate heights

-(void) testImage1Height {
    CGFloat image1Height = [MediaTableViewCell heightForMediaItem:self.mediaItem1 width:768 traitCollection:self.tc];
    XCTAssertEqual(image1Height, 768.0);
}

@end
