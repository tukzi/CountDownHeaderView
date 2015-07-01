//
//  CMFatory.h
//  Hair Design
//
//  Created by Admin on 14-5-19.
//  Copyright (c) 2014年 xiaokang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMFatory : NSObject <NSCoding>

-(id)initWithDataDic:(NSDictionary*)data;

- (NSDictionary*)attributeMapDictionary;

- (void)setAttributes:(NSDictionary*)dataDic;

- (NSString *)customDescription;

- (NSString *)description;

- (NSData*)getArchivedData;

- (NSString *)cleanString:(NSString *)str;    //清除\n和\r的字符串

@end
