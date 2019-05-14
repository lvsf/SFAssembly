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
#import "SFTableAssemblyItem.h"
#import "UITableView+SFForm.h"
#import "NSString+HHAdd.h"
#import "YYFPSLabel.h"
#import <Masonry.h>

#import "SFTableAssemblyItem.h"
#import "SFAssemblyEasyFormLayout.h"

@interface ViewController ()<UITableViewDelegate,UIScrollViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) YYFPSLabel *fpsLabel;
@property (nonatomic,strong) UITableView *t;
@end

@implementation ViewController

- (void)_gun {
    for (NSInteger i = 0; i < 200; i++) {
        [self.t setContentOffset:CGPointZero animated:YES];

        [self.t setContentOffset:CGPointMake(0, self.t.contentSize.height - self.view.bounds.size.height) animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *b = [[UIBarButtonItem alloc] initWithTitle:@"滚" style:UIBarButtonItemStyleDone target:self action:@selector(_gun)];
    [self.navigationItem setRightBarButtonItem:b];
    
    __weak typeof(self) weak_self = self;
    
    [SFTableViewManager configuration].reuseIdentifierForClassName = ^(NSString * _Nonnull className) {
        return [NSString stringWithFormat:@"%@ID",className];
    };
    UITableView *t = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    t.backgroundColor = [UIColor whiteColor];
    t.estimatedRowHeight = 0;
    t.estimatedSectionFooterHeight = 0;
    t.estimatedSectionHeaderHeight = 0;
    t.delegate = self;
    t.dataSource = self;
    t.form_enable = YES;
    
    self.t = t;
    
    [t.form_manager addActionForTableViewDidSelectedWithBlock:^(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath) {
        NSLog(@"didSelect:%@",indexPath);
    }];
    
    SFTableSection *section = [SFTableSection new];
    SFTableAssemblyItem *item = [SFTableAssemblyItem new];
    item.layout = ({
        SFAssemblyEasyFormLayout *layout = [SFAssemblyEasyFormLayout new];
        layout.title.label.text = @"Assembly";
        layout.title.label.textColor = [UIColor whiteColor];
        layout.title.label.font = [UIFont boldSystemFontOfSize:16];
        layout.detail.switcher.on = YES;
        [layout.detail.switcher addActionForControlEvents:UIControlEventValueChanged actionBlock:^(id actionObject, UISwitch *sender, id userInfo) {
            NSLog(@"SFAssemblyEasyFormLayout switch : %@",@(sender.on));
        }];
        layout.background.imageView.image = [UIImage imageNamed:@"timg"];
        layout.background.imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        //layout.content.label.sText(@"[content:3.141592653]").sTextColor([UIColor whiteColor]).sFont([UIFont systemFontOfSize:12]).sNumberOfLines(0);
        
        layout.content.assembly.layout = ({
            SFMessageAssemblyLayout *m = [self layout];
            m.content.yyLabel.text = [NSString stringWithFormat:@"<%@>",[NSString hh_randomTextWithKind:HHTextRandomKindChineseCharacter length:arc4random_uniform(200)]];
            m;
        });
        
        layout;
    });
    section.assemblyHeader.easyLayout.height = 44;
    section.assemblyFooter.easyLayout.height = 44;
    section.assemblyHeader.easyLayout.background.view.backgroundColor = [UIColor yellowColor];
    section.assemblyFooter.easyLayout.background.view.backgroundColor = [UIColor yellowColor];
    [section addItem:item];
    
    [t.form_manager addSection:section];
    
    for (NSInteger i = 0; i < 30; i++) {
        SFTableAssemblyItem *item = [SFTableAssemblyItem new];

        SFTableSection *section = [SFTableSection new];
        [section addItem:item];
        
        BOOL show_h_f = YES;
        if (show_h_f) {
            section.assemblyHeader.easyLayout.title.label
            .sText(@"123").sTextColor([UIColor blueColor]).sFont([UIFont systemFontOfSize:15]);
            
            [section.assemblyHeader.easyLayout.detail setLeft:15];
            [section.assemblyHeader.easyLayout.detail.button.normalStatus setTitle:[NSString stringWithFormat:@"header index:%@ %@",@(i),[NSString hh_randomTextWithKind:HHTextRandomKindChineseCharacter length:arc4random_uniform(100)]]];
            [section.assemblyHeader.easyLayout.detail.button setBackgroundColor:[UIColor lightGrayColor]];
            [section.assemblyHeader.easyLayout.detail.button addActionForControlEvents:UIControlEventTouchUpInside actionBlock:^(SFButtonComponent *actionObject, id sender, id userInfo) {
                NSLog(@"%@",actionObject.normalStatus.title);
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"SFAssembly" message:actionObject.normalStatus.title preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                [weak_self.navigationController presentViewController:alert animated:YES completion:nil];
            }];
            [section.assemblyHeader.easyLayout.background setInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
            [section.assemblyHeader.easyLayout.background.view setBackgroundColor:[UIColor orangeColor]];
            
            [section.assemblyHeader.easyLayout.topSeparator.view setBackgroundColor:[UIColor redColor]];
            [section.assemblyHeader.easyLayout.topSeparator setHeight:1];
            
            [section.assemblyFooter.easyLayout.title setHorizontalPosition:SFPlacePositionCenter];
            [section.assemblyFooter.easyLayout.background setInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
            [section.assemblyFooter.easyLayout.background.view setBackgroundColor:[UIColor cyanColor]];
            
            
            if (i == 0 || i == 5) {
                //[item setRowHeight:250];
            }
            else if (i == 6 || i == 7) {
                [section.assemblyFooter.easyLayout.title setCustomView:[UISwitch new]];
            }
            else if (i == 8 || i == 10) {
                [section.assemblyFooter.easyLayout.title.textField setText:nil];
                [section.assemblyFooter.easyLayout.title.textField setPlaceholder:[NSString stringWithFormat:@"footer index %@",@(i)]];
                [section.assemblyFooter.easyLayout.title.textField addActionForControlEvents:UIControlEventEditingChanged actionBlock:^(SFTextFieldComponent *actionObject, id sender, id userInfo) {
                    NSLog(@"text:%@",actionObject.text);
                }];
                [section.assemblyFooter.easyLayout.title setHeight:44];
                [section.assemblyFooter.easyLayout.title setHeightLayoutMode:SFPlaceLayoutModeFill];
                [section.assemblyFooter.easyLayout.title setWidthLayoutMode:SFPlaceLayoutModeFill];
                [section.assemblyFooter.easyLayout.background setInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
            }
            else {
                [section.assemblyFooter.easyLayout.background.view setBackgroundColor:[UIColor greenColor]];
                [section.assemblyFooter.easyLayout.title.label setText:[NSString stringWithFormat:@"footer - index:[%@]",@(i)]];
                [section.assemblyFooter.easyLayout.title.label setTextColor:[UIColor blueColor]];
                [section.assemblyFooter.easyLayout.title.label setFont:[UIFont boldSystemFontOfSize:20]];
            }
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
    //layout.identifier = @"message";
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
    
    layout.background.insets = UIEdgeInsetsMake(15, 15, 15, 15);
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

