//
//  MainTableTableViewController.m
//  GnomesBook
//
//  Created by Mario Martinez on 26/6/16.
//  Copyright © 2016 Brastlewark Town. All rights reserved.
//

#import "MainTableTableViewController.h"

#import "AppManager.h"
#import "MainTableViewCell.h"
#import "Gnome.h"
#import "ProfileViewController.h"

#define alphabet @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"]

@interface MainTableTableViewController ()

@property(nonatomic, strong)    NSMutableArray               *sections;
@property(nonatomic, strong)    NSMutableArray        *sectionsFiltered;
@property(nonatomic, strong)    NSMutableDictionary   *alphabeticalNamesFiltered;

@property(nonatomic)            bool                  searchActive;

@end

@implementation MainTableTableViewController

- (instancetype) initWithCoder:(NSCoder*)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.sections = [NSMutableArray arrayWithArray: alphabet];
        self.sectionsFiltered = [NSMutableArray arrayWithArray: alphabet];
        self.alphabeticalNames = [[AppManager sharedInstance] alphabeticalDictionaryGnome];
        self.alphabeticalNamesFiltered = [NSMutableDictionary dictionaryWithDictionary:self.alphabeticalNames];
        
        self.searchActive = false;
    }
    
    return self;
}

- (void) viewWillAppear:(BOOL)animated {
    self.searchActive = false;
    [self reloadSections];
}

- (void) reloadSections {
    self.sections = [NSMutableArray arrayWithArray: alphabet];
    self.sectionsFiltered = [NSMutableArray arrayWithArray: alphabet];
    
    for (NSString *section in alphabet) {
        if (self.alphabeticalNamesFiltered[section] == nil) {
            [self.sectionsFiltered removeObjectAtIndex:[self.sectionsFiltered indexOfObject:section]];
        }
        
        if (self.alphabeticalNames[section] == nil) {
            [self.sections removeObjectAtIndex:[self.sections indexOfObject:section]];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.searchDisplayController.searchResultsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MainTableViewCell"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.searchActive ? self.sectionsFiltered.count : self.sections.count;
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.searchActive ? self.sectionsFiltered[section] : self.sections[section];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arraySection = self.searchActive ? self.alphabeticalNamesFiltered[self.sectionsFiltered[section]] : self.alphabeticalNames[self.sections[section]];
    
    return arraySection.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 35;
    }
    
    return 0;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainTableViewCell *cell = (MainTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:@"MainTableViewCell" forIndexPath:indexPath];
    
    Gnome *gnomeItem = [self getGnomeTableViewWithIndexPath:indexPath];
    NSString *fulltName = [NSString stringWithFormat:@"%@, %@", gnomeItem.name, gnomeItem.surname];
    [cell setNameTextWithString:fulltName];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Gnome *gnome  = [self getGnomeTableViewWithIndexPath:indexPath];
    
    [self performSegueWithIdentifier:@"ProfileViewControllerSegue" sender: gnome];
}

- (Gnome*) getGnomeTableViewWithIndexPath:(NSIndexPath *)indexPath {
    NSArray *arrayNamesSection;
    
    if (self.searchActive) {
        arrayNamesSection = self.alphabeticalNamesFiltered[self.sectionsFiltered[indexPath.section]];
    } else {
        arrayNamesSection = self.alphabeticalNames[self.sections[indexPath.section]];
    }
    
    return arrayNamesSection[indexPath.row];
}

#pragma mark - UISearchBarDelegate Delegate

- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.searchActive = true;
    self.alphabeticalNamesFiltered = [NSMutableDictionary dictionaryWithDictionary:self.alphabeticalNames];
    self.sectionsFiltered = [NSMutableArray arrayWithArray:self.sections];
}

- (void) searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    self.searchActive = false;
}

- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.searchActive = false;
    [self.tableView reloadData];
}

#pragma mark - UISearchDisplayController Delegate

- (BOOL) searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    self.alphabeticalNamesFiltered = [NSMutableDictionary dictionaryWithDictionary:self.alphabeticalNames];
    self.sectionsFiltered = [NSMutableArray arrayWithArray:self.sections];
   
    if (![[searchString stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]) {
        for (NSString *key in [self.alphabeticalNamesFiltered allKeys]) {
            NSArray *arrayGnomes = [self.alphabeticalNamesFiltered objectForKey:key];
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.fullName CONTAINS[cd] %@", searchString];
            NSArray *array = [arrayGnomes filteredArrayUsingPredicate:predicate];
            
            if (array.count == 0) {
                [self.alphabeticalNamesFiltered removeObjectForKey:key];
            } else {
                [self.alphabeticalNamesFiltered setObject:array forKey:key];
            }
        }
    }
    
    [self reloadSections];
    [self.tableView reloadData];
    
    return true;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual: @"ProfileViewControllerSegue"]) {
        ProfileViewController *nextViewController = (ProfileViewController *)segue.destinationViewController;
        if (nextViewController) {
            nextViewController.gnome = sender;
        }
    }
}


@end
