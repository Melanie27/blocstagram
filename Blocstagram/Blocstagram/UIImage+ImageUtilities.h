//
//  UIImage+ImageUtilities.h
//  Blocstagram
//
//  Created by MELANIE MCGANNEY on 6/23/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

 @interface UIImage (ImageUtilities)

//create 3 methods

//- (UIImage *) imageWithFixedOrientation;
//- (UIImage *) imageResizedToMatchAspectRatioOfSize:(CGSize)size;
//- (UIImage *) imageCroppedToRect:(CGRect)cropRect;

//HW method
- (UIImage *) imageByScalingToSize:(CGSize)size andCroppingWithRect:(CGRect)rect;

@end
