//
//  SubclassOfGAMultipleViewsTableViewCell.m
//  GAMultipleViewsTableViewCell
//
//  Created by gathanasopoulos on 7/14/14.
//  Copyright (c) 2014 g.athanasopoulos.it@gmail.com. All rights reserved.
//

#import "SubclassOfGAMultipleViewsTableViewCell.h"

@interface SubclassOfGAMultipleViewsTableViewCell (){

    __weak IBOutlet UIImageView *exampleImageView;

    __weak IBOutlet UILabel *firstViewLabel;

    __weak IBOutlet UILabel *secondViewLabel;
    
    __weak IBOutlet UILabel *thirdViewLabel;
    
}

@end

@implementation SubclassOfGAMultipleViewsTableViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setNameString:(NSString *)nameString{
    firstViewLabel.text = [NSString stringWithFormat:@"1st %@", nameString];

    secondViewLabel.text = [NSString stringWithFormat:@"2nd %@", nameString];
    
    thirdViewLabel.text = [NSString stringWithFormat:@"3rd %@", nameString];
  
    
    NSArray *viewsToShow = [NSArray arrayWithObjects:self.firstView, self.secondView, self.thirdView, nil];
    /*
    UIView *firstView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 236, 96)];
    firstView.backgroundColor = [UIColor redColor];
    UIView *secondView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 236, 96)];
    secondView.backgroundColor = [UIColor greenColor];
    UIView *thirdView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 236, 96)];
    thirdView.backgroundColor = [UIColor blueColor];
    
    NSArray *viewsToShow = [NSArray arrayWithObjects:firstView, secondView, thirdView, nil];
*/
    [self reloadWithViews:viewsToShow andCircularPaging:YES andShowViewAtIndex:1 animated:NO];
}



@end
