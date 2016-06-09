//
//  LoginViewController.h
//  Blocstagram
//
//  Created by MELANIE MCGANNEY on 6/9/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

//any object that needs to be notified when an access token is obtained will use this string
extern NSString *const LoginViewControllerDidGetAccessTokenNotification;

@end
