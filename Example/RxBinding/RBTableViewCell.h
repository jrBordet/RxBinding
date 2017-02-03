//
//  RBTableViewCell.h
//  RxBinding
//
//  Created by Jean Raphael Bordet on 06/12/2016.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RBreactiveView.h"

@interface RBTableViewCell : UITableViewCell <RBReactiveView>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
