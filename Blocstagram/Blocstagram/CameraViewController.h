//
//  CameraViewController.h
//  Blocstagram
//
//  Created by MELANIE MCGANNEY on 6/20/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>
//users will use this view to take pictures
@class CameraViewController;

//a delegate property and accompanying protocol will inform the presenting view controller when the camera VC is done
@protocol CameraViewControllerDelegate <NSObject>

-(void) cameraViewController:(CameraViewController *)cameraViewController didCompleteWithImage:(UIImage *)image;

@end

@interface CameraViewController : UIViewController

@property (nonatomic, weak) NSObject <CameraViewControllerDelegate> *delegate;

@end
