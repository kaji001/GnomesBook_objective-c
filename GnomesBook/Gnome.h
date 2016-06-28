//
//  Gnome.h
//  GnomesBook
//
//  Created by Mario Martinez on 25/6/16.
//  Copyright © 2016 Brastlewark Town. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Gnome : NSObject

@property(nonatomic)            int         id;
@property(nonatomic, strong)    NSString    *name;
@property(nonatomic, strong)    NSString    *surname;
@property(nonatomic, strong)    NSString    *fullName;
@property(nonatomic, strong)    NSString    *thumbnail;
@property(nonatomic)            int         age;
@property(nonatomic)            float       weight;
@property(nonatomic)            float       height;
@property(nonatomic, strong)    NSString    *hairColor;
@property(nonatomic, strong)    NSArray     *professions;
@property(nonatomic, strong)    NSArray     *friends;

+ (NSArray *) arrayGnomesWithArray: (NSArray *)array;

@end
