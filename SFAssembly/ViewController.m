//
//  ViewController.m
//  SFForm
//
//  Created by YunSL on 2019/3/31.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "ViewController.h"
#import "SFMessageAssemblyLayout.h"
#import "SFMessageAssemblyLayoutDataSource.h"
#import "SFAssemblyView.h"
#import "SFFormAssemblyTableItem.h"
#import "UITableView+SFForm.h"
#import "NSString+HHAdd.h"
#import "YYFPSLabel.h"
#import <Masonry.h>

@interface ViewController ()
@property (nonatomic,strong) YYFPSLabel *fpsLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SFFormTableViewManager configuration].reuseIdentifierForClassName = ^(NSString * _Nonnull className) {
        return [NSString stringWithFormat:@"%@ID",className];
    };
    
    UITableView *t = [[UITableView alloc] initWithFrame:CGRectMake(10, 25, 255, 500) style:UITableViewStyleGrouped];
    t.backgroundColor = [UIColor orangeColor];
    t.estimatedRowHeight = 0;
    t.form_enable = YES;
    for (NSInteger i = 0; i < 50; i++) {
        SFFormAssemblyTableItem *item = [SFFormAssemblyTableItem new];
        SFMessageAssemblyLayout *layout = [self layout];
        layout.content.yyLabel.text = [NSString stringWithFormat:@"%@:%@",@(i),[NSString hh_randomTextWithKind:HHTextRandomKindChineseCharacter length:arc4random_uniform(350)]];
        item.layout = layout;
        item.cacheHeight = YES;
        t.form_manager.defaultSection.addItem(item);
    }
    [self.view addSubview:t];
    [t mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.width.height.equalTo(self.view);
    }];
    
    UIView *bar = [[UIApplication sharedApplication] valueForKey:@"statusBar"];
    [bar addSubview:self.fpsLabel];
}

- (SFMessageAssemblyLayout *)layout {
    SFMessageAssemblyLayout *layout = [SFMessageAssemblyLayout new];
    layout.avatar.imageView.backgroundColor = [UIColor redColor];
    layout.avatar.imageView.image = [UIImage imageNamed:@"quanyou"];
    layout.avatar.width = 40;
    layout.avatar.height = 40;
    layout.avatar.top = 20;
    [layout.avatar setOnLoad:^(SFAssemblyPlace * _Nonnull place, UIView * _Nonnull view) {
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = place.height * 0.5;
        view.layer.shouldRasterize = YES;
        view.layer.rasterizationScale = [UIScreen mainScreen].scale;
        view.layer.borderColor = [UIColor blueColor].CGColor;
        view.layer.borderWidth = 2;
    }];
    
    layout.title.label.text = @"书评标题";
    layout.title.label.textColor = [UIColor blackColor];
    layout.title.label.font = [UIFont boldSystemFontOfSize:23];
    
    layout.name.label.text = @"layout.name.label.text;view setBounds:CGRectMake(0, 0, 100, CGFLOAT_MAX)];";
    layout.name.label.textColor = [UIColor blueColor];
    layout.name.label.font = [UIFont systemFontOfSize:18];
    layout.name.left = 15;
    layout.name.height = layout.name.label.font.lineHeight;
    layout.name.label.numberOfLines = 0;
    
    layout.address.label.text = @"清华北大";
    layout.address.label.font = [UIFont systemFontOfSize:15];
    layout.address.label.textColor = [UIColor darkGrayColor];
    
    layout.follow.button.normalStatus.title = @"关注";
    layout.follow.width = 60;
    layout.follow.height = 40;
    layout.follow.button.normalStatus.titleColor = [UIColor lightGrayColor];
    layout.follow.button.font = [UIFont systemFontOfSize:15];
    layout.follow.button.backgroundColor = [UIColor whiteColor];
    [layout.follow setOnLoad:^(SFAssemblyPlace * _Nonnull place, UIView * _Nonnull view) {
        view.layer.borderColor = [UIColor blueColor].CGColor;
        view.layer.borderWidth = 2;
    }];
    
    layout.content.top = 15;
    layout.content.yyLabel.textColor = [UIColor darkTextColor];
    layout.content.yyLabel.font = [UIFont boldSystemFontOfSize:18];
    layout.content.yyLabel.numberOfLines = 0;
    layout.content.yyLabel.backgroundColor = [UIColor whiteColor];
    
    layout.container.insets = UIEdgeInsetsMake(15, 15, 15, 15);
    layout.dataSource = [SFMessageAssemblyLayoutDataSource new];
    
    return layout;
}

- (YYFPSLabel *)fpsLabel {
    return _fpsLabel?:({
        _fpsLabel = [YYFPSLabel new];
        _fpsLabel.frame = CGRectMake(0, 0, 80, 20);
        _fpsLabel.alpha = 1;
        _fpsLabel.textColor = [UIColor whiteColor];
        _fpsLabel.backgroundColor = [UIColor darkGrayColor];
        _fpsLabel;
    });
}

@end

