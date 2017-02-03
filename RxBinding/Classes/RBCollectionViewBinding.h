//
//  JRCollectionViewBinding.h
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 28/10/2016.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RBCollectionViewBinding : NSObject

@property (nonatomic, weak) id<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource> delegate;

+ (instancetype)bindingHelperForCollectionView:(UICollectionView *)collectionView
                                         frame:(CGRect)frame
                                  sourceSignal:(RACSignal *)source
                              selectionCommand:(RACCommand *)selection
                                  templateCell:(UINib *)templateCellNib
                               scrollDirection:(UICollectionViewScrollDirection)scrollDirection;

@end
