//
//  ImagesTableViewController.m
//  Blocstagram
//
//  Created by MELANIE MCGANNEY on 6/2/16.
//  Copyright © 2016 Bloc. All rights reserved.
//


#import "ImagesTableViewController.h"

@interface ImagesTableViewController ()
//store references to our placeholder images
@property (nonatomic, strong) NSMutableArray *images;
@end

@implementation ImagesTableViewController

//Override the table view controller's initializer to create an empty array
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.images = [NSMutableArray array];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //populate viewDidLoad with some images
    
    for (int i = 1; i <= 10; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%d.jpg", i];
        UIImage *image = [UIImage imageNamed:imageName];
        if (image) {
            [self.images addObject:image];
        }
    }
    
    // return table view managed by the controller, tell the table how to create new cells
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"imageCell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //we want to present all 10 of our images as rows in this table
    return self.images.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // #1
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imageCell" forIndexPath:indexPath];
    
    // Configure the cell...
    // #2
    
    //set the tag to an arbitrary number - must remain consistent. can be attached to any UIView and used later to recover it from its superview by invoking viewWithTag
    
    static NSInteger imageViewTag = 1234;
    UIImageView *imageView = (UIImageView*)[cell.contentView viewWithTag:imageViewTag];
    
    // #3
    //handles the case when viewWithTag fails to recover a UIimageView -- so create a brand new cell
    if (!imageView) {
        // This is a new cell, it doesn't have an image view yet
        imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleToFill;
        
        //content view returns the content view of a cell object
        imageView.frame = cell.contentView.bounds;
        imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        imageView.tag = imageViewTag;
        [cell.contentView addSubview:imageView];
    }
    
    UIImage *image = self.images[indexPath.row];
    imageView.image = image;
    
    return cell;
}

//Override the default height, which is 44 points
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //return 300;
    //to get the right aspect ratio divide the frame by image size and multiply by height
    UIImage *image = self.images[indexPath.row];
    return (CGRectGetWidth(self.view.frame)/image.size.width) * image.size.height;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


//make each row editable
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

// Override to support editing the table view.

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSLog(@"Delete a row");
        
        //[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
