//
//  ServiceManager.m
//  GnomesBook
//
//  Created by Mario Martinez on 25/6/16.
//  Copyright © 2016 Brastlewark Town. All rights reserved.
//

#import "ServiceManager.h"

#import "AFNetworking.h"
#import "Gnome.h"

#define ErrorMessage @"Error de conexión"
#define UrlService @"https://raw.githubusercontent.com/AXA-GROUP-SOLUTIONS/mobilefactory-test/master/data.json"
#define IndexJSON @"Brastlewark"
#define maxIntents 3

@interface ServiceManager ()

@property(nonatomic)            int                         intents;

@end


@implementation ServiceManager

- (ServiceManager*) init {
    if (self = [super init]) {
        self.intents = 0;
    }
    
    return self;
}

- (void) getGenomesDataWithCompletion:(void (^) (NSArray *gnomes, NSString *error)) completion {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURL *URL = [NSURL URLWithString:UrlService];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [manager setResponseSerializer:responseSerializer];
    
    [manager GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        //NSLog(@"%@ %@", response, responseObject);
        if ([[responseObject allKeys]containsObject:IndexJSON]) {
            completion([Gnome arrayGnomesWithArray:[responseObject objectForKey:IndexJSON]], nil);
        } else {
            completion(nil, ErrorMessage);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if (self.intents < maxIntents) {
            self.intents += 1;
            sleep(3);
            
            [self getGenomesDataWithCompletion:completion];
        } else {
            self.intents = 0;
            
            //NSLog(@"Error: %@", error);
            completion(nil, ErrorMessage);
        }
    }];
}

@end
