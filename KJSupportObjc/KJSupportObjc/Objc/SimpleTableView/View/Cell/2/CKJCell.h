//
//  CKJCell.h
//  RAC空项目
//
//  Created by chenkaijie on 2018/1/19.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//


#import "CKJCommonTableViewCell.h"
#import "NSObject+WDYHFCategory.h"
#import "CKJBaseModel.h"

#import "CKJGeneralCell.h"

@class CKJLeftView, CKJTopBottomView, CKJExtraView, CKJRightView;
@class CKJCellModel, CKJCell, MASConstraintMaker, CKJBtn5Model, CKJBtn7Model;

typedef void(^CKJDidClickbtn5Handle)(CKJCell *_Nonnull cell, CKJBtn5Model *_Nonnull btn5Model);

typedef void(^CKJDidClickbtn7Handle)(CKJCell *_Nonnull cell, CKJBtn7Model *_Nonnull btn7Model);


typedef void(^CKJSwitch6Block)(BOOL switchOn, CKJCellModel *_Nonnull cellModel,  UISwitch *_Nonnull senderSwitch);

typedef void(^CKJCellModelRowBlock)(__kindof CKJCellModel *_Nonnull m);






@interface CKJBaseBtnModel : CKJBaseModel

@property (copy, nonatomic, nullable) NSAttributedString *normalAttributedTitle;
@property (copy, nonatomic, nullable) NSAttributedString *selectedAttributedTitle;

/** 改变Normal状态下的文字 */
- (void)changeNormalText:(nullable NSString *)text;

/** 改变Normal状态下的文字 */
- (void)changeSelectedText:(nullable NSString *)text;



@property (strong, nonatomic, nullable) UIImage *normalBackgroundImage;
@property (strong, nonatomic, nullable) UIImage *selectedBackgroundImage;

@property (strong, nonatomic, nullable) UIImage *normalImage;
@property (strong, nonatomic, nullable) UIImage *selectedImage;

@property (assign, nonatomic) BOOL btnHidden;

/** 是否选中 */
@property (assign, nonatomic) BOOL selected;
/** 是否开启用户交互，默认开启 */
@property (assign, nonatomic) BOOL userInteractionEnabled;

@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGFloat cornerRadius;
@property (strong, nonatomic, nullable) UIColor *borderColor;
@property (assign, nonatomic) CGFloat borderWidth;


@property (assign, nonatomic) CGFloat rightMargin;
@property (assign, nonatomic) CGFloat centerYOffset;



/**
 对UIButton的图片和文字 进行排布回调
 */
@property (copy, nonatomic, nullable) void (^layoutButton)(UIButton *_Nonnull btn);


@end





@interface CKJBtn5Model : CKJBaseBtnModel

+ (nonnull instancetype)btn5ModelWithSize:(CGSize)size normalImage:(nullable UIImage *)normalImage rightMargin:(CGFloat)rightMargin detailSettingBlock:(void(^_Nullable)(CKJBtn5Model *_Nonnull sender))detailSettingBlock didClickBtn7Handle:(nullable CKJDidClickbtn5Handle)didClickBtn7Handle;


@end





@interface CKJView5Model : CKJBaseModel

@property (assign, nonatomic)        NSTextAlignment    topLabelTextAlignment;
@property (assign, nonatomic)        NSTextAlignment    bottomLabelTextAlignment;


@property (copy, nonatomic, nullable) NSAttributedString *topText;
@property (copy, nonatomic, nullable) NSAttributedString *bottomText;


/** 改变顶部文字 */
- (void)changeTopText:(nullable NSString *)text;
/** 改变底部文字 */
- (void)changeBottomText:(nullable NSString *)text;

/**
 该值的 bottom设置的是 topLabel 距离 Cell.centerY的距离
 */
@property (assign, nonatomic) UIEdgeInsets topLabelEdge;
/**
 该值的 top设置的是 bottomLabel 距离 Cell.centerY的距离
 */
@property (assign, nonatomic) UIEdgeInsets bottomLabelEdge;



/**
 推荐使用这个，这个最常用

 @param centerMarign      上下Label之间的间距
 @param topBottomMargin   上Label 距离父视图之间的间距
 @param leftMargin        上下Label 距离父视图Left边的间距
 @param rightMargin       上下Label 距离父视图Right边的间距
 */
+ (nonnull instancetype)view5ModelWithTopAttributedText:(nullable NSAttributedString *)topText bottomAttributedText:(nullable NSAttributedString *)bottomText centerMarign:(CGFloat)centerMarign topBottomMargin:(CGFloat)topBottomMargin leftMargin:(CGFloat)leftMargin rightMargin:(CGFloat)rightMargin;

+ (nonnull instancetype)view5ModelWithTopAttributedText:(nullable NSAttributedString *)topText bottomAttributedText:(nullable NSAttributedString *)bottomText topEdge:(UIEdgeInsets)topEdge bottomEdge:(UIEdgeInsets)bottomEdge;

@end





@interface CKJSwitch6Model : CKJBaseModel

@property (assign, nonatomic) BOOL switchOn;

@property (assign, nonatomic) CGFloat left;
@property (assign, nonatomic) CGFloat top;
@property (assign, nonatomic) CGFloat right;
@property (assign, nonatomic) CGFloat bottom;
@property (copy, nonatomic, nonnull) CKJSwitch6Block swicthBlock;

+ (nonnull instancetype)switch6ModelWithSwitchOn:(BOOL)switchOn left:(CGFloat)left top:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom callBack:(nonnull CKJSwitch6Block)callBack;

@end






@interface CKJBtn7Model : CKJBaseBtnModel

/**
 暂时按钮的所有状态size都一样
 */
+ (nonnull instancetype)btn7ModelWithSize:(CGSize)size normalImage:(nullable UIImage *)normalImage rightMargin:(CGFloat)rightMargin detailSettingBlock:(void(^_Nullable)(CKJBtn7Model *_Nonnull sender))detailSettingBlock didClickBtn7Handle:(nullable CKJDidClickbtn7Handle)didClickBtn7Handle;

@property (copy, nonatomic, nullable) CKJDidClickbtn7Handle didClickBtn7Handle;


@end


@interface CKJCellModel : CKJGeneralCellModel

@property (strong, nonatomic, nullable) CKJSubTitle4Model *subTitle4Model;

@property (strong, nonatomic, nullable) CKJBtn5Model *btn5Model;

@property (strong, nonatomic, nullable) CKJView5Model *view5Model;

/** 如果不设置此值，那么就是隐藏Switch */
@property (strong, nonatomic, nullable) CKJSwitch6Model *switch6Model;


@property (strong, nonatomic, nullable) CKJBtn7Model *btn7Model;



+ (nonnull instancetype)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJCellModelRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJCellModelRowBlock)didSelectRowBlock;


@end




@interface CKJCell : CKJGeneralCell

@property (nonnull, strong, nonatomic, readonly) UILabel *subTitle4;

@property (nonnull, strong, nonatomic, readonly) UIButton *btn5;

@property (nonnull, strong, nonatomic, readonly) CKJTopBottomView *view5;
@property (nonnull, strong, nonatomic, readonly) UILabel *view5_topLabel;
@property (nonnull, strong, nonatomic, readonly) UILabel *view5_bottomLabel;

@property (nonnull, strong, nonatomic, readonly) UIView *kjSwitch6;
@property (nonnull, strong, nonatomic, readonly) UIButton *btn7;


- (UIView *_Nonnull)tfWrapperView;

@end
