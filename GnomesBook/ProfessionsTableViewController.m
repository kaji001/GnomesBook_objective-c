//
//  ProfessionsTableViewController.m
//  GnomesBook
//
//  Created by Mario Martinez on 26/6/16.
//  Copyright © 2016 Brastlewark Town. All rights reserved.
//

#import "ProfessionsTableViewController.h"

@interface ProfessionsTableViewController ()

@end

@implementation ProfessionsTableViewController

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.professions.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfessionTableViewCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.professions[indexPath.row];
    
    return cell;
}

@end
