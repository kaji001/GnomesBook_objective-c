//
//  MainTableViewCell.m
//  GnomesBook
//
//  Created by Mario Martinez on 26/6/16.
//  Copyright © 2016 Brastlewark Town. All rights reserved.
//

#import "MainTableViewCell.h"

@interface MainTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *name;

@end

@implementation MainTableViewCell

- (void) setNameTextWithString:(NSString *)name {
    self.name.text = name;
}

@end
