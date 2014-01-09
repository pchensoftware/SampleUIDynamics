//
//  StartTableController.m
//  SampleUIDynamics
//
//  Created by Peter Chen on 11/22/13.
//  Copyright (c) 2013 Peter Chen. All rights reserved.
//

#import "StartTableController.h"
#import "BoxesController.h"
#import "CollectionController.h"

typedef NS_ENUM(int, TableRow) {
    TableRowBoxes,
    TableRowCollectionView,
    TableRowCount,
};

@interface StartTableController ()

@end

@implementation StartTableController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Start";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return TableRowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (TableRowBoxes == indexPath.row)
        cell.textLabel.text = @"Boxes";
    
    else if (TableRowCollectionView == indexPath.row)
        cell.textLabel.text = @"Collection view";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (TableRowBoxes == indexPath.row) {
        BoxesController *controller = [[BoxesController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if (TableRowCollectionView == indexPath.row) {
        CollectionController *controller = [[CollectionController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

@end
