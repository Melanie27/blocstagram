//
//  CameraToolbar.h
//  Blocstagram
//
//  Created by MELANIE MCGANNEY on 6/20/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CameraToolbar;

@protocol CameraToolbarDelegate <NSObject>

//toolbar will have 3 buttons declare the methods

-(void) leftButtonPressedOnToolbar:(CameraToolbar *) toolbar;
- (void) rightButtonPressedOnToolbar:(CameraToolbar *)toolbar;
- (void) cameraButtonPressedOnToolbar:(CameraToolbar *)toolbar;

@end

@interface CameraToolbar : UIView

//image name for the side button icons passed here
-(instancetype) initWithImageNames:(NSArray *)imageNames;

@property (nonatomic, weak) NSObject <CameraToolbarDelegate> *delegate;

@end
