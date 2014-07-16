//
//  GAMultipleViewsTableViewCell.m
//  GAMultipleViewsTableViewCell
//
//  Created by gathanasopoulos on 7/14/14.
//  Copyright (c) 2014 g.athanasopoulos.it@gmail.com. All rights reserved.
//

#import "GAMultipleViewsTableViewCell.h"

@interface GAMultipleViewsTableViewCell (){

    BOOL circularPaging;
    NSArray *showingViewsArray;
    UIView *firstView;
    UIView *lastView;
    UIPageControl *pageControl;
    BOOL pageControlBeingUsed;
}

@end

@implementation GAMultipleViewsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)prepareForReuse{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Actions

- (void)reloadWithViews:(NSArray*)viewsArray andCircularPaging:(BOOL)circularPagingEnabled andShowViewAtIndex:(NSInteger)showViewAtIndex animated:(BOOL)animated{
    for (UIView *view in viewsArray) {
        [view removeFromSuperview];
    }
    multipleViewsScrollView.delegate = self;
    multipleViewsScrollView.pagingEnabled = YES;
    
    circularPaging = circularPagingEnabled;
    if (viewsArray.count != 0) {
        firstView = [viewsArray objectAtIndex:0];
        lastView = [viewsArray lastObject];
    }
    
    pageControl = [[UIPageControl alloc]init];
    [pageControl addTarget:self action:@selector(changePage) forControlEvents:UIControlEventValueChanged];
    multipleViewsScrollView.delegate = self;
    NSMutableArray *showingViewsMutableArray = [[NSMutableArray alloc]init];
    if (circularPaging) {
        [showingViewsMutableArray addObject:lastView];
        [showingViewsMutableArray addObjectsFromArray:viewsArray];
        [showingViewsMutableArray addObject:firstView];
    }else{
        [showingViewsMutableArray addObjectsFromArray:viewsArray];
    }
    
    for (UIView *scrollViewSubview in multipleViewsScrollView.subviews) {
        [scrollViewSubview removeFromSuperview];
    }
    [multipleViewsScrollView setContentSize:CGSizeZero];
    
    CGFloat currentX = 0;
    CGFloat maxY = 0;
    
    for (NSInteger x = 0 ; x < showingViewsMutableArray.count ; x++)
    {
        UIView *subview = [showingViewsMutableArray objectAtIndex:x];
        subview.frame = CGRectMake(currentX, 0, subview.bounds.size.width, subview.bounds.size.height);
        [multipleViewsScrollView addSubview:subview];
        if (maxY < subview.bounds.size.height) {
            maxY = subview.bounds.size.height;
        }
        currentX = currentX + subview.bounds.size.width;
        subview.hidden = NO;
    }
    showingViewsArray = [NSArray arrayWithArray:showingViewsMutableArray];
    CGSize contentSize = CGSizeMake(currentX, maxY);
    [multipleViewsScrollView setContentSize:contentSize];
    self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    multipleViewsScrollView.backgroundColor = [[UIColor cyanColor] colorWithAlphaComponent:0.3];
    
    [self showViewAtIndex:showViewAtIndex animated:animated];
}

- (void)showViewAtIndex:(NSInteger)showViewAtIndex animated:(BOOL)animated{
    NSInteger whichOneToShow = [self realIndexForItemAtIndex:showViewAtIndex];
    CGRect frameToScrollAt;
    for (NSInteger x = 0 ; x < showingViewsArray.count ; x++)
    {
        UIView *subview = [showingViewsArray objectAtIndex:x];
        if (x == whichOneToShow) {
            frameToScrollAt = subview.frame;
        }
    }
    [multipleViewsScrollView scrollRectToVisible:frameToScrollAt animated:animated];
}

- (NSInteger)realIndexForItemAtIndex:(NSInteger)index{
    NSInteger realIndex = index;
    if (circularPaging) {
        realIndex = realIndex + 1;
    }
    return realIndex;
}

- (UIView*)viewAtIndex:(NSInteger)index{
    if (showingViewsArray.count == 0) {
        return nil;
    }
    NSInteger realIndex = [self realIndexForItemAtIndex:index];
    return [showingViewsArray objectAtIndex:realIndex];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = multipleViewsScrollView.frame.size.width;
    int page = floor((multipleViewsScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

- (IBAction)changePage {
    // update the scroll view to the appropriate page
    CGRect frame;
    frame.origin.x = multipleViewsScrollView.frame.size.width * pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = multipleViewsScrollView.frame.size;
    [multipleViewsScrollView scrollRectToVisible:frame animated:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(multipleViewsTableViewCell:didScrollToViewAtIndex:)]) {
        [self.delegate multipleViewsTableViewCell:self didScrollToViewAtIndex:pageControl.currentPage];
    }
}

- (UIImageView*)grabImageViewFromView:(UIView*)viewToGrab {
    // Create a "canvas" (image context) to draw in.
    UIGraphicsBeginImageContext([viewToGrab bounds].size);
    
    // Make the CALayer to draw in our "canvas".
    [[viewToGrab layer] renderInContext: UIGraphicsGetCurrentContext()];
    
    // Fetch an UIImage of our "canvas".
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // Stop the "canvas" from accepting any input.
    UIGraphicsEndImageContext();
    
    // Return the image.
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:viewToGrab.bounds];
    imageView.image = image;
    return imageView;
}

@end