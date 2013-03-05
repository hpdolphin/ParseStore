//
//  PFConstants.h
//  Store
//
//  Created by Andrew Wang on 2/26/13.
//  Copyright (c) 2013 Parse Inc. All rights reserved.
//

typedef enum {
    PFProductNameShirt,
    PFProductNameHoodie,
    PFProductNameMug
} PFProductName;

@interface PFProducts : NSObject
+ (NSArray *)productInfo;
+ (NSArray *)sizes;
@end