//
//  CKJTableViewHeaderFooterEmptyView.m
//  HuZhou
//
//  Created by chenkaijie on 2018/7/23.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "CKJTableViewHeaderFooterEmptyView.h"
#import "CKJSimpleTableView.h"


@implementation CKJTableViewHeaderFooterEmptyModel

@end


@implementation CKJTableViewHeaderFooterEmptyView

- (void)setupData:(CKJTableViewHeaderFooterEmptyModel *)headerFooterModel section:(NSInteger)section tableView:(UITableView *)tableView {
    self.contentView.backgroundColor = self.simpleTableView.backgroundColor;
}

@end
