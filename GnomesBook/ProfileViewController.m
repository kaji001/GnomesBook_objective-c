//
//  ProfileViewController.m
//  GnomesBook
//
//  Created by Mario Martinez on 26/6/16.
//  Copyright © 2016 Brastlewark Town. All rights reserved.
//

#import "ProfileViewController.h"

#import "Haneke.h"
#import "FooterProfileViewControllerTableViewController.h"

@interface ProfileViewController ()

@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *surname;
@property (strong, nonatomic) IBOutlet UILabel *age;
@property (strong, nonatomic) IBOutlet UILabel *weight;
@property (strong, nonatomic) IBOutlet UILabel *height;
@property (strong, nonatomic) IBOutlet UILabel *hairColor;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ProfileViewController

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.gnome = [[Gnome alloc]init];
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    self.name.text = self.gnome.name;
    self.surname.text = self.gnome.surname;
    self.age.text = [NSString stringWithFormat:@"%i", self.gnome.age];
    self.weight.text = [NSString stringWithFormat:@"%f", self.gnome.weight];
    self.height.text = [NSString stringWithFormat:@"%f", self.gnome.height];
    self.hairColor.text = self.gnome.hairColor;
    
    self.imageView.layer.cornerRadius = 58.0;
    self.imageView.clipsToBounds = true;
    
    NSURL *url = [[NSURL alloc]initWithString:self.gnome.thumbnail];
    [self.imageView hnk_setImageFromURL:url];
    
    [super viewWillAppear:animated];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier  isEqual: @"FooterProfileViewControllerTableViewControllerSegue"]) {
        // reutilizamos la vista MaintTableViewController con el listado de amigos
        FooterProfileViewControllerTableViewController *footerTableViewController = (FooterProfileViewControllerTableViewController *)segue.destinationViewController;
        
        footerTableViewController.friends = self.gnome.friends;
        footerTableViewController.professions = self.gnome.professions;
    }
}

@end
