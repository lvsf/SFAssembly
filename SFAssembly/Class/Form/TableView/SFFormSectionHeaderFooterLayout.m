//
//  SFFormSectionHeaderFooterLayout.m
//  SFAssembly
//
//  Created by YunSL on 2019/4/1.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFFormSectionHeaderFooterLayout.h"

@implementation SFFormSectionHeaderFooterLayout

- (CGSize)assemblyLayout:(SFAssemblyLayout *)layout sizeThatFits:(CGSize)size {
    
    //    CGFloat contentLayoutWidth = CGRectGetWidth(self.contentView.bounds) - self.sf_headerFooter.contentInsets.left - self.sf_headerFooter.contentInsets.right;
    //    CGFloat contentLayoutHeight = CGRectGetHeight(self.bounds) - self.sf_headerFooter.contentInsets.top - self.sf_headerFooter.contentInsets.bottom;
    //    [self.container setFrame:CGRectMake(self.sf_headerFooter.contentInsets.left,
    //                                        self.sf_headerFooter.contentInsets.top,
    //                                        contentLayoutWidth,
    //                                        contentLayoutHeight)];
    //
    //    if (self.sf_headerFooter.view) {
    //        [self.sf_headerFooter.view setFrame:CGRectMake(0,
    //                                                       0,
    //                                                       CGRectGetWidth(self.container.bounds),
    //                                                       CGRectGetHeight(self.container.bounds))];
    //    }
    //    else {
    //        if ([self.sf_headerFooter.sectionLabel componentViewShouldDisplay]) {
    //            CGFloat labelLayoutWidth = contentLayoutWidth;
    //            if (self.sf_headerFooter.detailButton) {
    //                labelLayoutWidth = labelLayoutWidth - self.sf_headerFooter.detailButton.width - 10;
    //                [self.detailButton setFrame:CGRectMake(CGRectGetWidth(self.container.bounds) - self.sf_headerFooter.detailButton.width,
    //                                                       (CGRectGetHeight(self.container.bounds) - self.sf_headerFooter.detailButton.height) * 0.5,
    //                                                       self.sf_headerFooter.detailButton.width,
    //                                                       self.sf_headerFooter.detailButton.height)];
    //            }
    //            CGFloat labelHeight = [self.label sizeThatFits:CGSizeMake(labelLayoutWidth, contentLayoutHeight)].height;
    //            [self.label setFrame:CGRectMake(0,
    //                                            (CGRectGetHeight(self.container.bounds) - labelHeight) * 0.5,
    //                                            labelLayoutWidth,
    //                                            labelHeight)];
    //        }
    //    }
    //
    //    if (!self.sf_headerFooter.hiddenTopImageView) {
    //        [self.topImageView setFrame:CGRectMake(0, 0, CGRectGetWidth(self.contentView.bounds), 1)];
    //    }
    
    return CGSizeZero;
}

@end
