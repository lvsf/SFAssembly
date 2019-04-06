//
//  ViewController.m
//  SFForm
//
//  Created by YunSL on 2019/3/31.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "ViewController.h"
#import "SFMessageAssemblyLayout.h"
#import "SFAssemblyView.h"
#import "SFFormAssemblyTableItem.h"
#import "UITableView+SFForm.h"
#import "NSString+HHAdd.h"
#import "YYFPSLabel.h"
#import <Masonry.h>

@interface ViewController ()<UITableViewDelegate,UIScrollViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) YYFPSLabel *fpsLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weak_self = self;
    
    [SFFormTableViewManager configuration].reuseIdentifierForClassName = ^(NSString * _Nonnull className) {
        return [NSString stringWithFormat:@"%@ID",className];
    };
    UITableView *t = [[UITableView alloc] initWithFrame:CGRectMake(10, 25, 255, 500) style:UITableViewStyleGrouped];
    t.backgroundColor = [UIColor whiteColor];
    t.estimatedRowHeight = 0;
    t.estimatedSectionFooterHeight = 0;
    t.estimatedSectionHeaderHeight = 0;
    t.delegate = self;
    t.dataSource = self;
    t.form_enable = YES;
    
    [t.form_manager addActionForTableViewDidSelectedWithBlock:^(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath) {
        NSLog(@"didSelect:%@",indexPath);
    }];
    
    for (NSInteger i = 0; i < 25; i++) {
        SFFormAssemblyTableItem *item = [SFFormAssemblyTableItem new];

        SFFormTableSection *section = [SFFormTableSection new];
        [section addItem:item];
        
        [section.header.sectionLayout.title.label setText:@"123"];
        [section.header.sectionLayout.title.label setTextColor:[UIColor blueColor]];
        [section.header.sectionLayout.title.label setFont:[UIFont systemFontOfSize:15]];

        [section.header.sectionLayout.detail setLeft:15];
        [section.header.sectionLayout.detail.button.normalStatus setTitle:[NSString stringWithFormat:@"header index:%@ %@",@(i),[NSString hh_randomTextWithKind:HHTextRandomKindChineseCharacter length:arc4random_uniform(100)]]];
        [section.header.sectionLayout.detail.button setBackgroundColor:[UIColor lightGrayColor]];
        [section.header.sectionLayout.detail.button addActionForControlEvents:UIControlEventTouchUpInside actionBlock:^(SFButtonComponent *actionObject, id sender, id userInfo) {
            NSLog(@"%@",actionObject.normalStatus.title);
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"SFAssembly" message:actionObject.normalStatus.title preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [weak_self.navigationController presentViewController:alert animated:YES completion:nil];
        }];
        [section.header.sectionLayout.container setInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
        [section.header.sectionLayout.container setBackgroundColor:[UIColor orangeColor]];
  
        [section.header.sectionLayout.topSeparator.view setBackgroundColor:[UIColor redColor]];
        [section.header.sectionLayout.topSeparator setHeight:1];
        
        [section.footer.sectionLayout.title setHorizontalPosition:SFComponentPositionCenter];
        [section.footer.sectionLayout.container setInsets:UIEdgeInsetsMake(25, 25, 25, 25)];
        [section.footer.sectionLayout.container setBackgroundColor:[UIColor cyanColor]];
        [section.footer.sectionLayout.container setContainerColor:[UIColor greenColor]];
        
        if (i == 0 || i == 5) {
            [section.footer.sectionLayout.title setCustomView:[UISwitch new]];
        }
        else if (i == 8 || i == 10) {
            [section.footer.sectionLayout.title.textField setText:nil];
            [section.footer.sectionLayout.title.textField setPlaceholder:[NSString stringWithFormat:@"footer index %@",@(i)]];
            [section.footer.sectionLayout.title.textField addActionForControlEvents:UIControlEventEditingChanged actionBlock:^(SFTextFieldComponent *actionObject, id sender, id userInfo) {
                NSLog(@"text:%@",actionObject.text);
            }];
            [section.footer.sectionLayout.title setHeight:44];
            [section.footer.sectionLayout.title setHeightLayoutMode:SFComponentLayoutModeFill];
            [section.footer.sectionLayout.title setWidthLayoutMode:SFComponentLayoutModeFill];
            [section.footer.sectionLayout.container setInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
        }
        else {
            [section.footer.sectionLayout.container setContainerColor:[UIColor greenColor]];
            [section.footer.sectionLayout.title.label setText:[NSString stringWithFormat:@"footer index:%@",@(i)]];
            [section.footer.sectionLayout.title.label setTextColor:[UIColor blueColor]];
            [section.footer.sectionLayout.title.label setFont:[UIFont boldSystemFontOfSize:20]];
        }
        
        SFMessageAssemblyLayout *layout = [self layout];
        layout.content.yyLabel.text = [NSString stringWithFormat:@"%@:%@",@(i),[NSString hh_randomTextWithKind:HHTextRandomKindChineseCharacter length:arc4random_uniform(350)]];
        item.layout = layout;
        item.cacheHeight = YES;
        item.accessoryType = (i % 2 == 0)?UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryDisclosureIndicator;
        t.form_manager.addSection(section);
        
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
    
    /*
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
     */
    
    layout.follow.switcher.on = (arc4random_uniform(20) % 2 == 0);
    [layout.follow.switcher addActionForControlEvents:UIControlEventValueChanged actionBlock:^(id actionObject, UISwitch *sender, id userInfo) {
        NSLog(@"switcher on:%@",sender.on?@"YES":@"NO");
    }];
    
    layout.content.top = 15;
    layout.content.yyLabel.textColor = [UIColor darkTextColor];
    layout.content.yyLabel.font = [UIFont boldSystemFontOfSize:18];
    layout.content.yyLabel.numberOfLines = 0;
    layout.content.yyLabel.backgroundColor = [UIColor whiteColor];
    
    layout.container.insets = UIEdgeInsetsMake(15, 15, 15, 15);
    return layout;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return @[@"1",@"2",@"3"];
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

