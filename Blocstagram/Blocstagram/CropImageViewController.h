//
//  CropImageViewController.h
//  Blocstagram
//
//  Created by MELANIE MCGANNEY on 6/24/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "MediaFullScreenViewController.h"

@class CropImageViewController;

@protocol CropImageViewControllerDelegate <NSObject>

//user will size and crop image and controller will pass cropped UIImage back to its delegate
-(void) cropControllerFinishedWithImage:(UIImage *)croppedImage;

@end

@interface CropImageViewController : MediaFullScreenViewController

//another controller will pass this VC a UI image and set itself as the crop controller's delegate
-(instancetype) initWithImage:(UIImage *)sourceImage;

@property(nonatomic, weak) NSObject <CropImageViewControllerDelegate> *delegate;

@end
