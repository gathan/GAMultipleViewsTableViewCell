//
//  SubclassOfGAMultipleViewsTableViewCell.h
//  GAMultipleViewsTableViewCell
//
//  Created by gathanasopoulos on 7/14/14.
//  Copyright (c) 2014 g.athanasopoulos.it@gmail.com. All rights reserved.
//

#import "GAMultipleViewsTableViewCell.h"

@interface SubclassOfGAMultipleViewsTableViewCell : GAMultipleViewsTableViewCell

@property (strong, nonatomic) IBOutlet UIView *firstView;
@property (strong, nonatomic) IBOutlet UIView *secondView;
@property (strong, nonatomic) IBOutlet UIView *thirdView;

@property (nonatomic, strong) NSString *nameString;

@end
