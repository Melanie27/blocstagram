//
//  InstagramCollectionViewCell.m
//  Blocstagram
//
//  Created by MELANIE MCGANNEY on 6/30/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "InstagramCollectionViewCell.h"
#import "PostToInstagramViewController.h"

@interface InstagramCollectionViewCell() 
    @property (nonatomic, strong) UIImage *sourceImage;
    //hold filtered images and their titles
    @property (nonatomic, strong) NSMutableArray *filterImages;
    @property (nonatomic, strong) NSMutableArray *filterTitles;
    //Views for each cell
    @property (nonatomic, strong)UIImageView *filterImagesView;
    @property (nonatomic, strong) UILabel *filterTitlesLabel;

    //stores the photo filter operations
    @property (nonatomic, strong) NSOperationQueue *photoFilterOperationQueue;
@end



@implementation InstagramCollectionViewCell

-(id) initWithStyle:(UICollectionViewCell*)style reuseIdentifier:(NSString *) reuseIdentifier{
    //self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    
    if (self) {
        
        //Init the 2 views
        self.filterImagesView = [[UIImageView alloc] init];
        self.filterTitlesLabel = [[UILabel alloc] init];
        self.photoFilterOperationQueue = [[NSOperationQueue alloc] init];
        
        
        for (UIView *view in @[self.filterImagesView, self.filterTitlesLabel]) {
            [self.contentView addSubview:view];
        }
        
        
        [self addFiltersToQueue];
        
    }
    
    return self;

}

- (NSAttributedString *) filterTitlesLabelString {
    // - Make a string that says "username caption"
    NSString *baseString = [NSString stringWithFormat:@"%@", self.filterTitlesLabel];
    
    // - Make an attributed string, with the "username" bold
    NSMutableAttributedString *mutablefilterTitlesLabelString = [[NSMutableAttributedString alloc] initWithString:baseString];
    
    return mutablefilterTitlesLabelString;
  
}

- (CGSize) sizeOfString:(NSAttributedString *)string {
    CGSize maxSize = CGSizeMake(CGRectGetWidth(self.contentView.bounds)/3 - 40, 0.0);
    CGRect sizeRect = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    sizeRect.size.height += 20;
    sizeRect = CGRectIntegral(sizeRect);
    return sizeRect.size;
}

-(void) viewDidLoad {
    
}

-(void) layoutSubviews {
    
    [super layoutSubviews];
    
    /*CGFloat imageHeight = self.mediaItem.image.size.height / self.mediaItem.image.size.width * CGRectGetWidth(self.contentView.bounds);
    self.mediaImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.bounds), imageHeight);*/
    
    CGSize sizeOfFilterTitlesLabel = [self sizeOfString:self.filterTitlesLabel.attributedText];
     self.filterTitlesLabel.frame = CGRectMake(0, CGRectGetMaxY(self.contentView.bounds), CGRectGetWidth(self.contentView.bounds), sizeOfFilterTitlesLabel.height);
    
    
    
}



#pragma mark - Photo Filters
//method to handle finished filters and add them to collection view
- (void) addCIImageToCollectionView:(CIImage *)CIImage withFilterTitle:(NSString *)filterTitle {
    
    //convert CIImage to UIImage
    UIImage *image = [UIImage imageWithCIImage:CIImage scale:self.sourceImage.scale orientation:self.sourceImage.imageOrientation];
    
    
    if (image) {
        // Decompress image
        UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
        [image drawAtPoint:CGPointZero];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSUInteger newIndex = self.filterImages.count;
            
            [self.filterImages addObject:image];
            [self.filterTitles addObject:filterTitle];
            
            //[self.filterCollectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:newIndex inSection:0]]];
        });
    }
}



//add a filter to the operation queue
- (void) addFiltersToQueue {
    CIImage *sourceCIImage = [CIImage imageWithCGImage:self.sourceImage.CGImage];
    
    // Noir filter
    
    [self.photoFilterOperationQueue addOperationWithBlock:^{
        CIFilter *noirFilter = [CIFilter filterWithName:@"CIPhotoEffectNoir"];
        
        if (noirFilter) {
            [noirFilter setValue:sourceCIImage forKey:kCIInputImageKey];
            [self addCIImageToCollectionView:noirFilter.outputImage withFilterTitle:NSLocalizedString(@"Noir", @"Noir Filter")];
        }
    }];
}

@end
