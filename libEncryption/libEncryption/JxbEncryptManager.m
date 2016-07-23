//
//  JxbEncryptManager.m
//  libEncryption
//
//  Created by Peter on 16/7/22.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "JxbEncryptManager.h"
#import "CryptLib.h"

@interface JxbEncryptManager()
@property (nonatomic, strong) StringEncryption  *lib;
@property (nonatomic, strong) NSString          *iv;
@end

@implementation JxbEncryptManager

- (instancetype)initWithIV:(NSString*)iv {
    self = [super init];
    if (self) {
        _iv = iv;
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _lib = [[StringEncryption alloc] init];
        NSData* data = [_lib generateRandomIV:16];
        if (data)
            _iv = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }
    return self;
}

- (NSString*)encrypt:(NSString*)key plainText:(NSString*)text {
    if (!text) return nil;
    NSData* data = [text dataUsingEncoding:NSUTF8StringEncoding];
    NSData* dataEncrypt = [self.lib encrypt:data key:key iv:_iv];
    if (!dataEncrypt) return nil;
    NSString* stringEncrypt = [dataEncrypt base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return stringEncrypt;
}

- (NSString*)decrypt:(NSString *)key plainText:(NSString *)text {
    if (!text) return nil;
    NSData* data = [[NSData alloc] initWithBase64EncodedString:text options:NSDataBase64Encoding64CharacterLineLength];
    NSData* dataDecrypt = [self.lib decrypt:data key:key iv:_iv];
    if (!dataDecrypt) return nil;
    NSString* stringDecrypt = [[NSString alloc] initWithData:dataDecrypt encoding:NSUTF8StringEncoding];
    return stringDecrypt;
}

@end
