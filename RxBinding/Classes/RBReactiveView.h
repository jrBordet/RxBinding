//
//  JRReactiveView.h
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 08/08/16.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RBReactiveView <NSObject>

- (void)bindViewModel:(id)viewModel;

@end
