//
//  NSObject+HTPropertyHash.h
//  HotelTonight
//
//  Created by Jacob Jennings on 11/28/12.
//  Copyright (c) 2012 Hotel Tonight. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HTCustomHash <NSObject>

@optional
// Called on receiver of hashStringForKeyPaths:, overrides hashDescription
- (NSString *)hashDescriptionForKeyPath:(NSString *)keyPath;

// Called on object being described
- (NSString *)hashDescription;

@end

@interface NSObject (HTPropertyHash)

- (NSString *)hashStringForKeyPaths:(NSArray *)propertyNames;

@end
