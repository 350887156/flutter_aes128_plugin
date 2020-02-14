//
//  GTMBase64+Extension.m
//  Movies
//
//  Created by 李少川 on 2019/10/30.
//  Copyright © 2019 Movies. All rights reserved.
//

#import "GTMBase64+Extension.h"

#import <CommonCrypto/CommonCryptor.h>
@implementation GTMBase64 (Extension)
#pragma mark 加密解密
+ (NSString *)encryptWithText:(NSString *)sText forKey:(NSString*) key
{
    NSData *data = [sText dataUsingEncoding:NSUTF8StringEncoding];
    data = [self AES128EncryptWithData:data Key:key];
    data = [GTMBase64 encodeData:data];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSString *)decryptWithText:(NSString *)sText  forKey:(NSString*) key
{
    NSData *data = [GTMBase64 decodeString:sText];
    data = [self AES128DecryptWithData:data Key:key];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSData *)AES128EncryptWithData:(NSData *)data
                              Key:(NSString *)key
                              
{
    char keyPtr[kCCKeySizeAES128+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          NULL,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;

}
+ (NSData *)AES128DecryptWithData:(NSData *)data
                              Key:(NSString *)key
                              
{
    char keyPtr[kCCKeySizeAES128+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    
    
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          NULL,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    free(buffer);
    return nil;

}
@end
