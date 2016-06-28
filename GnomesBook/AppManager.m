//
//  AppManager.m
//  GnomesBook
//
//  Created by Mario Martinez on 25/6/16.
//  Copyright © 2016 Brastlewark Town. All rights reserved.
//

#import "AppManager.h"

#import "ServiceManager.h"
#import "LoadingViewController.h"
#import "Gnome.h"

@interface AppManager ()

@property(nonatomic)            Class                   initialViewControllerClass;
@property(nonatomic, strong)    ServiceManager          *serviceManager;
@property(nonatomic, strong)    NSMutableDictionary     *dictionaryGnome;

@end

@implementation AppManager

+ (AppManager *)sharedInstance {
    static AppManager *sharedInstance = nil;
    static dispatch_once_t onceToken; // onceToken = 0
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AppManager alloc] init];
    });
    
    return sharedInstance;
}

- (AppManager*) init {
    if (self = [super init]) {
        self.initialViewControllerClass = [LoadingViewController class];
        self.serviceManager = [[ServiceManager alloc] init];
        self.dictionaryGnome = [NSMutableDictionary dictionary];
        self.alphabeticalDictionaryGnome = [NSMutableDictionary dictionary];
    }
    
    return self;
}

// Inicar aplicación
- (void) startWithInitialViewController: (UIViewController *) initialViewController {
    if (![initialViewController isKindOfClass:self.initialViewControllerClass]) {
        @throw [NSException exceptionWithName:@"AppManager.start.ErrorStoryBoard"
                                       reason:@"This viewController isn't initial viewController"
                                     userInfo:nil];
    }
    
    [self loadDataWithViewController:(LoadingViewController*)initialViewController];
}

// carga inicial de datos
- (void) loadDataWithViewController:(LoadingViewController*) viewController {
    [self.serviceManager getGenomesDataWithCompletion:^(NSArray *gnomes, NSString *error) {
        if (error != nil) {
            // Aviso de falta de conexión
            [viewController stopLoading];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alerta" message:error preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *reconectarAction = [UIAlertAction
                                               actionWithTitle:@"Reconectar"
                                               style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action)
                                               {
                                                   // Reconectar
                                                   [viewController startLoading];
                                                   [self loadDataWithViewController:viewController];
                                               }];
            
            [alertController addAction:reconectarAction];
            [viewController presentViewController:alertController animated:true completion:nil];
            
            return;
        }
        
        // ordenar Gnomes
        NSArray *arrayGnomeSort = [self arrayGnomeSortedWithArray:gnomes];
        
        self.dictionaryGnome = [NSMutableDictionary dictionary];
        
        for (Gnome *gnome in arrayGnomeSort) {
            // dictionaryGnome
            [self.dictionaryGnome setObject:gnome forKey:gnome.fullName];
            
            // alphabeticalDictionaryGnome
            NSString *firstLetter = [gnome.name substringToIndex:1];
            
            if ([self.alphabeticalDictionaryGnome objectForKey:firstLetter] == nil) {
                [self.alphabeticalDictionaryGnome setObject:[NSMutableArray array] forKey:firstLetter];
            }
            
            [[self.alphabeticalDictionaryGnome objectForKey:firstLetter] addObject:gnome];
        }
        
        [viewController stopLoading];
        
        [viewController nexViewController];
    }];
}

// Carga amigos a partir de un array de strings
- (NSDictionary*) loadFriends:(NSArray*) friends {
    NSMutableArray *gnomeFriends = [NSMutableArray array];
    
    for (NSString *friend in friends) {
        [gnomeFriends addObject:[self.dictionaryGnome objectForKey:friend]];
    }
    
    return [self alphabeticalDictionaryGnomeWithArray:gnomeFriends];
}

// Creación de un dicionario indexado por letra inicial
- (NSDictionary*) alphabeticalDictionaryGnomeWithArray:(NSArray*) arrayGnome {
    NSMutableDictionary *temporalAlphabeticalDictionaryGnome = [NSMutableDictionary dictionary];
    
    // ordenar Gnomes
    NSArray *arrayGnomeSort = [self arrayGnomeSortedWithArray:arrayGnome];
    
    for (Gnome *gnome in arrayGnomeSort) {
        NSString *firstLetter = [gnome.name substringToIndex:1];
        
        if ([temporalAlphabeticalDictionaryGnome objectForKey:firstLetter] == nil) {
            [temporalAlphabeticalDictionaryGnome setObject:[NSMutableArray array] forKey:firstLetter];
        }
        
        [[temporalAlphabeticalDictionaryGnome objectForKey:firstLetter] addObject:gnome];
    }
    
    return temporalAlphabeticalDictionaryGnome;
}

// ordenar Gnomes
- (NSArray *) arrayGnomeSortedWithArray:(NSArray *)arrayGnomes {
    return  [arrayGnomes sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        Gnome *gnome1 = (Gnome *)obj1;
        Gnome *gnome2 = (Gnome *)obj2;
        
        return (gnome1.fullName < gnome2.fullName);
    }];
}

@end
