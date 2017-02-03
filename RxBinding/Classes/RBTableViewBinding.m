//
//  JRTableViewBinding.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 08/08/16.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import "RBTableViewBinding.h"
#import "RBReactiveView.h"

@interface RBTableViewBinding () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) UITableViewCell *templateCell;
@property (nonatomic, strong) RACCommand *selection;

@end

@implementation RBTableViewBinding

+ (instancetype)bindingHelperForTableView:(UITableView *)tableView
                             sourceSignal:(RACSignal *)source
                         selectionCommand:(RACCommand *)selection
                             templateCell:(UINib *)templateCellNib {
    
    return [[RBTableViewBinding alloc] initWithTableView:tableView
                                            sourceSignal:source
                                        selectionCommand:selection
                                            templateCell:templateCellNib];
}

- (instancetype)initWithTableView:(UITableView *)tableView
                     sourceSignal:(RACSignal *)source
                 selectionCommand:(RACCommand *)selection
                     templateCell:(UINib *)templateCellNib {
    
    if (self = [super init]) {
        _tableView = tableView;
        _data = [NSArray array];
        _selection = selection;
        
        // each time the view model updates the array property, store the latest value and reload the table view
        [source subscribeNext:^(id x) {
            self->_data = x;
            [self->_tableView reloadData];
        }];
                
        _templateCell = [[templateCellNib instantiateWithOwner:nil options:nil] firstObject];
        [tableView registerNib:templateCellNib forCellReuseIdentifier:_templateCell.reuseIdentifier];
        
        tableView.rowHeight = self.templateCell.bounds.size.height;
        
        tableView.dataSource = self;
        tableView.delegate = self;
    }
    return self;
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<RBReactiveView> cell = [tableView dequeueReusableCellWithIdentifier:self.templateCell.reuseIdentifier];
    
    [cell bindViewModel:self.data[indexPath.row]];
    
    return (UITableViewCell *)cell;
}

#pragma mark = UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.selection execute:self.data[indexPath.row]];
    
    if ([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark = UITableViewDelegate forwarding

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.delegate scrollViewDidScroll:scrollView];
    }
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([self.delegate respondsToSelector:aSelector]) {
        return YES;
    }
    return [super respondsToSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if ([self.delegate respondsToSelector:aSelector]) {
        return self.delegate;
    }
    return [super forwardingTargetForSelector:aSelector];
}

@end
