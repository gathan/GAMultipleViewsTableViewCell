//
//  GAMultipleViewsTableViewCell.h
//  GAMultipleViewsTableViewCell
//
//  Created by gathanasopoulos on 7/14/14.
//  Copyright (c) 2014 g.athanasopoulos.it@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GAMultipleViewsTableViewCell;

@protocol GAMultipleViewsTableViewCellProtocol <NSObject>

- (void)multipleViewsTableViewCell:(GAMultipleViewsTableViewCell*)cell didScrollToViewAtIndex:(NSInteger)index;

@end

@interface GAMultipleViewsTableViewCell : UITableViewCell < UIScrollViewDelegate>{

    __weak IBOutlet UIScrollView *multipleViewsScrollView;
    
}

@property (nonatomic, weak) id<GAMultipleViewsTableViewCellProtocol> delegate;

- (void)reloadWithViews:(NSArray*)viewsArray andCircularPaging:(BOOL)circularPaging andShowViewAtIndex:(NSInteger)showViewAtIndex animated:(BOOL)animated;
- (void)showViewAtIndex:(NSInteger)showViewAtIndex animated:(BOOL)animated;

@end
