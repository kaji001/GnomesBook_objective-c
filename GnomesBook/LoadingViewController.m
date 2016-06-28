//
//  LoadingViewController.m
//  GnomesBook
//
//  Created by Mario Martinez on 25/6/16.
//  Copyright © 2016 Brastlewark Town. All rights reserved.
//

#import "LoadingViewController.h"
#import "DGActivityIndicatorView.h"

@interface LoadingViewController ()
@property (strong, nonatomic) IBOutlet DGActivityIndicatorView *activityIndicatorView;

@end

@implementation LoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DGActivityIndicatorView *activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeNineDots tintColor:[UIColor whiteColor]];
    
    activityIndicatorView.frame = CGRectMake(0, 0, self.activityIndicatorView.frame.size.width , self.activityIndicatorView.frame.size.height);
    
    [self.activityIndicatorView addSubview:activityIndicatorView];
    self.activityIndicatorView = activityIndicatorView;
    [activityIndicatorView startAnimating];
}

- (void) startLoading {
    [self.activityIndicatorView startAnimating];
}

- (void) stopLoading {
    [self.activityIndicatorView stopAnimating];
}

- (void) nexViewController {
    [self performSegueWithIdentifier:@"LoadingViewControllerSegue" sender:nil];
}

@end
