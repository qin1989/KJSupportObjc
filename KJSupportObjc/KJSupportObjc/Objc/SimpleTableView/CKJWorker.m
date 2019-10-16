//
//  CKJWorker.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/4/16.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJWorker.h"
#import "NSObject+WDYHFCategory.h"
#import "CKJCommonTableViewCell.h"


NSString *_Nonnull const cellKEY = @"cellKEY";
NSString *_Nonnull const isRegisterNibKEY = @"isRegisterNibKEY";
NSString *_Nonnull const configDicKEY_ConfigModel = @"configDicKEY_ConfigModel";
NSString *_Nonnull const headerFooterKey = @"headerFooterKey";



NSString *_Nonnull const cNormalAttTitle = @"cNormalAttTitle";
NSString *_Nonnull const cNormalImage = @"cNormalImage";
NSString *_Nonnull const cNormalBgImage = @"cNormalBgImage";

NSString *_Nonnull const cSelectedAttTitle = @"cSelectedAttTitle";
NSString *_Nonnull const cSelectedImage = @"cSelectedImage";
NSString *_Nonnull const cSelectedBgImage = @"cSelectedBgImage";


NSString *_Nonnull const cHighlightedAttTitle = @"cHighlightedAttTitle";
/** 高亮时候的image */
NSString *_Nonnull const cHighlightedImage = @"cHighlightedImage";
/** 高亮时候的bgImage */
NSString *_Nonnull const cHighlightedBgImage = @"cHighlightedBgImage";


NSString *_Nonnull const cBorderWidth = @"cBorderWidth";
NSString *_Nonnull const cBorderColor = @"cBorderColor";
NSString *_Nonnull const cCornerRadius = @"cCornerRadius";



@implementation CKJWorker

+ (NSAttributedString *_Nonnull)changeOriginAtt:(nullable NSAttributedString *)origin text:(nullable NSString *)text {
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithAttributedString:WDKJ_ConfirmAttString(origin)];
    [att replaceCharactersInRange:NSMakeRange(0, att.length) withString:WDKJ_ConfirmString(text)];
    return att;
}

+ (NSBundle *_Nonnull)kjbundle {
    NSBundle *mainBundle = [NSBundle bundleForClass:[CKJCommonTableViewCell class]];
    
    NSBundle *resourcesBundle = [NSBundle bundleWithPath:[mainBundle pathForResource:@"KJSupportObjc" ofType:@"bundle"]];
    
    if (resourcesBundle == nil) {
        resourcesBundle = mainBundle;
    }
    return resourcesBundle;
}


@end


@implementation CKJCommonItemData
@end

@implementation CKJCommonItemView
@end


@interface CKJBtnItemData ()

@end

@implementation CKJBtnItemData


- (instancetype)init {
    if (self = [super init]) {
        self.enabled = YES;
    }
    return self;
}


+ (NSArray <__kindof CKJBtnItemData *>*_Nonnull)returnItemsWithDics:(NSArray <NSDictionary *>*_Nullable)dics detailSetting:(void(^_Nullable)(__kindof CKJBtnItemData *__weak _Nonnull itemData, NSUInteger index))detailSetting {
    
    NSMutableArray *result = [NSMutableArray array];
    for (int i = 0; i < dics.count; i++) {
        NSDictionary *dic = dics[i];
        CKJBtnItemData *m = [[self alloc] init];
        
        
        m.normalAttTitle = dic[cNormalAttTitle];
        m.normalImage = dic[cNormalImage];
        m.normalBgImage = dic[cNormalBgImage];
        
        m.selectedAttTitle = dic[cSelectedAttTitle];
        m.selectedImage = dic[cSelectedImage];
        m.selectedBgImage = dic[cSelectedBgImage];
        
        m.highlightedAttTitle = dic[cHighlightedAttTitle];
        m.highlightedImage = dic[cHighlightedImage];
        m.highlightedBgImage = dic[cHighlightedBgImage];
        
        m.borderWidth = WDKJ_ConfirmNumber(dic[cBorderWidth]).floatValue;
        m.borderColor = dic[cBorderColor];
        m.cornerRadius = WDKJ_ConfirmNumber(dic[cCornerRadius]).floatValue;
        
        if (detailSetting) {
            detailSetting(m, i);
        }
        
        [result addObject:m];
    }
    return result;
}

- (void)setNormalAttTitle:(NSAttributedString *)normalAttTitle {
    if (WDKJ_IsEmpty_AttributedStr(normalAttTitle)) {
        _normalAttTitle = nil;
    } else {
        _normalAttTitle = normalAttTitle;
    }
}
- (void)setSelectedAttTitle:(NSAttributedString *)selectedAttTitle {
    if (WDKJ_IsEmpty_AttributedStr(selectedAttTitle)) {
        _selectedAttTitle = nil;
    } else {
        _selectedAttTitle = selectedAttTitle;
    }
}
- (void)setHighlightedAttTitle:(NSAttributedString *)highlightedAttTitle {
    if (WDKJ_IsEmpty_AttributedStr(highlightedAttTitle)) {
        _highlightedAttTitle = nil;
    } else {
        _highlightedAttTitle = highlightedAttTitle;
    }
}



@end




@implementation NSArray (CKJSimpleTableView)



/**
 网络获取Models模型数组 转成 CellModels数组
 
 @param ResponseDataModels 网络模型数组
 @param CellModelClass CellModelClass类（必须是CKJCommonCellModel子类）
 @param callBack 可以详细设置CellModel数据， 比如高度或者其他
 */
+ (instancetype _Nonnull)kjwd_arrayWithResponseDataModels:(NSArray * _Nullable)ResponseDataModels CellModelClass:(Class _Nonnull)CellModelClass callBack:(void(^_Nullable )(id _Nonnull currentModel))callBack {
    
    ResponseDataModels = WDKJ_ConfirmArray(ResponseDataModels);
    
    NSMutableArray *result = [NSMutableArray array];
    
    [ResponseDataModels enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CKJCommonCellModel *cellModel = [[CellModelClass alloc] init];
        if ([cellModel isKindOfClass:[CKJCommonCellModel class]] == NO) {
            return;
        }
        if (callBack) {
            callBack(cellModel);
        }
        cellModel.networkData = obj;
        [result addObject:cellModel];
    }];
    return result;
}



@end
