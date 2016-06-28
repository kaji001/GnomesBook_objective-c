//
//  AppManager.h
//  GnomesBook
//
//  Created by Mario Martinez on 25/6/16.
//  Copyright © 2016 Brastlewark Town. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppManager : NSObject

@property(nonatomic, strong)    NSMutableDictionary    *alphabeticalDictionaryGnome;

// Singleton AppManager
+ (AppManager *)sharedInstance;

// Inicar aplicación
- (void) startWithInitialViewController: (UIViewController *) initialViewController;

// Carga amigos a partir de un array de strings
- (NSDictionary*) loadFriends:(NSArray*) friends;

@end
