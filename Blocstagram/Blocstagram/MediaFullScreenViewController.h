//
//  MediaFullScreenViewController.h
//  Blocstagram
//
//  Created by MELANIE MCGANNEY on 6/15/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Media, MediaTableViewCell;

@protocol MediaFullScreenViewControllerDelegate <NSObject>

//add delegate method for sharing on full screen
-(void) cell:(MediaTableViewCell *) cell socialSharing:(UIButton *)shareButton;

@end

@interface MediaFullScreenViewController : UIViewController
@property(nonatomic, weak) id <MediaFullScreenViewControllerDelegate> delegate;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *shareButton;

-(IBAction)socialSharing:(id)sender;

//custom initializer you pass media object to display
 - (instancetype) initWithMedia:(Media *)media;

- (void) centerScrollView;

@end
