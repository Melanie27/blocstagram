//
//  ComposeCommentView.m
//  Blocstagram
//
//  Created by MELANIE MCGANNEY on 6/20/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "ComposeCommentView.h"

@interface ComposeCommentView () <UITextViewDelegate>

@property( nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *button;

@end

@implementation ComposeCommentView

-(id) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if(self) {
        //init code
        self.textView = [UITextView new];
        self.textView.delegate = self;
        
        //this is a subview of self.textView
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.button setAttributedTitle:[self commentAttributedString] forState:UIControlStateNormal];
        [self.button addTarget:self action:@selector(commentButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.textView];
        [self.textView addSubview:self.button];
    }
    
    return self;
}


-(NSAttributedString *) commentAttributedString {
    NSString *baseString = NSLocalizedString(@"COMMENT", @"comment button text");
    NSRange range = [baseString rangeOfString:baseString];
    
    NSMutableAttributedString *commentString = [[NSMutableAttributedString alloc] initWithString:baseString];
    
    [commentString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10] range:range];
    //increase character spacing
    [commentString addAttribute:NSKernAttributeName value:@1.3 range:range];
    [commentString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1] range:range];
    
    return commentString;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
