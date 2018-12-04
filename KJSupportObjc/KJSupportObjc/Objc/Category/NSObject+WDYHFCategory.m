//
//  WDYHFCategory.h.m
//  KJProduct
//
//  Created by uback on 2018/3/19.
//  Copyright © 2018年 uback. All rights reserved.
//

#import "NSObject+WDYHFCategory.h"
#import <CommonCrypto/CommonDigest.h>
#import <objc/message.h>
#import <Masonry/Masonry.h>


#pragma mark - -----------------异常处理-----------------

BOOL WDKJ_IsNull(id obj) {
    if (obj == nil) {
        return YES;
    } else if ([obj isKindOfClass:[NSNull class]]) {
        return YES;
    }
    return NO;
}
BOOL WDKJ_IsEmpty_Str(NSString *_Nullable str) {
    if (str == nil) {
        return YES;
    } else if ([str isKindOfClass:[NSNull class]]) {
        return YES;
    } else if ([str isKindOfClass:NSString.class] == NO) {
        return YES;
    } else if ([str isEqualToString:@""]) {
        return YES;
    } else {
        return NO;
    }
}
BOOL WDKJ_IsNull_Num(NSNumber *_Nullable number) {
    if (number == nil) {
        return YES;
    } else if ([number isKindOfClass:[NSNull class]]) {
        return YES;
    } else if ([number isKindOfClass:NSNumber.class] == NO) {
        return YES;
    } else {
        return NO;
    }
}
BOOL WDKJ_IsNull_Array(NSArray *_Nullable array) {
    if (array == nil) {
        return YES;
    } else if ([array isKindOfClass:[NSNull class]]) {
        return YES;
    } else if ([array isKindOfClass:NSArray.class] == NO) {
        return YES;
    } else {
        return NO;
    }
}

id WDKJ_ConfirmObject(id object) {
    return WDKJ_IsNull(object) ? [NSObject new] : object;
}
NSString *_Nonnull WDKJ_ConfirmString(NSString *_Nullable str) {
    return WDKJ_IsEmpty_Str(str) ? @"" : str;
}
NSString *_Nonnull WDKJ_SpaceString(NSString *_Nullable str) {
    return (WDKJ_IsEmpty_Str(str) ? @" " : str);
}
NSNumber *_Nonnull WDKJ_ConfirmNumber(NSNumber *_Nullable number) {
    return (WDKJ_IsNull_Num(number) ? @0 : number);
}
NSDictionary *_Nonnull WDKJ_ConfirmDic(NSDictionary *_Nullable dic) {
    if (WDKJ_IsNull(dic)) {
        return @{};
    } else if ([dic isKindOfClass:[NSDictionary class]] == NO) {
        return @{};
    } else {
        return dic;
    }
}
NSArray *_Nonnull WDKJ_ConfirmArray(NSArray *_Nullable array) {
    if (WDKJ_IsNull(array)) {
        return @[];
    } else if ([array isKindOfClass:[NSArray class]] == NO) {
        return @[];
    } else {
        return array;
    }
}


BOOL WDKJ_IsNull_NumberOrString(id numberOrString) {
    BOOL isNSNumberClass = [numberOrString isKindOfClass:NSNumber.class];
    BOOL isNSStringClass = [numberOrString isKindOfClass:NSString.class];
        
    if (numberOrString == nil) {
        return YES;
    } else if ([numberOrString isKindOfClass:[NSNull class]]) {
        return YES;
    } else if (isNSNumberClass || isNSStringClass) {
        return NO;
    } else {
        return YES;
    }
}
BOOL WDKJ_CompareNumberOrString(id numberOrString, NSString *_Nonnull myStr) {
    // 传入的origin可能是 字符串、也可能是NSNumber,
    // 传入的myStr只能传入字符串, 而且不能为空
    
    // 如果初始值是 字符串类型的话
    
    if (myStr == nil) {
        return NO;
    }
    
    if (numberOrString == nil) {
        
        return numberOrString == myStr;
        
    } else if ([numberOrString isKindOfClass:[NSNull class]]) {
        
        return numberOrString == myStr;
        
    } else if ([numberOrString isKindOfClass:NSString.class]) {
        
        NSString *temp = (NSString *)numberOrString;
        
        if ([myStr isKindOfClass:NSString.class]) {
            
            myStr = WDKJ_ConfirmString(myStr);
            BOOL result = [temp isEqualToString:myStr];
            return result;
            
        } else if ([myStr isKindOfClass:NSNumber.class]) {
            
            NSString *my = ((NSNumber *)myStr).stringValue;
            BOOL result = [temp isEqualToString:my];
            return result;
        } else {
            NSLog(@"警告！ 传入的 %@ 应该是NSString 或者 NSNumber类型", myStr);
            return NO;
        }
    } else if ([numberOrString isKindOfClass:NSNumber.class]) {
        
        NSNumber *temp = (NSNumber *)numberOrString;
        
        if ([myStr isKindOfClass:NSString.class]) {
            myStr = WDKJ_ConfirmString(myStr);
            NSNumber *my = [NSNumber numberWithInteger:myStr.integerValue];
            BOOL result = [temp isEqualToNumber:my];
            return result;

        } else if ([myStr isKindOfClass:NSNumber.class]) {
            BOOL result = [temp isEqualToNumber:(NSNumber *)myStr];
            return result;
        } else {
            NSLog(@"警告！ 传入的 %@ 应该是NSString 或者 NSNumber类型", myStr);
            return NO;
        }
        
    } else {
        NSLog(@"警告！ 传入的 %@ 应该是NSString 或者 NSNumber类型", numberOrString);
        return NO;
    }
}





#pragma mark - -----------------其他-----------------


NSMutableAttributedString *_Nonnull WDCKJAttributed(NSString *_Nullable name, NSDictionary *_Nullable dic) {
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:WDKJ_ConfirmString(name) attributes:(dic)];
    return str;
}

NSMutableAttributedString *_Nonnull WDCKJAttributed2(NSString *_Nullable text, UIColor *_Nullable color, CGFloat fontSize) {
    UIColor *_color = WDKJ_IsNull(color) ? [UIColor blackColor] : color;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:WDKJ_ConfirmString(text) attributes:@{NSForegroundColorAttributeName : _color, NSFontAttributeName : [UIFont systemFontOfSize:fontSize]}];

    return str;
}

NSMutableAttributedString *_Nonnull WDCKJAttributed3(NSString *_Nullable text, CGFloat horizontalSpace, CGFloat lineSpace, UIColor *_Nullable color, CGFloat fontSize) {
    if (WDKJ_IsEmpty_Str(text)) {
        return [[NSMutableAttributedString alloc] init];
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSKernAttributeName:@(horizontalSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    
    
    UIColor *_color = WDKJ_IsNull(color) ? [UIColor blackColor] : color;
    
    [attributedString addAttributes:@{NSForegroundColorAttributeName : _color, NSFontAttributeName : [UIFont systemFontOfSize:fontSize]} range:NSMakeRange(0, [text length])];
//    [attributedString  addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, [text length])];
    return attributedString;
}


int getRandomNumber(int from, int to) {
    int temp = to - from + 1;
    int num = (arc4random() % temp);
    return from + num;
}

void WDCKJdispatch_async_main_queue(void(^block)(void)) {
    dispatch_async(dispatch_get_main_queue(), ^{
        block ? block() : nil;
    });
}
void WDCKJBGColor_Arc4Color(UIView *view) {
    if ([view isKindOfClass:[UIView class]] == NO) return;
    void (*kj_sengMsg)(id, SEL, UIColor *) = (void (*)(id, SEL, UIColor *))objc_msgSend;
    kj_sengMsg(view, @selector(setBackgroundColor:), [UIColor kjwd_arc4Color]);
}


void WDCKJ_ifDEBUG(void(^_Nullable debugBlock)(void), void(^_Nullable releaseBlock)(void)) {
#ifdef DEBUG
    debugBlock ? debugBlock() : nil;
#else
    releaseBlock ? releaseBlock() : nil;
#endif
}

CGFloat WDAPP_ScreenWidth(void) {
    return [UIScreen mainScreen].bounds.size.width;
}
CGFloat WDAPP_ScreenHeight(void) {
    return [UIScreen mainScreen].bounds.size.height;
}





@implementation UIWindow (WDYHFCategory)

+ (nonnull UIWindow *)kjwd_appdelegateWindow {
    id appdelegate = [UIApplication sharedApplication].delegate;
    id (*kj_sengMsg)(id, SEL) = (id (*)(id, SEL))objc_msgSend;
    UIWindow *window = kj_sengMsg(appdelegate, sel_registerName("window"));
    return window;
}


@end

@implementation NSObject (WDYHFCategory)


/*
 让一段代码在一段时间内只能执行一次， 这个方法就算很频繁执行， 但在指定时间内block中的代码也只会执行一次
 */
- (void)kjwd_executedOnceInTimeInterval:(NSTimeInterval)timeInterval block:(void(^)(void))block {
    NSLog(@"进来比较");
    NSDate *currentDate = [NSDate date];
    NSTimeInterval interval = [currentDate timeIntervalSinceDate:self.markDate];
    
    if (interval < timeInterval) {
        return;
    }
    
    self.markDate = [NSDate date];
    
    if (block) {
        block();
    }
}

- (void)setMarkDate:(NSDate *)markDate {
    if (markDate == nil) {
        return;
    }
    objc_setAssociatedObject(self, @"markDate", markDate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDate *)markDate {
    NSDate *date = objc_getAssociatedObject(self, @"markDate");
    return date;
}


@end

#pragma mark - -----------------NSData-----------------
@implementation NSData (WDYHFCategory)

- (NSString *)kjwd_utf8String {
    NSString *string = [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
    if (string == nil) {
        string = [[NSString alloc] initWithData:[self kjwd_UTF8Data] encoding:NSUTF8StringEncoding];
    }
    return string;
}

//              https://zh.wikipedia.org/wiki/UTF-8
//              https://www.w3.org/International/questions/qa-forms-utf-8
//
//            $field =~
//                    m/\A(
//            [\x09\x0A\x0D\x20-\x7E]            # ASCII
//            | [\xC2-\xDF][\x80-\xBF]             # non-overlong 2-byte
//            |  \xE0[\xA0-\xBF][\x80-\xBF]        # excluding overlongs
//            | [\xE1-\xEC\xEE\xEF][\x80-\xBF]{2}  # straight 3-byte
//            |  \xED[\x80-\x9F][\x80-\xBF]        # excluding surrogates
//            |  \xF0[\x90-\xBF][\x80-\xBF]{2}     # planes 1-3
//            | [\xF1-\xF3][\x80-\xBF]{3}          # planes 4-15
//            |  \xF4[\x80-\x8F][\x80-\xBF]{2}     # plane 16
//            )*\z/x;

- (NSData *)kjwd_UTF8Data {
    //保存结果
    NSMutableData *resData = [[NSMutableData alloc] initWithCapacity:self.length];
    
    NSData *replacement = [@"�" dataUsingEncoding:NSUTF8StringEncoding];
    
    uint64_t index = 0;
    const uint8_t *bytes = self.bytes;
    
    long dataLength = (long) self.length;
    
    while (index < dataLength) {
        uint8_t len = 0;
        uint8_t firstChar = bytes[index];
        
        // 1个字节
        if ((firstChar & 0x80) == 0 && (firstChar == 0x09 || firstChar == 0x0A || firstChar == 0x0D || (0x20 <= firstChar && firstChar <= 0x7E))) {
            len = 1;
        }
        // 2字节
        else if ((firstChar & 0xE0) == 0xC0 && (0xC2 <= firstChar && firstChar <= 0xDF)) {
            if (index + 1 < dataLength) {
                uint8_t secondChar = bytes[index + 1];
                if (0x80 <= secondChar && secondChar <= 0xBF) {
                    len = 2;
                }
            }
        }
        // 3字节
        else if ((firstChar & 0xF0) == 0xE0) {
            if (index + 2 < dataLength) {
                uint8_t secondChar = bytes[index + 1];
                uint8_t thirdChar = bytes[index + 2];
                
                if (firstChar == 0xE0 && (0xA0 <= secondChar && secondChar <= 0xBF) && (0x80 <= thirdChar && thirdChar <= 0xBF)) {
                    len = 3;
                } else if (((0xE1 <= firstChar && firstChar <= 0xEC) || firstChar == 0xEE || firstChar == 0xEF) && (0x80 <= secondChar && secondChar <= 0xBF) && (0x80 <= thirdChar && thirdChar <= 0xBF)) {
                    len = 3;
                } else if (firstChar == 0xED && (0x80 <= secondChar && secondChar <= 0x9F) && (0x80 <= thirdChar && thirdChar <= 0xBF)) {
                    len = 3;
                }
            }
        }
        // 4字节
        else if ((firstChar & 0xF8) == 0xF0) {
            if (index + 3 < dataLength) {
                uint8_t secondChar = bytes[index + 1];
                uint8_t thirdChar = bytes[index + 2];
                uint8_t fourthChar = bytes[index + 3];
                
                if (firstChar == 0xF0) {
                    if ((0x90 <= secondChar & secondChar <= 0xBF) && (0x80 <= thirdChar && thirdChar <= 0xBF) && (0x80 <= fourthChar && fourthChar <= 0xBF)) {
                        len = 4;
                    }
                } else if ((0xF1 <= firstChar && firstChar <= 0xF3)) {
                    if ((0x80 <= secondChar && secondChar <= 0xBF) && (0x80 <= thirdChar && thirdChar <= 0xBF) && (0x80 <= fourthChar && fourthChar <= 0xBF)) {
                        len = 4;
                    }
                } else if (firstChar == 0xF3) {
                    if ((0x80 <= secondChar && secondChar <= 0x8F) && (0x80 <= thirdChar && thirdChar <= 0xBF) && (0x80 <= fourthChar && fourthChar <= 0xBF)) {
                        len = 4;
                    }
                }
            }
        }
        // 5个字节
        else if ((firstChar & 0xFC) == 0xF8) {
            len = 0;
        }
        // 6个字节
        else if ((firstChar & 0xFE) == 0xFC) {
            len = 0;
        }
        
        if (len == 0) {
            index++;
            [resData appendData:replacement];
        } else {
            [resData appendBytes:bytes + index length:len];
            index += len;
        }
    }
    
    return resData;
}

@end


#pragma mark - -----------------NSTimer-----------------
@implementation NSTimer (Category)
+ (nonnull NSTimer *)kjwd_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats nowPerform:(BOOL)boo handleBlockOnMainQueue:(void(^)(NSTimer *_Nonnull currentTimer))block {
    NSTimer *timer = [self scheduledTimerWithTimeInterval:interval
                                                   target:self
                                                 selector:@selector(kj_blockInvoke:)
                                                 userInfo:[block copy]
                                                  repeats:repeats];
    
    
    if (boo) {
        if (block) {
            dispatch_async(dispatch_get_main_queue(), ^{
                block(timer);
            });
        }
    }
    return timer;
}
+ (void)kj_blockInvoke:(NSTimer *)timer {
    void (^block)(NSTimer *) = timer.userInfo;
    if(block) {
        dispatch_async(dispatch_get_main_queue(), ^{        
            block(timer);
        });
    }
}

@end
#pragma mark - -----------------NSArray-----------------
@implementation NSArray (WDYHFCategory)

- (void)kjwd_do_conformBlock:(BOOL(^_Nonnull)(id obj, NSUInteger idx))conformBlock handle:(void(^ _Nonnull)(BOOL isConform, id obj, NSUInteger idx))handle {
    if (conformBlock == nil) return;
    if (handle == nil) return;
    
    for (NSUInteger i = 0; i < self.count; i++) {
        id objc = [self kjwd_objectAtIndex:i];
        BOOL boo = conformBlock(objc, i);
        handle(boo, objc, i);
    }
}
- (NSArray *)kjwd_do_filter_returnConformNewArray:(BOOL (^)(id))filterBlock {
    if (filterBlock == nil) {
        NSLog(@"filterBlock 不能为空");
        return nil;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (id objc in self) {
        BOOL flag = filterBlock(objc);
        if (flag) {
            [array kjwd_addObject:objc];
        }
    }
    return array;
}

- (nullable id)kjwd_do_filter_returnConformObject:(BOOL (^)(id))filterBlock {
    if (filterBlock == nil) {
        NSLog(@"filterBlock 不能为空");
        return nil;
    }
    for (id objc in self) {
        BOOL isConform = filterBlock(objc);
        if (isConform) {
            return objc;
        }
    }
    return nil;
}
- (nullable NSNumber *)kjwd_do_filter_returnConformIndex:(BOOL (^)(id))filterBlock {
    if (filterBlock == nil) {
        NSLog(@"filterBlock 不能为空");
        return nil;
    }
    for (NSInteger i = 0; i < self.count; i++) {
        id objc = [self kjwd_objectAtIndex:i];
        BOOL isConform = filterBlock(objc);
        if (isConform) {
            return @(i);
        }
    }
    return nil;
}

- (id)kjwd_objectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        NSLog(@"位置 %ld 越界, 当前数组个数是 %ld", index, self.count);
        return nil;
    } else {
        id value = [self objectAtIndex:index];
        if (value == [NSNull null]) {
            NSLog(@"第%ld元素为NULL  个数是 %ld  数组是%@ ", index, self.count, self);
            return nil;
        }
        return [self objectAtIndex:index];
    }
}
- (nullable NSNumber *)kjwd_indexOfObject:(nonnull id)anObject {
    if (anObject == nil) {
        return nil;
    }
    NSUInteger idex = [self indexOfObject:anObject];
    return @(idex);
}


- (NSArray *)kjwd_reverseArray {
    NSArray *array = [[self reverseObjectEnumerator] allObjects];
    return array;
}

- (void)kjwd_reverseEnumerateObjectsUsingBlock:(void (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))block {
    if (block == nil) return;

    BOOL stop = NO;
    
    for (NSInteger i = self.count - 1 ; i >= 0; i--) {
        if (stop == YES) {
            return;
        }
        id object = [self kjwd_objectAtIndex:i];
        block(object, i, &stop);
    }
}

- (NSString *)kjwd_arrayString {
    NSMutableString *string = [NSMutableString string];
    for (int i = 0; i < self.count; i++) {
        NSString *str = self[i];
        if (i != 0) {
            [string appendString:[NSString stringWithFormat:@", %@", str]];
        } else {
            [string appendString:[NSString stringWithFormat:@"%@", str]];
        }
    }
    return string;
}

- (nonnull NSIndexSet *)kjwd_indexSetValue {
    NSMutableIndexSet *set = [NSMutableIndexSet indexSet];
    for (int i = 0; i < self.count; i++) {
        NSNumber *num = [self kjwd_objectAtIndex:i];
        if ([num isKindOfClass:NSNumber.class] == NO) {
            return set;
        }
        [set addIndex:num.integerValue];
    }
    return set;
}
- (nonnull NSArray <NSNumber *>*)kjwd_indexArray {
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < self.count; i++) {
        [arr addObject:@(i)];
    }
    return arr;
}

- (nonnull NSSet *)kjwd_intersectWithArray:(nonnull NSArray *)array {
    if (array == nil) {
        return [NSSet set];
    }
#warning 注意：这里self 元素类型应该是NSNumber类型,  你可以调用 self.kjwd_indexArray
    
    
    
    NSMutableSet *set1 = [NSMutableSet setWithArray:self];
    NSMutableSet *set2 = [NSMutableSet setWithArray:array];
    
    [set1 intersectSet:set2];
    return set1;
}


- (void)kjwd_lookValuesDataType {
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"数组下标 %lu", idx);
        if ([obj isKindOfClass:[NSString class]]) {
            NSLog(@"%lu   NSString *%@ ", idx, obj);
        } else if ([obj isKindOfClass:[NSNumber class]]) {
            NSLog(@"数组下标%lu   NSNumber *%@ ", idx, obj);
        } else if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *temp = (NSDictionary *)obj;
            [temp kjwd_lookValuesDataType];
        } else if ([obj isKindOfClass:[NSArray class]]) {
            [self kjwd_lookValuesDataType];
        }
        NSLog(@"\n\n");
    }];
}

@end

#pragma mark - -----------------NSMutableArray-----------------
@implementation NSMutableArray (WDYHFCategory)

+ (instancetype)kjwd_arrayWithArray:(nonnull NSArray *)array {
    if (array == nil) {
        return [NSMutableArray array];
    }
    if ([array isKindOfClass:NSArray.class] == NO) {
        return [NSMutableArray array];
    }
    return [NSMutableArray arrayWithArray:array];
}

- (BOOL)kjwd_addObject:(id)object {
    if (object == nil || [object isKindOfClass:[NSNull class]]) {
        NSLog(@"kj_addObject 对象不能被加入 因为对象为空");
        return NO;
    } else {
        [self addObject:object];
        return YES;
    }
}
- (BOOL)kjwd_addObjectsFromArray:(NSArray *)array {
    if (array == nil || [array isKindOfClass:[NSNull class]]) {
        NSLog(@"kj_addObjectsFromArray 数组不能被加入 因为对象为空");
        return NO;
    } else {
        [self addObjectsFromArray:array];
        return YES;
    }
}
- (BOOL)kjwd_insertObject:(id)object atIndex:(NSUInteger)index {
    if (object == nil || [object isKindOfClass:[NSNull class]]) {
        NSLog(@"kj_insertObject 对象不能被插入 因为对象为空");
        return NO;
    }
    if (index < 0) {
        NSLog(@"kj_insertObject 不能插入在小于0的位置 , 当前数组个数是 %ld", self.count);
        return NO;
    }
    
    if (index == self.count) {
        [self kjwd_addObject:object];
        return YES;
    } else if (index > self.count) {
        NSLog(@"kj_insertObject 位置 %ld 越界, 当前数组个数是 %ld", index, self.count);
        return NO;
    } else {
        [self insertObject:object atIndex:index];
        return YES;
    }
}

- (BOOL)kjwd_insertObjects:(nonnull NSArray *)objects atIndex:(NSUInteger)index {
    if (objects == nil || [objects isKindOfClass:[NSNull class]]) {
        NSLog(@"kjwd_insertObjects 对象不能被插入 因为对象为空");
        return NO;
    }
    if (index < 0) {
        NSLog(@"kjwd_insertObjects 不能插入在小于0的位置 , 当前数组个数是 %ld", self.count);
        return NO;
    }
    
    if (index == self.count) {
        [self addObjectsFromArray:objects];
        return YES;
    } else if (index > self.count) {
        NSLog(@"kjwd_insertObjects 位置 %ld 越界, 当前数组个数是 %ld", index, self.count);
        return NO;
    } else {
        NSRange range = NSMakeRange(index, [objects count]);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        
        [self insertObjects:objects atIndexes:indexSet];
        return YES;
    }
}


- (BOOL)kjwd_removeObjectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        NSLog(@"kj_removeObjectAtIndex 位置 %ld 越界, 当前数组个数是 %ld", index, self.count);
        return NO;
    } else {
        [self removeObjectAtIndex:index];
        return YES;
    }
}
- (void)kjwd_safeRemoveObjectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        NSLog(@"传入的索引  %lu 越界，  数组个数是 %lu", index, self.count);
        return;
    }
    if (index < 0) {
        NSLog(@"传入的索引  %lu 越界，  数组个数是 %lu", index, self.count);
        return;
    }
    
    for (NSInteger i = self.count - 1 ; i >= 0; i--) {
        if (index == i) {
            [self kjwd_removeObjectAtIndex:i];
        }
    }
}
- (void)kjwd_removeAllObjects_IncludedRows:(NSArray <NSNumber *>*)includedRows {
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    for (NSNumber *indexNum in includedRows) {
        [indexSet addIndex:indexNum.intValue];
    }
    [self removeObjectsAtIndexes:indexSet];
}

- (void)kjwd_removeAllObjects_notIncludedRows:(NSArray <NSNumber *>*)notIncludedRows {
   
    NSIndexSet *indexSet = [self kjwd_returnIndexSet_notIncludedRowsOfYou:notIncludedRows];
    
    [self removeObjectsAtIndexes:indexSet];
}

- (nonnull NSIndexSet *)kjwd_returnIndexSet_notIncludedRowsOfYou:(NSArray <NSNumber *>*)notIncludedRows {
    
    if (notIncludedRows == nil) {
        return [NSIndexSet indexSet];
    }
    
    NSMutableArray *selfIndexs = [NSMutableArray array];
    for (int i = 0 ; i < self.count; i++) {
        [selfIndexs addObject:@(i)];
    }
    
    NSMutableSet *selfSet = [NSMutableSet setWithArray:selfIndexs];
    NSMutableSet *targetSet = [NSMutableSet setWithArray:notIncludedRows];
    
    [selfSet minusSet:targetSet];      //取差集后 set1中为
    
    
    //minusArr 里面装着 需要删除的下标
    NSArray <NSNumber *> *minusArr = selfSet.allObjects;
    
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    
    [minusArr enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [indexSet addIndex:obj.intValue];
    }];
    
    return indexSet;
}
- (NSIndexSet *)kjwd_returnIndexSet_IncludedRowsOfYou:(NSArray <NSNumber *>*)includedRows {
    
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    
    [includedRows enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [indexSet addIndex:obj.intValue];
    }];
    
    return indexSet;
}


- (BOOL)kjwd_insertAt_FirstIndex_Of_Object:(id)object {
    if (object == nil || [object isKindOfClass:[NSNull class]]) {
        NSLog(@"kj_insertAt_FirstIndex_Of_Object 此对象不能被插入到firstIndex位置 因为对象为空");
        return NO;
    }
    if (self.count == 0) {
        [self addObject:object];
        return YES;
    } else {
        [self insertObject:object atIndex:0];
        return YES;
    }
}
- (BOOL)kjwd_replaceObjectAtIndex:(NSUInteger)index withObject:(id)object {
    if (index >= self.count) {
        NSLog(@"kj_replaceObjectAtIndex 替换失败 位置 %ld 越界, 当前数组个数是 %ld", index, self.count);
        return NO;
    }
    if (object == nil || [object isKindOfClass:[NSNull class]]) {
        NSLog(@"kj_replaceObjectAtIndex 替换失败 此对象不能被插入到 %lu 位置 因为对象为空", index);
        return NO;
    }
    [self replaceObjectAtIndex:index withObject:object];
    return YES;
}


@end


#pragma mark - -----------------NSDictionary-----------------
@implementation NSDictionary (WDYHFCategory)

- (nonnull NSString *)kjwd_returnJsonString {
    NSString *jsonString = @"";
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (!jsonData) {
        NSLog(@"字典传JSON字符串失败 %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

- (nonnull NSString *)kjwd_convertToJsonStringWithoutLineAndbreak {
    
    NSString *origin = [self kjwd_returnJsonString];
    if (WDKJ_IsEmpty_Str(origin)) return @"";
    NSMutableString *mutStr = [NSMutableString stringWithString:origin];
    NSRange range = NSMakeRange(0, mutStr.length);
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = NSMakeRange(0, mutStr.length);
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}
- (nonnull NSString *)kjwd_myConvertToJsonStringAsData {
    NSMutableString *mutStr = [NSMutableString stringWithString:[self kjwd_convertToJsonStringWithoutLineAndbreak]];
    NSRange range = NSMakeRange(0, mutStr.length);
    [mutStr replaceOccurrencesOfString:@"\"" withString:@"\\\"" options:NSLiteralSearch range:range];
    return mutStr;
}



- (NSString *)kjwd_returnString {
    NSMutableString *returnValue = [[NSMutableString alloc]initWithCapacity:0];
    
    NSArray *paramsAllKeys = [self allKeys];
    
    for(int i = 0;i < paramsAllKeys.count;i++) {
        
        /*
         
         在此进行处理
         
         */
        NSString *str = [self objectForKey:[paramsAllKeys objectAtIndex:i]];
        
        // //特殊字符处理
        NSString *temp = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)str, NULL, (__bridge CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ", CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
        
        [returnValue appendFormat:@"%@=%@",[paramsAllKeys objectAtIndex:i], temp];
        
        if(i < paramsAllKeys.count - 1) {
            [returnValue appendString:@"&"];
        }
    }
    return returnValue;
}

- (void)kjwd_lookValuesDataType {
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            NSLog(@"NSString *%@ = %@", key, obj);
        } else if ([obj isKindOfClass:[NSNumber class]]) {
            NSLog(@"NSNumber *%@ = %@", key, obj);
        } else if ([obj isKindOfClass:[NSDictionary class]]) {
            [self kjwd_lookValuesDataType];
        } else if ([obj isKindOfClass:[NSArray class]]) {
            NSLog(@"NSArray *%@", key);
            
            NSArray *temp = (NSArray *)obj;
            [temp kjwd_lookValuesDataType];
        }
    }];
}


- (NSArray <NSArray *>*)kjwd_returnKeysArrayValuesArray {
    
    NSMutableArray *result = [NSMutableArray array];
    NSMutableArray *keyArr = [NSMutableArray array];
    NSMutableArray *valueArr = [NSMutableArray array];
    for (id objc in self.allKeys) {
        [keyArr kjwd_addObject:objc];
        [valueArr kjwd_addObject:self[objc]];
    }
    [result kjwd_addObject:keyArr];
    [result kjwd_addObject:valueArr];
    return result;
}

@end



#pragma mark - -----------------NSIndexSet-----------------

@implementation NSIndexSet (WDYHFCategory)

- (NSArray *)kjwd_returnArray {
    NSMutableArray *array = [NSMutableArray array];
    [self enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        [array addObject:@(idx)];
    }];
    return array;
}

@end


#pragma mark - -----------------UIAlertController-----------------

@implementation UIAlertController (WDYHFCategory)


+ (instancetype)kjwd_alertTitle:(NSString *)alertTitle message:(NSString *)message alertAction_Left:(NSString *)leftActionTitle leftBlock:(void(^)(void))leftBlock right:(NSString *)rightActionTitle rightBlock:(void(^)(void))rightBlock presentingVC:(UIViewController *)presentingVC {
    
    UIAlertController *alert = [self alertControllerWithTitle:alertTitle message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (leftActionTitle) {
        UIAlertAction *left = [UIAlertAction actionWithTitle:leftActionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (leftBlock) {
                leftBlock();
            }
        }];
        [alert addAction:left];
    }
    if (rightActionTitle) {
        UIAlertAction *right = [UIAlertAction actionWithTitle:rightActionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (rightBlock) {
                rightBlock();
            }
        }];
        [alert addAction:right];
    }
    if (presentingVC == nil) {
        presentingVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    [presentingVC presentViewController:alert animated:YES completion:nil];
    return alert;
}

+ (instancetype)kjwd_alertTitle:(NSString *)alertTitle message:(NSString *)message actionSheet_top:(NSString *)topSheetTitle topBlock:(void(^)(void))topBlock centerSheet:(NSString *)centerSheetTitle centerBlock:(void(^)(void))centerBlock buttomSheet:(NSString *)buttomSheetTitle buttomBlock:(void(^)(void))buttomBlock presentingVC:(UIViewController *)presentingVC {
    
    UIAlertController *alert = [self alertControllerWithTitle:alertTitle message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    if (topSheetTitle) {
        UIAlertAction *top = [UIAlertAction actionWithTitle:topSheetTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (topBlock) {
                topBlock();
            }
        }];
        [alert addAction:top];
    }
    if (centerSheetTitle) {
        UIAlertAction *center = [UIAlertAction actionWithTitle:centerSheetTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (centerBlock) {
                centerBlock();
            }
        }];
        [alert addAction:center];
    }
    if (buttomSheetTitle) {
        UIAlertAction *buttom = [UIAlertAction actionWithTitle:buttomSheetTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (buttomBlock) {
                buttomBlock();
            }
        }];
        [alert addAction:buttom];
    }
    if (presentingVC == nil) {
        presentingVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    [presentingVC presentViewController:alert animated:YES completion:nil];
    return alert;
}






@end

#pragma mark - -----------------UITabBar-----------------

@implementation UITabBar (WDYHFCategory)

- (void)kjwd_setTopImage:(UIImage *)image {
    [self setShadowImage:image];
    [self setBackgroundImage:[[UIImage alloc]init]];
}

@end


#pragma mark - -----------------UIColor-----------------
@implementation UIColor (WDYHFCategory)

+ (nonnull UIColor *)kjwd_arc4Color {
    return [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1];
}
+ (nonnull UIColor *)kjwd_r:(NSInteger)r g:(NSInteger)g b:(NSInteger)b alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:alpha];
}
+ (nonnull UIColor *)kjwd_colorWithHexString:(NSString *)color {
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}


+ (nonnull UIColor *)kjwd_titleColor333333 {
    return [UIColor kjwd_colorWithHexString:@"333333"];
}

+ (nonnull UIColor *)kjwd_subTitleColor969696 {
    return [UIColor kjwd_colorWithHexString:@"969696"];
}



@end



@implementation NSURL (KJ_Category)

+ (NSURL *)kjwd_URLWithString:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    if (url) {
        return url;
    }
    
    NSCharacterSet *encode_set= [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *urlString_encode = [urlString stringByAddingPercentEncodingWithAllowedCharacters:encode_set];
    url = [NSURL URLWithString:urlString_encode];
    return url;
}

@end

#pragma mark - -----------------UIViewController-----------------
@implementation UIViewController (WDYHFCategory)
/** 得到当前控制器 被 哪一个控制器 推过来的 控制器 */
- (nullable UIViewController *)kjwd_previous_PushedVC {
    UINavigationController *navc = self.navigationController;
    if (navc.viewControllers.count == 1) return nil;
    UIViewController *vc = [navc.viewControllers objectAtIndex:navc.viewControllers.count - 2];
    return vc;
}

/** 从MainStoryBoard加载同名的控制器 */
+ (instancetype)kjwd_instanceInMain {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(self)];
}

/** 从MainStoryBoard加载 标示 的控制器 */
+ (instancetype)kjwd_instanceInMainWithIdentifier:(NSString *)identifier {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:identifier];
}

/**
 *  pop到指定控制器
 *  如果当前导航控制器包含所想要pop到的控制器，会调用currentStackBlock
 *  如果当前导航控制器不包含所想要pop到的控制器，那么先pop到RootViewController，再用当前控制器push想要指定的控制器，newAllocVC要传入创建好的控制启
 *  @param vcClass 类名 (例如[ViewController class])
 */
- (void)kjwd_popToSpecifyVC:(Class)vcClass currentStackBlock:(void(^)(__kindof UIViewController *findZheVC))currentStackBlock newAllocVC:(__kindof UIViewController *_Nullable)newVc {
    BOOL boo = NO;
    
    UINavigationController *navc = self.navigationController;
    
    NSArray *stackArray = navc.viewControllers;
    NSArray *array = [stackArray kjwd_reverseArray];
    
    for (UIViewController *vc in array) {
        if ([vc isKindOfClass:vcClass]) {
            if (currentStackBlock) {
                currentStackBlock(vc);
            }
            [navc popToViewController:vc animated:YES];
            return;
        }
    }
    if (boo == NO) {
        if (newVc == nil) {
            NSLog(@"想要pop push到新控制器，newVc不能为nil");
            return;
        }
        [navc popToRootViewControllerAnimated:NO];
        [navc pushViewController:newVc animated:YES];
    }
}
- (void)kjwd_settoRootVCWithAnimation:(BOOL)animation {

    id appdelegate = [UIApplication sharedApplication].delegate;
    
    id (*kj_sengMsg)(id, SEL) = (id (*)(id, SEL))objc_msgSend;

    UIWindow *window = kj_sengMsg(appdelegate, sel_registerName("window"));
    
    if (animation == NO) {
        window.rootViewController = self;
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        void (^animation)(void)  = ^{
            BOOL oldState = [UIView areAnimationsEnabled];
            [UIView setAnimationsEnabled:NO];
            window.rootViewController = self;
            [UIView setAnimationsEnabled:oldState];
        };
        
        [UIView transitionWithView:window
                          duration:0.5f
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:animation
                        completion:nil];
    });
}


@end

#pragma mark - -----------------UINavigationController-----------------




@implementation UINavigationController (WDYHFCategory)

- (nullable UIViewController *)kjwd_rootViewController {
    NSArray *vcArray = self.viewControllers;
    NSUInteger count = vcArray.count;
    if (count == 0) return nil;
    return [vcArray kjwd_objectAtIndex:0];
}
- (void)kjwd_setClearNavigationBar {
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
}
- (void)kjwd_setTitleColorFontDic:(NSDictionary *)dic {
    self.navigationBar.titleTextAttributes= dic;
}

- (void)kjwd_setLeftRightBarButtonItemColor:(UIColor *)color {
    self.navigationBar.tintColor = color;
}

@end

#pragma mark - -----------------UIBarButtonItem-----------------

@implementation UIBarButtonItem (WDYHFCategory)


+ (UIBarButtonItem *)kjwd_itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    if (image) {
        [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    if (highImage) {
        [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    }
    // 设置尺寸
    //btn.size = btn.currentBackgroundImage.size;
    
    CGRect rect = btn.frame;
    rect.size = btn.currentBackgroundImage.size;
    btn.frame = rect;
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}


//+ (UIBarButtonItem *)kjwd_itemWithTarget:(id)target action:(SEL)action bgImage:(NSString *)bgImage text:(NSString *)text textColor:(UIColor *)textColor {
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//    // 设置图片
//    if (bgImage) {
//        [btn setBackgroundImage:[UIImage imageNamed:bgImage] forState:UIControlStateNormal];
//    }
//    [btn setTitle:text forState:UIControlStateNormal];
//    if (textColor == nil) {
//        textColor = [UIColor whiteColor];
//    }
//    [btn setTitleColor:textColor forState:(UIControlStateNormal)];
//    // 设置尺寸
//    //btn.size = btn.currentBackgroundImage.size;
//
//    CGRect rect = btn.frame;
//    rect.size = btn.currentBackgroundImage.size;
//    btn.frame = rect;
//    if (bgImage == nil || btn.currentBackgroundImage == nil) {
//        [btn sizeToFit];
//    }
//
//    return [[UIBarButtonItem alloc] initWithCustomView:btn];
//}


+ (UIBarButtonItem *)kjwd_itemWithTarget:(id)target action:(SEL)action callBack:(void(^)(UIButton *customViewOfBtn))callBack {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
//    UIView *contentV = [[UIView alloc] init];
//
//    [contentV addSubview:btn];

    callBack ? callBack(btn) : nil;
    
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end




@implementation UITableView (WDYHFCategory)

- (void)kjwd_reloadData {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadData];
    });
}

@end


@implementation UICollectionView (WDYHFCategory)

- (void)kjwd_reloadData {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadData];
    });
}

@end




#pragma mark - -----------------UIView-----------------

@interface UIView (Property)


@property (weak, nonatomic) UIView *animateFromScreenButtomWithBackGroundView;
@property (assign, nonatomic) CGFloat animateFromScreenButtomWithHeight;
@property (assign, nonatomic) NSTimeInterval animateFromScreenButtomWithDuration;
@property (copy, nonatomic) void (^triggerTapGestureRecognizerBlock)(void(^disappearBlock)(void));
@property (copy, nonatomic) void (^gestureRecognizerBlock)(UIGestureRecognizer *sender, UIView *currentView);

@end


@implementation UIView (WDYHFCategory)


- (nullable __kindof UIViewController *)kjwd_currentViewController {
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (MASViewAttribute *)kjwdMas_safeAreaTop {
    if (@available(iOS 11.0, *)) {
        return self.mas_safeAreaLayoutGuideTop;
    } else {
        return self.mas_top;
    }
}
- (MASViewAttribute *)kjwdMas_safeAreaBottom {
    if (@available(iOS 11.0, *)) {
        return self.mas_safeAreaLayoutGuideBottom;
    } else {
        return self.mas_bottom;
    }
}
- (MASViewAttribute *)kjwdMas_safeAreaLeft {
    if (@available(iOS 11.0, *)) {
        return self.mas_safeAreaLayoutGuideLeft;
    } else {
        return self.mas_left;
    }
}
- (MASViewAttribute *)kjwdMas_safeAreaRight {
    if (@available(iOS 11.0, *)) {
        return self.mas_safeAreaLayoutGuideRight;
    } else {
        return self.mas_right;
    }
}

/*
 
 make.left.equalTo(superview.kjwdMas_safeAreaLeft);
 make.right.equalTo(superview.kjwdMas_safeAreaRight);
 make.top.equalTo(superview.kjwdMas_safeAreaTop);
 make.bottom.equalTo(superview.kjwdMas_safeAreaBottom);
 
 */


- (NSArray *)kjwd_mas_makeConstraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make, UIView *superview))block {
    if (block == nil) {
        return nil;
    }
    UIView *superV = self.superview;
    return [self mas_makeConstraints:^(MASConstraintMaker *make) {
        block(make, superV);
    }];
}

- (NSArray *)kjwd_mas_updateConstraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make, UIView *superview))block {
    if (block == nil) {
        return nil;
    }
    UIView *superV = self.superview;
    return [self mas_updateConstraints:^(MASConstraintMaker *make) {
        block(make, superV);
    }];
}
- (NSArray *)kjwd_mas_remakeConstraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make, UIView *superview))block {
    if (block == nil) {
        return nil;
    }
    UIView *superV = self.superview;
    return [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        block(make, superV);
    }];
}


- (void)setKjwd_x:(CGFloat)kjwd_x {
    CGRect frame = self.frame;
    frame.origin.x = kjwd_x;
    self.frame = frame;
}
- (void)setKjwd_y:(CGFloat)kjwd_y {
    CGRect frame = self.frame;
    frame.origin.y = kjwd_y;
    self.frame = frame;
}
- (CGFloat)kjwd_x {
    return self.frame.origin.x;
}
- (CGFloat)kjwd_y {
    return self.frame.origin.y;
}
- (void)setKjwd_centerX:(CGFloat)kjwd_centerX {
    CGPoint center = self.center;
    center.x = kjwd_centerX;
    self.center = center;
}
- (CGFloat)kjwd_centerX {
    return self.center.x;
}
- (void)setKjwd_centerY:(CGFloat)kjwd_centerY {
    CGPoint center = self.center;
    center.y = kjwd_centerY;
    self.center = center;
}
- (CGFloat)kjwd_centerY {
    return self.center.y;
}
- (void)setKjwd_width:(CGFloat)kjwd_width {
    CGRect frame = self.frame;
    frame.size.width = kjwd_width;
    self.frame = frame;
}
- (void)setKjwd_height:(CGFloat)kjwd_height {
    CGRect frame = self.frame;
    frame.size.height = kjwd_height;
    self.frame = frame;
}
- (CGFloat)kjwd_height {
    return self.frame.size.height;
}
- (CGFloat)kjwd_width {
    return self.frame.size.width;
}
- (void)setKjwd_size:(CGSize)kjwd_size {
    CGRect frame = self.frame;
    frame.size = kjwd_size;
    self.frame = frame;
}
- (CGSize)kjwd_size {
    return self.frame.size;
}
- (void)setKjwd_origin:(CGPoint)kjwd_origin {
    CGRect frame = self.frame;
    frame.origin = kjwd_origin;
    self.frame = frame;
}
- (CGPoint)kjwd_origin {
    return self.frame.origin;
}


- (CGPoint)kjwd_centerPointToOtherView:(UIView *)otherView {
    
    CGFloat otherCenterX = otherView.center.x;
    CGFloat otherCenterY = otherView.center.y;
    CGFloat selfCenterX = self.center.x;
    CGFloat selfCenterY = self.center.y;
    
    CGPoint point = CGPointMake(selfCenterX + (otherCenterX - selfCenterX) * 0.5, selfCenterY + (otherCenterY - selfCenterY) * 0.5);
    return point;
}


/**
 * 便利构造器
 * 说明 创建并使用XIB文件初始视图控制器, 默认使用与控制器相同名字的XIB文件
 * 参数 nibName, XIB文件名
 */
+ (instancetype)kjwd_instanceUsingAutoNib {
    return [self kjwd_instanceWithNibName:NSStringFromClass(self.class)];
}
+ (instancetype)kjwd_instanceWithNibName:(NSString *)nibName {
    return [[[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil] firstObject];
}

- (UIImage *)kjwd_shotImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO,   0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //把当前的整个画面导入到context中，然后通过context输出UIImage，这样就可以把整个屏幕转化为图片
    [self.layer renderInContext:context];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - 从底部向上钻动画效果
- (void)masonryWithAnimateFromScreenButtomWithDuration:(NSTimeInterval)duration superView:(UIView *_Nullable)superView selfMasonryHeight:(CGFloat)height coverViewColor:(UIColor *_Nullable)coverViewColor animationCompletion:(void (^_Nullable)(BOOL))completionBlock triggerTapGestureRecognizerBlock:(void(^)(void(^_Nonnull disappearBlock)(void)))triggerTapGestureRecognizerBlock {
    
    self.triggerTapGestureRecognizerBlock = triggerTapGestureRecognizerBlock;
    
    if (superView == nil) {
        superView = [UIWindow kjwd_appdelegateWindow];
    }
    if (coverViewColor == nil) {
        coverViewColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }
    
    UIView *backGroundView = ({
        UIView *tmp = [[UIView alloc] init];
        tmp.backgroundColor = [UIColor clearColor];
        [superView addSubview:tmp];
        //添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(kjwd_tapBackGroundView)];
        [tmp addGestureRecognizer:tap];
        self.animateFromScreenButtomWithBackGroundView = tmp;
        tmp;
    });
    [superView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.height.equalTo(@(height));
        make.bottom.equalTo(superView.mas_bottom).offset(height);
    }];
    [backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(superView);
        make.bottom.equalTo(self.mas_top);
    }];
    
    [superView layoutIfNeeded];
    
    self.animateFromScreenButtomWithDuration = duration;
    self.animateFromScreenButtomWithHeight = height;
    
    
    [UIView animateWithDuration:duration animations:^{
        backGroundView.backgroundColor = coverViewColor ? coverViewColor : [UIColor blackColor];
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(superView.mas_bottom);
        }];
        [superView layoutIfNeeded];
    } completion:^(BOOL finished) {
        completionBlock ? completionBlock(finished) : nil;
    }];
}

// 这个是从底部向上点击事件
- (void)kjwd_tapBackGroundView {
    void (^disappearBlock)(void) = ^ {
        [self masonryWithAnimateFromScreenButtom_hiddenBackGroundView];
    };
    self.triggerTapGestureRecognizerBlock ? self.triggerTapGestureRecognizerBlock(disappearBlock) : nil;
}

/** 这个和上面的向上钻的效果是配合使用 */
- (void)masonryWithAnimateFromScreenButtom_hiddenBackGroundView {
    UIView *superView = self.superview;
    [UIView animateWithDuration:self.animateFromScreenButtomWithDuration animations:^{
        self.animateFromScreenButtomWithBackGroundView.backgroundColor = [UIColor clearColor];
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(superView.mas_bottom).offset(self.animateFromScreenButtomWithHeight);
        }];
        [superView layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.animateFromScreenButtomWithBackGroundView removeFromSuperview];
        [self removeFromSuperview];
    }];
}


- (void)kjwd_addGestureRecognizer:(UIGestureRecognizer *_Nonnull)ges handleBlock:(void(^)(UIGestureRecognizer *_Nonnull gestureRecognizer, UIView *_Nonnull currentView))handleBlock {
    [ges addTarget:self action:@selector(kjwd_gestureRecognizerAction:)];
    [self addGestureRecognizer:ges];
    self.gestureRecognizerBlock = handleBlock;
}
- (void)kjwd_gestureRecognizerAction:(UIGestureRecognizer *)sender {
    self.gestureRecognizerBlock ? self.gestureRecognizerBlock(sender, self) : nil;
}

// ----------------- runtime ------------

// animateFromScreenButtomWithHeight
- (void)setAnimateFromScreenButtomWithHeight:(CGFloat)animateFromScreenButtomWithHeight {
    objc_setAssociatedObject(self, @"animateFromScreenButtomWithHeight", @(animateFromScreenButtomWithHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)animateFromScreenButtomWithHeight {
    NSNumber *height = objc_getAssociatedObject(self, @"animateFromScreenButtomWithHeight");
    return height.floatValue;
}

// animateFromScreenButtomWithDuration
- (void)setAnimateFromScreenButtomWithDuration:(NSTimeInterval)animateFromScreenButtomWithDuration {
    // 对double类型的只能用 OBJC_ASSOCIATION_RETAIN_NONATOMIC, 不然会-[CFNumber retain]: message sent to deallocated instance
    
    objc_setAssociatedObject(self, @"animateFromScreenButtomWithDuration", @(animateFromScreenButtomWithDuration), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSTimeInterval)animateFromScreenButtomWithDuration {
    // 对double类型的只能用 OBJC_ASSOCIATION_RETAIN_NONATOMIC, 不然会-[CFNumber retain]: message sent to deallocated instance
    NSNumber *timeInterval = objc_getAssociatedObject(self, @"animateFromScreenButtomWithDuration");
    return timeInterval.doubleValue;
}


// animateFromScreenButtomWithBackGroundView
- (void)setAnimateFromScreenButtomWithBackGroundView:(UIView *)animateFromScreenButtomWithBackGroundView {
    if (animateFromScreenButtomWithBackGroundView == nil) {
        return;
    }
    CKJOriginalObject *originalObject = [[CKJOriginalObject alloc] initWithBlock:^{
        // 在对象dealloc的时候，需要把self的属性设置为nil
        objc_setAssociatedObject(self, @"animateFromScreenButtomWithBackGroundView", nil, OBJC_ASSOCIATION_ASSIGN);
    }];
    objc_setAssociatedObject(animateFromScreenButtomWithBackGroundView, (__bridge const void *)(originalObject.block), originalObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, @"animateFromScreenButtomWithBackGroundView", animateFromScreenButtomWithBackGroundView, OBJC_ASSOCIATION_ASSIGN);  //
}
- (UIView *)animateFromScreenButtomWithBackGroundView {
    UIView *temp = objc_getAssociatedObject(self, @"animateFromScreenButtomWithBackGroundView");
    return temp;
}

// triggerTapGestureRecognizerBlock
- (void)setTriggerTapGestureRecognizerBlock:(void (^)(void))triggerTapGestureRecognizerBlock {
    objc_setAssociatedObject(self, @"triggerTapGestureRecognizerBlock", triggerTapGestureRecognizerBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void (^)(void (^)(void)))triggerTapGestureRecognizerBlock {
    void (^block)(void(^)(void))  = objc_getAssociatedObject(self, @"triggerTapGestureRecognizerBlock");
    return block;
}



// 手势 gestureRecognizerBlock
- (void)setGestureRecognizerBlock:(void (^)(UIGestureRecognizer *, UIView *))gestureRecognizerBlock {
    objc_setAssociatedObject(self, @"gestureRecognizerBlock", gestureRecognizerBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void (^)(UIGestureRecognizer *, UIView *))gestureRecognizerBlock {
    void (^temp)(UIGestureRecognizer *, UIView *) = objc_getAssociatedObject(self, @"gestureRecognizerBlock");
    return temp;
}

@end

#pragma mark - -----------------UIButton-----------------


@interface UIButton (Property)

@property (copy, nonatomic, nullable) void (^kjCallBackBlock)(UIButton *sender);

@end


@implementation UIButton (WDYHFCategory)

- (void)kjwd_layoutButtonWithEdgeInsetsStyle:(GLButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space {
    /**
     *  知识点：titleEdgeInsets是title相对于其上下左右的inset，跟tableView的contentInset是类似的，
     *  如果只有title，那它上下左右都是相对于button的，image也是一样；
     *  如果同时有image和label，那这时候image的上左下是相对于button，右边是相对于label的；title的上右下是相对于button，左边是相对于image的。
     */
    
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.image.size.width;
    CGFloat imageHeight = self.imageView.image.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    
    switch (style) {
        case GLButtonEdgeInsetsStyleTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
        }
            break;
        case GLButtonEdgeInsetsStyleLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case GLButtonEdgeInsetsStyleBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case GLButtonEdgeInsetsStyleRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        }
            break;
        default:
            break;
    }
    
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}


- (void)kjwd_addTouchUpInsideForCallBack:(void(^_Nonnull)(UIButton * _Nonnull sender))callBack {
    [self kjwd_addControlEvents:UIControlEventTouchUpInside forCallBack:callBack];
}
- (void)kjwd_addControlEvents:(UIControlEvents)controlEvents forCallBack:(void (^)(UIButton * _Nonnull))callBack {
    if (callBack == nil) return;
    self.kjCallBackBlock = callBack;
    [self addTarget:self action:@selector(btnCallBack:) forControlEvents:controlEvents];
}
- (void)btnCallBack:(UIButton *)sender {
    self.kjCallBackBlock ? self.kjCallBackBlock(self) : nil;
}



- (void)setKjCallBackBlock:(void (^)(UIButton *))kjCallBackBlock {
    objc_setAssociatedObject(self, @"kjCallBackBlock", kjCallBackBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void (^)(UIButton *))kjCallBackBlock {
    void (^block)(UIButton *) = objc_getAssociatedObject(self, @"kjCallBackBlock");
    return block;
}


@end




#pragma mark - -----------------NSDate-----------------
@implementation NSDate (WDYHFCategory)

+ (nullable NSDate *)kjwd_returnDate:(NSString *_Nonnull)dateString withDateFormat:(NSString *_Nonnull)format {
    if (dateString == nil) {
        return nil;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}
+ (NSString *)kjwd_currentDateString {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = [NSString stringWithFormat:WDKJDefaultDateFormat];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

+ (nonnull NSString *)kjwd_returnYearMonthDayWithDateString:(NSString *_Nonnull)dateString withDateFormat:(NSString *_Nonnull)format {
    NSDate *date = [self kjwd_returnDate:dateString withDateFormat:format];
    NSString *str = [NSString stringWithFormat:@"%@-%@-%@", [date kjwd_dateYear], [date kjwd_dateMonth], [date kjwd_dateDay]];
    return str;
}



+ (nonnull NSString *)kjwd_currentYearMonthDayString; {
    NSString *str = [NSString stringWithFormat:@"%@-%@-%@", [NSDate kjwd_currentYear], [NSDate kjwd_currentMonth], [NSDate kjwd_currentDay]];
    return str;
}

+ (nonnull NSString *)kjwd_currentYear {
    NSString *dateString = [NSDate kjwd_currentDateString];
    return [dateString substringToIndex:4];
}
+ (nonnull NSString *)kjwd_currentMonth {
    NSString *dateString = [NSDate kjwd_currentDateString];
    return [NSString stringWithFormat:@"%@", [dateString substringWithRange:NSMakeRange(5, 2)]];
}
+ (nonnull NSString *)kjwd_currentDay {
    NSString *dateString = [NSDate kjwd_currentDateString];
    return [NSString stringWithFormat:@"%@", [dateString substringWithRange:NSMakeRange(8, 2)]];
}
+ (nonnull NSString *)kjwd_currentHour {
    NSString *dateString = [NSDate kjwd_currentDateString];
    return [NSString stringWithFormat:@"%@", [dateString substringWithRange:NSMakeRange(11, 2)]];
}
+ (nonnull NSString *)kjwd_currentMinute {
    NSString *dateString = [NSDate kjwd_currentDateString];
    return [NSString stringWithFormat:@"%@", [dateString substringWithRange:NSMakeRange(14, 2)]];
}
+ (nonnull NSString *)kjwd_currentSecond {
    NSString *dateString = [NSDate kjwd_currentDateString];
    return [NSString stringWithFormat:@"%@", [dateString substringWithRange:NSMakeRange(17, 2)]];
}
- (nonnull NSString *)kjwd_dateString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = [NSString stringWithFormat:WDKJDefaultDateFormat];
    NSString *dateStr = [formatter stringFromDate:self];
    return dateStr;
}
- (nonnull NSString *)kjwd_YearMonthDayString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = [NSString stringWithFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [formatter stringFromDate:self];
    return dateStr;
}
- (nonnull NSString *)kjwd_dateYear {
    return [[self kjwd_dateString] substringToIndex:4];
}
- (nonnull NSString *)kjwd_dateMonth {
    NSString *str = [self kjwd_dateString];
    return [NSString stringWithFormat:@"%@", [str substringWithRange:NSMakeRange(5, 2)]];
}
- (nonnull NSString *)kjwd_dateDay {
    NSString *str = [self kjwd_dateString];
    return [NSString stringWithFormat:@"%@", [str substringWithRange:NSMakeRange(8, 2)]];
}
- (nonnull NSString *)kjwd_dateHour {
    NSString *str = [self kjwd_dateString];
    return [NSString stringWithFormat:@"%@", [str substringWithRange:NSMakeRange(11, 2)]];
}
- (nonnull NSString *)kjwd_dateMinute {
    NSString *str = [self kjwd_dateString];
    return [NSString stringWithFormat:@"%@", [str substringWithRange:NSMakeRange(14, 2)]];
}
- (nonnull NSString *)kjwd_dateSecond {
    NSString *str = [self kjwd_dateString];
    return [NSString stringWithFormat:@"%@", [str substringWithRange:NSMakeRange(17, 2)]];
}
+ (nonnull NSString *)kjwd_currentDateStringWithFormatter:(nonnull NSString *)yyyyMMddHHmmss {
    return [[NSDate date] kjwd_dateStringWithFormatter:yyyyMMddHHmmss];
}
+ (nonnull NSString *)kjwd_dateStringFrom1970second:(double)second withFormatter:(NSString *)formatterStr {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formatterStr;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:second];
    return [formatter stringFromDate:date];
}
+ (nonnull NSString *)kjwd_dateStringFrom1970second:(double)second {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = [NSString stringWithFormat:WDKJDefaultDateFormat];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:second];
    return [date kjwd_dateString];
}
- (nonnull NSString *)kjwd_dateStringWithFormatter:(NSString *)formatterStr {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formatterStr;
    NSString *dateStr = [formatter stringFromDate:self];
    return dateStr;
}

+ (nonnull NSString *)kjwd_currentDateUnsignedString {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = [NSString stringWithFormat:@"yyyyMMddHHmmss"];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}
+ (nonnull NSString *)kjwd_currentDateUnsigned_Milliseconds {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = [NSString stringWithFormat:@"yyyyMMddHHmmssSSS"];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

/**
 *  判断是否是同一天
 */
- (BOOL)kjwd_isSameDayToDate2:(NSDate *)date2 {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlag = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *comp1 = [calendar components:unitFlag fromDate:self];
    NSDateComponents *comp2 = [calendar components:unitFlag fromDate:date2];
    return (([comp1 day] == [comp2 day]) && ([comp1 month] == [comp2 month]) && ([comp1 year] == [comp2 year]));
}


+ (NSDate *)kjwd_tomorrowDate {
    NSDate *date = [NSDate date];//当前时间
    NSDate *nextDay = [NSDate dateWithTimeInterval:24 * 60 * 60 sinceDate:date];//后一天
    return nextDay;
}
+ (NSDate *)kjwd_yesterdayDate {
    NSDate *date = [NSDate date];//当前时间
    NSDate *lastDay = [NSDate dateWithTimeInterval:-24 * 60 * 60 sinceDate:date];//前一天
    return lastDay;
}
+ (NSString *)kjwd_returnWordsForTime:(NSString *)str {
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    
    //得到与当前时间差
    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    //标准时间和北京时间差8个小时
    timeInterval = timeInterval - 8*60*60;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}

@end


#pragma mark - -----------------UIImage-----------------

@implementation UIImage (WDYHFCategory)

+ (nullable UIImage *)kjwd_imageNamed:(nonnull NSString *)name {
    if (name == nil || [name isEqualToString:@""]) {
        NSLog(@"kj_imageNamed 传入为nil 或为 空字符串 ---> (%@)", name);
        return nil;
    }
    return [self imageNamed:name];
}

// 通过给定颜色和大小生成图片
+ (UIImage *)kjwd_imageWithColor:(UIColor *)color size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddRect(context, CGRectMake(0, 0, size.width, size.height));
    //填充颜色为蓝色
    CGContextSetFillColorWithColor(context, color.CGColor);
    //在context上绘制
    CGContextFillPath(context);
    //把当前context的内容输出成一个UIImage图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //上下文栈pop出创建的context
    UIGraphicsEndImageContext();
    return image;
}
+ (UIImage *)kjwd_QRCodeWithContent:(NSString *)content size:(CGSize)size {
    if (content == nil) {
        return [[UIImage alloc] init];
    }
    
    UIImage *codeImage = nil;
    
    NSData *stringData = [content dataUsingEncoding: NSUTF8StringEncoding];
    
    //生成
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    
    UIColor *onColor = [UIColor blackColor];
    UIColor *offColor = [UIColor whiteColor];
    
    //上色
    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"
                                       keysAndValues:
                             @"inputImage",qrFilter.outputImage,
                             @"inputColor0",[CIColor colorWithCGColor:onColor.CGColor],
                             @"inputColor1",[CIColor colorWithCGColor:offColor.CGColor],
                             nil];
    
    CIImage *qrImage = colorFilter.outputImage;
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRelease(cgImage);
    
    return codeImage;
}

@end


#pragma mark - -----------------NSString-----------------

@implementation NSString (WDYHFCategory)

//邮箱
- (BOOL)kjwd_validateEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

//手机号码验证
- (BOOL)kjwd_validateMobile {
    NSString *phone = @"^(1)\\d{10}$";
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phone];
    return [regextestcm evaluateWithObject:self] == YES;
}

//车牌号验证
- (BOOL)kjwd_validateCarNo {
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:self];
}

//车型
- (BOOL)kjwd_validateCarType {
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:self];
}

//用户名
- (BOOL)kjwd_validateUserName {
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:self];
    return B;
}

/**
 * 密码
 * 说明 密码验证数字与字母组合, 默认6-12位
 * 参数 min, 最少位
 * 参数 max, 最大位
 */
- (BOOL)kjwd_validatePassword {
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,12}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:self];
}
- (BOOL)kjwd_validatePasswordWithMin:(unsigned int)min max:(unsigned int)max {
    NSString *passWordRegex = [NSString stringWithFormat:@"^[a-zA-Z0-9]{%u,%u}+$", min, max];
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:self];
}

/**
 * 昵称
 * 说明 以中文开头, 默认4-8位
 * 参数 min, 最少位
 * 参数 max, 最大位
 */
- (BOOL)kjwd_validateNicknameWithMin:(unsigned int)min max:(unsigned int)max {
    NSString *nicknameRegex = [NSString stringWithFormat:@"^[\u4e00-\u9fa5]{%u,%u}$", min, max];
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:self];
}

//身份证号
- (BOOL)kjwd_validateIdentityCard {
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}

/**
 * 验证码
 * 说明 纯数字验证码, 默认6位
 * 参数 size, 位数
 */
- (BOOL)kjwd_validateVerifyCode {
    NSString *verifyCodeRegex = @"^[0-9]{6}$";
    NSPredicate *verifyPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",verifyCodeRegex];
    return [verifyPredicate evaluateWithObject:self];
}
- (BOOL)kjwd_validateVerifyCodeWithSize:(unsigned int)size {
    NSString *verifyCodeRegex = [NSString stringWithFormat:@"^[0-9]{%d}$", size];
    NSPredicate *verifyPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",verifyCodeRegex];
    return [verifyPredicate evaluateWithObject:self];
}


/** 是否全是大写或数字 */
- (BOOL)kjwd_inputShouldUpperAndNumber {
    if (self.length == 0) return NO;
    NSString *regex =@"[A-Z0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:self];
}

/** 是否全是字母或数字 */
- (BOOL)kjwd_isCharAndNumber {
    if (self.length == 0) return NO;
    NSString *regex =@"[A-Za-z0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:self];
}


/** 是否包含大写字母 */
- (BOOL)kjwd_containsUppercase {
    
    // 限制 不能输入的特殊字符串
    NSCharacterSet *cs = nil;
    
    cs = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZ"] invertedSet];
    
    NSString *filtered = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    BOOL basicTest = [self isEqualToString:filtered];
    return basicTest;
}
/** 是否包含小写字母 */
- (BOOL)kjwd_containsLowercase {
    
    
    // 限制 不能输入的特殊字符串
    NSCharacterSet *cs = nil;
    
    cs = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyz"] invertedSet];
    
    NSString *filtered = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    BOOL basicTest = [self isEqualToString:filtered];
    return basicTest;
}
/** 是否包含数字 */
- (BOOL)kjwd_containsNumber {
    
    
    // 限制 不能输入的特殊字符串
    NSCharacterSet *cs = nil;
    
    cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    
    NSString *filtered = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    BOOL basicTest = [self isEqualToString:filtered];
    return basicTest;
}

- (nullable NSString *)kjwd_idCardToAsterisk {
    if (self.length != 18) {
//        NSLog(@"身份证号必须是18位!");
        return nil;
    }
    return [self stringByReplacingCharactersInRange:NSMakeRange(10, 4) withString:@"****"];
}



/**
 * MD5加密
 * 说明 MD5是消息摘要算法
 * 返回 16位字符串类型的 MD5 hash值
 */
- (NSString *)kjwd_MD5 {
    const char *cStr = self.UTF8String;
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (unsigned int)strlen(cStr), result);
    NSMutableString *hash = [NSMutableString string];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; ++ i){
        [hash appendFormat:@"%02X",result[i]];
    }
    return [hash uppercaseString];
}

// 过滤首尾的空格和换行
- (NSString *)kjwd_trimWhiteAndNewline {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
// 过滤首尾的空格
- (NSString *)kjwd_trimWhite {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

// 过滤所有的空格和换行
- (NSString *)kjwd_trimAllWhiteAndNewline {
    NSString *result = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return [result stringByReplacingOccurrencesOfString:@"\r" withString:@""];
}
// 过滤所有的空格
- (NSString *)kjwd_trimAllWhite {
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}


+ (NSString *)kjwd_uuidString {
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    return [uuid lowercaseString];
}


/**
 *  这个在时间很短时， 得到多个随机数， 可能得到的随机数是相同的
 */
+ (nonnull NSString *)kjwd_returnGetArc4randomWithNum:(NSUInteger)num type:(KJWDArc4randomType)type {
    NSString *sourceStr = nil;
    switch (type) {
        case KJWDArc4randomType_Number:
            sourceStr = @"0123456789";
            break;
        case KJWDArc4randomType_Number_Up_Low_Char:
            sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
            break;
        case KJWDArc4randomType_Up_Char:
            sourceStr = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            break;
        case KJWDArc4randomType_Low_Char:
            sourceStr = @"abcdefghijklmnopqrstuvwxyz";
            break;
        case KJWDArc4randomType_Number_Low_Char:
            sourceStr = @"0123456789abcdefghijklmnopqrstuvwxyz";
            break;
        case KJWDArc4randomType_Number_Up_Char:
            sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            break;
        default:
            break;
    }
    
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < num; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

+ (nonnull NSString *)kjwd_returnArc4randomWithNum:(NSUInteger)num type:(KJWDArc4randomType)type {
    
    NSString *sourceStr = nil;
    switch (type) {
        case KJWDArc4randomType_Number:
            sourceStr = @"0123456789";
            break;
        case KJWDArc4randomType_Number_Up_Low_Char:
            sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
            break;
        case KJWDArc4randomType_Up_Char:
            sourceStr = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            break;
        case KJWDArc4randomType_Low_Char:
            sourceStr = @"abcdefghijklmnopqrstuvwxyz";
            break;
        case KJWDArc4randomType_Number_Low_Char:
            sourceStr = @"0123456789abcdefghijklmnopqrstuvwxyz";
            break;
        case KJWDArc4randomType_Number_Up_Char:
            sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            break;
        default:
            break;
    }
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    for (int i = 0; i < num; i++)
    {
        unsigned index = arc4random() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}


+ (NSString *)kjwd_arrayStringWithStringArray:(NSArray *)array {
    NSMutableString *string = [NSMutableString string];
    for (int i = 0; i < array.count; i++) {
        NSString *str = array[i];
        if (i != 0) {
            [string appendString:[NSString stringWithFormat:@", %@", str]];
        } else {
            [string appendString:[NSString stringWithFormat:@"%@", str]];
        }
    }
    return string;
}

- (nonnull NSDictionary *)kjwd_convertToDic {
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    if (jsonData == nil) return @{};
    
    NSError *err = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return @{};
    }
    return dic;
}


#pragma mark - 字符串操作
- (NSString *)kjwd_substringFromIndex:(NSUInteger)from {
    if ([self isKindOfClass:[NSString class]] == NO) {
        NSLog(@"%s ---> %@ 不是NSString类型", __func__, self);
        return nil;
    }
    if (from > self.length || from < 0) {
        NSLog(@"%s ---> %@ 长度%lu 下标%lu越界", __func__, self, self.length, from);
        return nil;
    }
    return [self substringFromIndex:from];
}
- (NSString *)kjwd_substringToIndex:(NSUInteger)to {
    if ([self isKindOfClass:[NSString class]] == NO) {
        NSLog(@"%s ---> %@ 不是NSString类型", __func__, self);
        return nil;
    }
    if (to > self.length || to < 0) {
        NSLog(@"%s ---> %@ 长度%lu 下标%lu越界", __func__, self, self.length, to);
        return nil;
    }
    return [self substringToIndex:to];
}


- (NSString *)kjwd_substringWithRange:(NSRange)range {
    if ([self isKindOfClass:[NSString class]] == NO) {
        NSLog(@"%s ---> %@ 不是NSString类型", __func__, self);
        return nil;
    }
    NSUInteger location = range.location;
    NSUInteger length = range.length;
    if (location > self.length || location < 0 || length > self.length || length < 0) {
        NSLog(@"%s ---> range的location 或 length 不符合规范 %@,  字符串(%@)长度是%lu", __func__, NSStringFromRange(range), self, self.length);
        return nil;
    }
    if (location + length > self.length) {
        NSLog(@"%s ---> %@ 越界,  字符串(%@)长度是%lu", __func__, NSStringFromRange(range), self, self.length);
        return nil;
    }
    return [self substringWithRange:range];
}
- (NSString *)kjwd_stringByAppendingString:(NSString *)aString {
    if ([self isKindOfClass:[NSString class]] == NO) {
        NSLog(@"%s ---> %@ 不是NSString类型", __func__, self);
        return nil;
    }
    if ([aString isKindOfClass:[NSString class]] == NO || aString == nil) {
        NSLog(@"不能拼接一个空字符串 或者 非NSString类型 %@ ", aString);
        return self;
    }
    return [self stringByAppendingString:aString];
}

@end


@implementation NSAttributedString (WDYHFCategory)

- (void)kjwd_setLineSpace:(CGFloat)kLineSpace {
    NSString *labelText = self.string;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:kLineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
//    self.attributedText = attributedString;
    
    
    
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.string];
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    [paragraphStyle setLineSpacing:kLineSpace];
//    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
//    self.attributedText = attributedString;
}
- (void)kjwd_setWordSpace:(CGFloat)kWordSpace {
    
}
- (void)kjwd_setLineSpace:(CGFloat)kLineSpace wordSpace:(CGFloat)kWordSpace {
    
}


@end

@implementation CALayer (WDYHFCategory)


- (void)kjwd_pauseAnimation {
    if (self.speed == 0.0) {
        return;
    }
    CFTimeInterval pausedTime = [self convertTime:CACurrentMediaTime() fromLayer:nil];
    self.speed = 0.0;
    self.timeOffset = pausedTime;
}

- (void)kjwd_goonAnimation {
    if (self.speed == 1.0) {
        return;
    }
    CFTimeInterval pausedTime = [self timeOffset];
    self.speed = 1.0;
    self.timeOffset = 0.0;
    self.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.beginTime = timeSincePause;
}

@end


@interface CKJCountDownButton(){
    NSInteger _second;
    NSUInteger _totalSecond;
    
    NSTimer *_timer;
    NSDate *_startDate;
    
    CountDownChanging _countDownChanging;
    CountDownFinished _countDownFinished;
    TouchedCountDownButtonHandler _touchedCountDownButtonHandler;
}
@end

@implementation CKJCountDownButton
#pragma -mark touche action
- (void)countDownButtonHandler:(TouchedCountDownButtonHandler)touchedCountDownButtonHandler{
    _touchedCountDownButtonHandler = [touchedCountDownButtonHandler copy];
    [self addTarget:self action:@selector(touched:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)touched:(CKJCountDownButton*)sender{
    if (_touchedCountDownButtonHandler) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _touchedCountDownButtonHandler(sender,sender.tag);
        });
    }
}

#pragma -mark count down method
- (void)startCountDownWithSecond:(NSUInteger)totalSecond
{
    _totalSecond = totalSecond;
    _second = totalSecond;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStart:) userInfo:nil repeats:YES];
    _startDate = [NSDate date];
    _timer.fireDate = [NSDate distantPast];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}
- (void)timerStart:(NSTimer *)theTimer {
    double deltaTime = [[NSDate date] timeIntervalSinceDate:_startDate];
    
    _second = _totalSecond - (NSInteger)(deltaTime+0.5) ;

    if (_second < 0.0)
    {
        [self stopCountDown];
    }
    else
    {
        if (_countDownChanging)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *title = _countDownChanging(self,_second);
                [self setTitle:title forState:UIControlStateNormal];
                [self setTitle:title forState:UIControlStateDisabled];
            });
        }
        else
        {
            NSString *title = [NSString stringWithFormat:@"%zd秒",_second];
            [self setTitle:title forState:UIControlStateNormal];
            [self setTitle:title forState:UIControlStateDisabled];
            
        }
    }
}

- (void)stopCountDown{
    if (_timer) {
        if ([_timer respondsToSelector:@selector(isValid)])
        {
            if ([_timer isValid])
            {
                [_timer invalidate];
                _second = _totalSecond;
                if (_countDownFinished)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSString *title = _countDownFinished(self,_totalSecond);
                        [self setTitle:title forState:UIControlStateNormal];
                        [self setTitle:title forState:UIControlStateDisabled];
                    });
                }
                else
                {
                    [self setTitle:@"重新获取" forState:UIControlStateNormal];
                    [self setTitle:@"重新获取" forState:UIControlStateDisabled];
                    
                }
            }
        }
    }
}
#pragma -mark block
- (void)countDownChanging:(CountDownChanging)countDownChanging{
    _countDownChanging = [countDownChanging copy];
}
- (void)countDownFinished:(CountDownFinished)countDownFinished{
    _countDownFinished = [countDownFinished copy];
}
@end

@implementation CKJFlagView

@end


#pragma mark - -----------------其他部分-----------------
@implementation CKJOriginalObject

- (instancetype)initWithBlock:(void (^)(void))block {
    self = [super init];
    if (self) {
        self.block = block;
    }
    return self;
}
- (void)dealloc {
    self.block ? self.block() : nil;
}

@end

@implementation CKJAPPHelper


+ (NSString *)currentVersion {
    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    return appVersion;
}

+ (CGFloat)screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}
+ (CGFloat)screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}


@end
