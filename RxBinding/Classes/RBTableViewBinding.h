//
//  JRTableViewBinding.h
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 08/08/16.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RBTableViewBinding : NSObject

@property (weak, nonatomic) id<UITableViewDelegate> delegate;

- (instancetype)initWithTableView:(UITableView *)tableView
                     sourceSignal:(RACSignal *)source
                 selectionCommand:(RACCommand *)selection
                     templateCell:(UINib *)templateCellNib;

+ (instancetype)bindingHelperForTableView:(UITableView *)tableView
                             sourceSignal:(RACSignal *)source
                         selectionCommand:(RACCommand *)selection
                             templateCell:(UINib *)templateCellNib;

@end
