//
//  JRCollectionViewBinding.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 28/10/2016.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import "RBCollectionViewBinding.h"
#import "RBReactiveView.h"

@interface RBCollectionViewBinding () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) UICollectionViewCell *templateCell;
@property (nonatomic, strong) RACCommand *selection;

@end

@implementation RBCollectionViewBinding

+ (instancetype)bindingHelperForCollectionView:(UICollectionView *)collectionView
                                         frame:(CGRect)frame
                                  sourceSignal:(RACSignal *)source
                              selectionCommand:(RACCommand *)selection
                                  templateCell:(UINib *)templateCellNib
                               scrollDirection:(UICollectionViewScrollDirection)scrollDirection {
    
    return [[RBCollectionViewBinding alloc] initWithCollectionView:collectionView
                                                             frame:frame
                                                      sourceSignal:source
                                                  selectionCommand:selection
                                                      templateCell:templateCellNib
                                                   scrollDirection:scrollDirection];
}

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView
                                 frame:(CGRect)frame
                          sourceSignal:(RACSignal *)source
                      selectionCommand:(RACCommand *)selection
                          templateCell:(UINib *)templateCellNib
                       scrollDirection:(UICollectionViewScrollDirection)scrollDirection{
    
    if (self = [super init]) {
        _collectionView = collectionView;

        _data = [NSArray array];
        
        _selection = selection;
        
        [source subscribeNext:^(id x) {
            self.data = x;
            [self.collectionView reloadData];
        }];
        
        _templateCell = [[templateCellNib instantiateWithOwner:nil options:nil] firstObject];
        
        [collectionView registerNib:templateCellNib
         forCellWithReuseIdentifier:_templateCell.reuseIdentifier];
        
        collectionView.dataSource = self;
        collectionView.delegate = self;
    }
    
    return self;
}

#pragma mark - UICollectionViewDataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    id<RBReactiveView> cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.templateCell.reuseIdentifier
                                                                        forIndexPath:indexPath];
    
    [cell bindViewModel:self.data[indexPath.row]];
    
    return (UICollectionViewCell *)cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

#pragma mark - UICollectionViewDelegate methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.selection execute: self.data[indexPath.row]];
    
    if ([self.delegate respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:)]) {
        [self.delegate collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    }
}

@end
