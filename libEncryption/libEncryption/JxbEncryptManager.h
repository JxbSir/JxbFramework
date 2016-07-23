//
//  JxbEncryptManager.h
//  libEncryption
//
//  Created by Peter on 16/7/22.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JxbEncryptManager : NSObject

/**
 *  初始化（若使用init，则自动随机生成IV）
 *
 *  @param iv   iv偏移向量
 *
 *  @return     self
 */
- (instancetype)initWithIV:(NSString*)iv;

/**
 *  加密函数
 *
 *  @param key  key
 *  @param text 需加密文本
 *
 *  @return     加密后字符串（加密后的NSData使用base64编码）
 */
- (NSString*)encrypt:(NSString*)key plainText:(NSString*)text;

/**
 *  解密函数
 *
 *  @param key  key
 *  @param text 需解密文本（字符串是base64编码，先解码到NSData）
 *
 *  @return     解密后字符串
 */
- (NSString*)decrypt:(NSString*)key plainText:(NSString*)text;
@end
