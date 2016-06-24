//
//  ImageLibraryViewController.h
//  Blocstagram
//
//  Created by MELANIE MCGANNEY on 6/24/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  ImageLibraryViewController;

@protocol ImageLibraryViewControllerDelegate <NSObject>

- (void) imageLibraryViewController:(ImageLibraryViewController *)imageLibraryViewController didCompleteWithImage:(UIImage *)image;

@end

@interface ImageLibraryViewController : UICollectionViewController

@property(nonatomic, weak) NSObject <ImageLibraryViewControllerDelegate> *delegate;

@end
