//
//  CKJInputCell.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/5/13.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJCell.h"
#import "CKJChooseHelper.h"

typedef void(^CKJTriggerCodeBlock)(NSUInteger seconds);


//typedef NS_ENUM(NSUInteger, RJInputStyle) {
//    RJInputStyle_Normal,
//    RJInputStyle_Choose
//};


NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN NSInteger const kInput_Name;
UIKIT_EXTERN NSInteger const kInput_Sex;
UIKIT_EXTERN NSInteger const kInput_Phone;
UIKIT_EXTERN NSInteger const kInput_VerityCode;
UIKIT_EXTERN NSInteger const kInput_idCardType;
UIKIT_EXTERN NSInteger const kInput_idCardNumber;
UIKIT_EXTERN NSInteger const kInput_Birthday;
UIKIT_EXTERN NSInteger const kInput_Relationship;
UIKIT_EXTERN NSInteger const kInput_Address;
UIKIT_EXTERN NSInteger const kInput_Email;


@class CKJInputCellModel, CKJTFModel;


typedef void(^CKJInputCellModelRowBlock)(__kindof CKJInputCellModel *_Nonnull m);



@interface CKJTFModel : CKJBaseModel

/**
 右边的距离, 默认值15
 */
@property (assign, nonatomic) CGFloat rightMargin;

@property (assign, nonatomic) BOOL userInteractionEnabled;

@property(nonatomic)        UITextBorderStyle       borderStyle;
@property(nonatomic)        UIKeyboardType keyboardType;

//@property(nullable, copy, nonatomic) NSString *text;
@property(nullable, nonatomic,copy) NSAttributedString *attributedText;
- (void)_setText:(NSString *_Nullable)text;


@property(nullable, nonatomic,copy) NSAttributedString *attributedPlaceholder;
- (void)_setPlaceholder:(NSString *_Nullable)placeholder;

@property(nonatomic) NSTextAlignment textAlignment;

+ (nonnull instancetype)modelWithDetailSettingBlock:(void(^_Nullable)(__kindof CKJTFModel *_Nonnull m))detailSettingBlock;

//+ (nonnull instancetype)modelWithText:(NSString *_Nullable)text placeholder:(NSString *_Nullable)placeholder userInteractionEnabled:(BOOL)enable detailSetting:(void(^_Nullable)(__kindof CKJTFModel *_Nonnull m))detailSettingBlock;


- (void)_afterSecondsListenTextChange:(CGFloat)seconds callBack:(void(^_Nullable)(NSAttributedString *_Nullable attText))callBack;


/// 检验手机号
+ (BOOL)verityPhone:(NSString *)phone;

@end



@interface CKJGetCodeModel : CKJBaseModel


/**
 右边的距离, 默认值15
 */
@property (assign, nonatomic) CGFloat rightMargin;

/**
 获取验证码Btn的宽度, 有默认值
 */
@property (assign, nonatomic) CGFloat codeBtnWidth;


/**
 秒数正在减少的 文字, 有默认值
 */
@property (copy, nonatomic) NSString *(^countDownChanging)(CKJCountDownButton *countDownButton, NSUInteger second);

/**
 秒数正在减少的 文字, 有默认值
 */
@property (copy, nonatomic) NSString *(^countDownFinished)(CKJCountDownButton *countDownButton, NSUInteger second);

/**
 点击了验证码Block
 */
@property (copy, nonatomic, nonnull) void (^clickCodeBlock)(_Nonnull CKJTriggerCodeBlock triggerCodeBlock);


+ (nonnull instancetype)modelWithClickCodeBtnBlock:(void (^)(_Nonnull CKJTriggerCodeBlock triggerCodeBlock))clickCodeBlock detailSettingBlock:(void(^)(__kindof CKJGetCodeModel *_Nonnull m))detailSettingBlock;


@end



@interface CKJInputCellModel : CKJCellModel

@property (strong, nonatomic, nullable) CKJStringChooseHelper *stringChoose;
@property (strong, nonatomic, nullable) CKJDateChooseHelper *dateChoose;

- (void)updateTFModel:(void(^_Nullable)(CKJTFModel *_Nonnull tfModel))block;

@property (strong, nonatomic, nonnull) CKJTFModel *tfModel;

@property (strong, nonatomic, nullable) CKJGetCodeModel *getCodeModel;

/// 是否  必须输入
@property (assign, nonatomic) BOOL required;

- (NSString *_Nullable)tfText;

+ (nonnull instancetype)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJInputCellModelRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJInputCellModelRowBlock)didSelectRowBlock;


@end


@interface CKJInputCell : CKJCell



@end




@interface CKJInputAddition : CKJBaseModel

+ (nonnull UIImage *)systemStarImageWithSize:(CGSize)size;

@end


NS_ASSUME_NONNULL_END