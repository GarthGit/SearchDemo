//
//  SearchViewController.h
//  JTSearchDemo
//
//  Created by hoyifo on 2018/12/5.
//  Copyright © 2018 hoyifo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController
<UISearchResultsUpdating>

@property (strong, nonatomic) UINavigationController *nav;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) NSMutableArray *dataListArry;

@end
