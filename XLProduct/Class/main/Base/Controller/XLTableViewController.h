//
//  XLTableViewController.h
//  Project
//
//  Created by Mac on 16/8/19.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "XLViewController.h"

@interface XLTableViewController : XLViewController<UITableViewDelegate, UITableViewDataSource>
- (instancetype)initWithStyle:(UITableViewStyle)style;

/**
 *  显示大量数据的控件
 */
@property (nonatomic, strong) UITableView *tableView;

/**
 *  数据源
 */
@property (nonatomic, strong) NSMutableArray *dataSource;

@end
