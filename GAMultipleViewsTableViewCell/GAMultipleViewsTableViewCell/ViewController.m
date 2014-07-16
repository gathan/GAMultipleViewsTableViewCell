//
//  ViewController.m
//  GAMultipleViewsTableViewCell
//
//  Created by gathanasopoulos on 7/14/14.
//  Copyright (c) 2014 g.athanasopoulos.it@gmail.com. All rights reserved.
//

#import "ViewController.h"
#import "SubclassOfGAMultipleViewsTableViewCell.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    UINib *nib = [UINib nibWithNibName:@"SubclassOfGAMultipleViewsTableViewCell" bundle:nil];    
//    [self.tableView registerNib:nib forCellReuseIdentifier:@"SubclassOfGAMultipleViewsTableViewCellIdentifier"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    
    return 10;
}

#pragma mark - UITableViewDelegate

- (SubclassOfGAMultipleViewsTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

//    SubclassOfGAMultipleViewsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SubclassOfGAMultipleViewsTableViewCellIdentifier"];
    NSArray *topLevelObjs = nil;
    SubclassOfGAMultipleViewsTableViewCell *cell;
    topLevelObjs = [[NSBundle mainBundle] loadNibNamed:@"SubclassOfGAMultipleViewsTableViewCell" owner:cell options:nil];
    
     cell = [topLevelObjs objectAtIndex:0];

    [cell setNameString:@"GA SubView"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

#pragma mark - GAMultipleViewsTableViewCellDelegate

- (void)multipleViewsTableViewCell:(GAMultipleViewsTableViewCell *)cell didScrollToViewAtIndex:(NSInteger)index{

}

@end
