//
//  MyFamilyViewController.m
//  KJSupportObjc
//
//  Created by chenkaijie on 2018/6/22.
//  Copyright © 2018年 uback. All rights reserved.
//

#import "MyFamilyViewController.h"
#import "MyFamilyCell.h"
#import "MyFamilyCellModel.h"
#import <Masonry/Masonry.h>
#import "MyFamilyLastCell.h"

@interface MyFamilyViewController ()

//@property (strong, nonatomic) UILabel *headerLab;

@end

@implementation MyFamilyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(100, 120);
    // 一个分区内，两个cell之间的最小间隔
    layout.minimumLineSpacing = 10;
    // 一个分区内，两个cell之间的最小间隔
    layout.minimumInteritemSpacing = 10;
    self.simpleCollectionView.collectionViewLayout = layout;
    
    
    NSMutableArray <CommonCollectionViewSectionModel *>*sections = [NSMutableArray array];
    
    {   // 分区1
        CommonCollectionViewSectionModel *section = [CommonCollectionViewSectionModel new];
        
        MyFamilyCellModel *model1 = [MyFamilyCellModel new];
        model1.name = @"刘备";
        model1.imageUrl = @"1";
        model1.certifiedStatus = CertifiedStatus_verified;
        model1.identity = @"本人";
        model1.age = 35;
        
        MyFamilyCellModel *model2 = [MyFamilyCellModel new];
        model2.name = @"关羽";
        model2.imageUrl = @"2";
        model2.certifiedStatus = CertifiedStatus_noVerified;
        model2.identity = @"弟弟";
        model2.age = 33;
        
        MyFamilyCellModel *model3 = [MyFamilyCellModel new];
        model3.name = @"张飞";
        model3.imageUrl = @"3";
        model3.certifiedStatus = CertifiedStatus_noVerified;
        model3.identity = @"弟弟";
        model3.age = 32;
        
        section.modelArray = @[model1, model2, model3];
        
        [sections addObject:section];
    }
    {   // 分区2
        CommonCollectionViewSectionModel *section = [CommonCollectionViewSectionModel new];
        
        MyFamilyCellModel *model1 = [MyFamilyCellModel new];
        model1.name = @"刘备";
        model1.imageUrl = @"1";
        model1.certifiedStatus = CertifiedStatus_verified;
        model1.identity = @"本人";
        model1.age = 35;
        
        MyFamilyCellModel *model2 = [MyFamilyCellModel new];
        model2.name = @"关羽";
        model2.imageUrl = @"2";
        model2.certifiedStatus = CertifiedStatus_noVerified;
        model2.identity = @"弟弟";
        model2.age = 33;
        
        MyFamilyLastCellModel *model3 = [MyFamilyLastCellModel new];
        //        model3.name = @"张飞";
        //        model3.imageUrl = @"3";
        //        model3.certifiedStatus = CertifiedStatus_noVerified;
        //        model3.identity = @"弟弟";
        //        model3.age = 32;
        
        section.modelArray = @[model1, model2, model3];
        
        [sections addObject:section];
    }
    
    self.simpleCollectionView.dataArr = sections;
    [self.simpleCollectionView reloadData];
}

//- (void)layoutCollectionViewFrame {}

- (NSDictionary<NSString *,NSDictionary<NSString *,id> *> *)returnCell_Model_keyValues {
    return @{NSStringFromClass([MyFamilyCellModel class]) : @{cellKEY : NSStringFromClass([MyFamilyCell class]), isRegisterNibKEY : @YES},
             NSStringFromClass([MyFamilyLastCellModel class]) : @{cellKEY : NSStringFromClass([MyFamilyLastCell class]), isRegisterNibKEY : @YES}
             };
}

//- (UILabel *)headerLab {
//    if (_headerLab) return _headerLab;
//    _headerLab = [UILabel new];
//    _headerLab.text = @"  添加家人，帮家人使用预约挂号等医疗服务";
//    _headerLab.backgroundColor = [UIColor lightGrayColor];
//    [self.view addSubview:_headerLab];
//    [_headerLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.headerLab.superview.kjMas_safeAreaLeft);
//        make.top.equalTo(self.headerLab.superview.kjMas_safeAreaTop);
//        make.right.equalTo(self.headerLab.superview.kjMas_safeAreaRight);
//        make.bottom.equalTo(self.simpleCollectionView.mas_top);
//        make.height.equalTo(@50);;
//    }];
//    return _headerLab;
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtSection:(NSInteger)section item:(NSInteger)item selectIndexPath:(NSIndexPath *)indexPath model:(CommonCellModel *)model commonCollectionViewTool:(CommonCollectionViewTool *)commonCollectionViewTool {
    
}

@end
