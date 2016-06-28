//
//  Gnome.m
//  GnomesBook
//
//  Created by Mario Martinez on 25/6/16.
//  Copyright © 2016 Brastlewark Town. All rights reserved.
//

#import "Gnome.h"

#define Id @"id"
#define Name @"name"
#define Thumbnail @"thumbnail"
#define Age @"age"
#define Weight @"weight"
#define Height @"height"
#define HairColor @"hair_color"
#define Professions @"professions"
#define Friends @"friends"

@implementation Gnome

+ (NSArray *) arrayGnomesWithArray: (NSArray *)array {
    NSMutableArray *arrayGnomes = [NSMutableArray array];
    Gnome *gnome;
    
    for (NSDictionary *g in array) {
        gnome = [[Gnome alloc]initWithDictionary:g];
        [arrayGnomes addObject:gnome];
    }
    
    return arrayGnomes;
}

- (instancetype) init {
    if (self = [super init]) {
        self.id = 0;
        self.name = @"";
        self.surname = @"";
        self.fullName = @"";
        self.thumbnail = @"";
        self.age = 0;
        self.weight = 0.0;
        self.height = 0.0;
        self.hairColor = @"";
        self.professions = [NSArray array];
        self.friends = [NSArray array];
    }
    
    return self;
}

- (instancetype) initWithDictionary: (NSDictionary *)dic {
    NSArray *keys = [dic allKeys];
    if (self = [super init]) {
        if ([keys containsObject:Id]) {
            self.id = [[dic objectForKey:Id] intValue];
        }
        
        if ([keys containsObject:Name]) {
            self.fullName = [dic objectForKey:Name];
            NSArray *fullNameArray = [self.fullName componentsSeparatedByString:@" "];
            self.name = fullNameArray[1];
            self.surname = fullNameArray[0];
        }
        
        if ([keys containsObject:Thumbnail]) {
            self.thumbnail = [dic objectForKey:Thumbnail];
        }
        
        if ([keys containsObject:Age]) {
            self.age = [[dic objectForKey:Age]intValue];
        }
        
        if ([keys containsObject:Weight]) {
            self.weight = [[dic objectForKey:Weight]floatValue];
        }
        
        if ([keys containsObject:Height]) {
            self.height = [[dic objectForKey:Height]floatValue];
        }
        
        if ([keys containsObject:HairColor]) {
            self.hairColor = [dic objectForKey:HairColor];
        }
        
        if ([keys containsObject:Professions]) {
            self.professions = [dic objectForKey:Professions];
        }
        
        if ([keys containsObject:Friends]) {
            self.friends = [dic objectForKey:Friends];
        }
    }
    
    return self;
}

@end
