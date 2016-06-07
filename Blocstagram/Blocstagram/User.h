//
//  User.h
//  Blocstagram
//
//  Created by MELANIE MCGANNEY on 6/6/16.
//  Copyright © 2016 Bloc. All rights reserved.
//


//for your class to recognize UIImage you must import UIKit
#import <UIKit/UIKit.h>

//a collection of properties is enough to create a basic model
@interface User : NSObject

@property(nonatomic, strong) NSString *idNumber;
@property(nonatomic, strong) NSString *userName;
@property(nonatomic, strong) NSString *fullName;
@property(nonatomic, strong) NSURL *profilePictureURL;
@property(nonatomic, strong) UIImage *profilePicture;

@end
