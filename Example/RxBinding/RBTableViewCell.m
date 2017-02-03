//
//  RBTableViewCell.m
//  RxBinding
//
//  Created by Jean Raphael Bordet on 06/12/2016.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import "RBTableViewCell.h"

@implementation RBTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)bindViewModel:(NSString *)viewModel {
    self.titleLabel.text = viewModel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
