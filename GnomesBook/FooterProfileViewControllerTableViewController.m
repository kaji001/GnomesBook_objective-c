//
//  FooterProfileViewControllerTableViewController.m
//  GnomesBook
//
//  Created by Mario Martinez on 26/6/16.
//  Copyright © 2016 Brastlewark Town. All rights reserved.
//

#import "FooterProfileViewControllerTableViewController.h"

#import "MainTableTableViewController.h"
#import "ProfessionsTableViewController.h"
#import "AppManager.h"

@interface FooterProfileViewControllerTableViewController ()

@end

@implementation FooterProfileViewControllerTableViewController

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual: @"FriendsSegue"]) {
        // reutilizamos la vista MaintTableViewController con el listado de amigos
        MainTableTableViewController *friendsTableViewController = segue.destinationViewController;
        
        friendsTableViewController.alphabeticalNames = [NSMutableDictionary dictionaryWithDictionary:[[AppManager sharedInstance] loadFriends:self.friends]];
    } else if ([segue.identifier isEqual: @"ProfessionsTableViewControllerSegue"]) {
        ProfessionsTableViewController *professionsTableViewController = segue.destinationViewController;
        
        professionsTableViewController.professions = self.professions;
    }
}


@end
