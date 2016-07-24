//
//  JxbAesManager
//  libEncryption
//
//  Created by Peter on 16/7/22.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JxbAesManager : NSObject

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

/**
 *  获取MD5加密字符串
 *
 *  @param text 源文本
 *
 *  @return     MD5
 */
- (NSString*)MD5Hash:(NSString*)text;

/**
 *  获取哈希字符串（最大256）
 *
 *  @param text   源文本
 *  @param length 长度，最大256
 *
 *  @return       哈希字符串
 */
- (NSString*)sha256:(NSString*)text length:(NSInteger)length;
@end
