//
//  PFConstants.m
//  Store
//
//  Created by Andrew Wang on 2/26/13.
//  Copyright (c) 2013 Parse Inc. All rights reserved.
//

#import "PFProducts.h"

@implementation PFProducts

+ (NSArray *)productInfo {
    return @[@{ @"name": NSLocalizedString(@"Black T-shirt", @"Black T-shirt"),
                @"internalName": @"Tshirt",
                @"price": @25 },
             @{ @"name": NSLocalizedString(@"Black Hoodie", @"Black Hoodie"),
                @"internalName": @"Hoodie",
                @"price": @45 },
             @{ @"name": NSLocalizedString(@"Signature Mug", @"Signature Mug"),
                @"internalName": @"Mug",
                @"price": @12 }];
}

+ (NSArray *)sizes {
    return @[NSLocalizedString(@"Small", @"Small"),
             NSLocalizedString(@"Medium", @"Medium"),
             NSLocalizedString(@"Large", @"Large"),
             NSLocalizedString(@"Extra Large", @"Extra Large")];
}

@end
