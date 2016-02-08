//
//  KeychainWrapper.h
//
//  Created by Aadesh Patel.
//  Copyright (c) 2016 Aadesh Patel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeychainWrapper : NSObject

+ (KeychainWrapper *)sharedKeychain;

- (instancetype)initWithGroup:(NSString *)group;

- (void)setData:(NSData *)data
         forKey:(NSString *)key;
- (NSData *)dataForKey:(NSString *)key;

@end
