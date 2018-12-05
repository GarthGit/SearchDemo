//
//  SearchViewController.m
//  JTSearchDemo
//
//  Created by hoyifo on 2018/12/5.
//  Copyright © 2018 hoyifo. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchDetailVC.h"
@interface SearchViewController ()

@property (strong, nonatomic)  UITableView *tableView;

@property (strong, nonatomic)  NSMutableArray *searchList;//满足搜索条件的数组


@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.searchList = [NSMutableArray new];
    self.dataListArry = [NSMutableArray new];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
//    self.automaticallyAdjustsScrollViewInsets = NO;//不加的话，table会下移
    
    self.edgesForExtendedLayout = UIRectEdgeNone;//不加的话，UISearchBar返回后会上移
    
    [self addtableview];
}
- (void)addtableview{
    
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    
    [self.view addSubview:self.tableView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        tabBarController.tabBar.hidden = YES;
        tabBarController.edgesForExtendedLayout = UIRectEdgeBottom;
    }
}

#pragma mark - tableView
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.searchBar resignFirstResponder];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.searchList.count > 0 ? 44 : 200;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger i = self.searchList.count > 0 ? self.searchList.count : 1;
    return i;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";

    if (self.searchList.count > 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.textLabel.text = self.searchList[indexPath.row];
        cell.textLabel.textColor = [UIColor redColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        return cell;
    }else{
        UITableViewCell *cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchDetailVC *vc = [[SearchDetailVC alloc] init];
    [self.nav pushViewController:vc animated:YES];
}

#pragma mark - UISearchResultsUpdating
//每输入一个字符都会执行一次
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSLog(@"搜索关键字：%@",searchController.searchBar.text);
    searchController.searchResultsController.view.hidden = NO;
    
    //谓词搜索
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchController.searchBar.text];
    if (self.searchList!= nil) {
        [self.searchList removeAllObjects];
    }
    
    //过滤数据
    self.searchList = [NSMutableArray arrayWithArray:[_dataListArry filteredArrayUsingPredicate:preicate]];
    //刷新表格
    
    [self.tableView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
