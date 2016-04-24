
#import <Foundation/Foundation.h>

@interface NSObject (JMObjectSerializer)
/**
 *  将JSON字符串转换为对象
 *
 *  @param str JSON字符串
 *
 *  @return 返回对象实例
 */
+(instancetype)objectFromJSONString:(NSString*)str;
/**
 *  将JSON DATA转换为对象
 *
 *  @param data JSON DATA
 *
 *  @return 返回对象实例
 */
+(instancetype)objectFromJSONData:(NSData*)data;
/**
 *  将字典类型转换为字典
 *
 *  @param dictionary
 *
 *  @return
 */
+(instancetype)objectFromDictionary:(NSDictionary*)dictionary;

/**
 *  获取NSDictionary
 *
 *  @return
 */
-(NSMutableDictionary *)dictionaryValue;

/**
 *  通过dictionary转换
 *
 *  @param dictionary
 */
-(void)setDictionary:(NSDictionary*)dictionary;

/**
 *  获取json字符串
 *
 *  @return
 */
-(NSString *)JSONStringValue;
/**
 *  获取JSON DATA数据
 *
 *  @return
 */
-(NSData *)JSONDataValue;
@end
