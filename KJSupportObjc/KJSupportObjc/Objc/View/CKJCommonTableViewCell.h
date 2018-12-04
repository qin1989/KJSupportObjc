//
//  CKJCommonTableViewCell.h
//  HKGoodColor
//
//  Created by chenkaijie on 2017/12/21.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CKJCommonCellModel.h"

@class CKJCommonCellModel, CKJCommonHeaderFooterModel, CKJCommonTableViewTool, CKJSimpleTableView;


@interface CKJCommonTableViewCell <E : CKJCommonCellModel *> : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier configDic:(NSDictionary *)configDic;


@property (copy, nonatomic, readonly) NSDictionary *configDic;

@property (nonatomic, strong, nonnull) E cellModel;
@property (nonatomic, weak) CKJSimpleTableView *simpleTableView;

@property (assign, nonatomic) NSInteger section;
@property (assign, nonatomic) NSInteger row;

@property (nonatomic, strong, nonnull) UIView *bgV;


/**
 当前分区Cell模型数组
 */
- (NSArray <CKJCommonCellModel *>*)currentSectionCellModelArray;

/**
 *  此方法留着给子类重写，通常是拿到这几个参数 给子类cell设置UI数据
 */
- (void)setupData:(E)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *_Nonnull)indexPath tableView:(CKJSimpleTableView *_Nonnull)tableView;

/**
 设置子视图
 */
- (void)setupSubViews;


@end