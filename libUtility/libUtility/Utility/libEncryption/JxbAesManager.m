//
//  JxbAesManager
//  libEncryption
//
//  Created by Peter on 16/7/22.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "JxbAesManager.h"
#import "CryptLib.h"

@interface JxbAesManager()
@property (nonatomic, strong) StringEncryption  *lib;
@property (nonatomic, strong) NSString          *iv;
@end

@implementation JxbAesManager

- (instancetype)initWithIV:(NSString*)iv {
    self = [super init];
    if (self) {
        _lib = [[StringEncryption alloc] init];
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
    NSString* en_key = [self.lib sha256:key length:32];
    NSData* data = [text dataUsingEncoding:NSUTF8StringEncoding];
    NSData* dataEncrypt = [self.lib encrypt:data key:en_key iv:_iv];
    if (!dataEncrypt) return nil;
    NSString* stringEncrypt = [dataEncrypt base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return stringEncrypt;
}

- (NSString*)decrypt:(NSString *)key plainText:(NSString *)text {
    if (!text) return nil;
    NSString* de_key = [self.lib sha256:key length:32];
    NSData* data = [[NSData alloc] initWithBase64EncodedString:text options:NSDataBase64Encoding64CharacterLineLength];
    NSData* dataDecrypt = [self.lib decrypt:data key:de_key iv:_iv];
    if (!dataDecrypt) return nil;
    NSString* stringDecrypt = [[NSString alloc] initWithData:dataDecrypt encoding:NSUTF8StringEncoding];
    return stringDecrypt;
}

- (NSString*)MD5Hash:(NSString*)text {
    return [self.lib md5:text];
}

- (NSString*)sha256:(NSString*)text length:(NSInteger)length {
    return [self.lib sha256:text length:length];
}
@end
