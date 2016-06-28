//
//  MainTableTableViewController.h
//  GnomesBook
//
//  Created by Mario Martinez on 26/6/16.
//  Copyright © 2016 Brastlewark Town. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTableTableViewController : UITableViewController <UISearchBarDelegate, UISearchControllerDelegate>

@property(nonatomic, strong)    NSMutableDictionary   *alphabeticalNames;

@end
