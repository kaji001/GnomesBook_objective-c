//
//  ServiceManager.h
//  GnomesBook
//
//  Created by Mario Martinez on 25/6/16.
//  Copyright © 2016 Brastlewark Town. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceManager : NSObject

- (void) getGenomesDataWithCompletion:(void (^) (NSArray *gnomes, NSString *error)) completion;

@end
