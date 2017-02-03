//
//  RBViewController.m
//  RxBinding
//
//  Created by Jean Raphael Bordet on 12/06/2016.
//  Copyright (c) 2016 Jean Raphael Bordet. All rights reserved.
//

#import "RBViewController.h"
#import "RBTableViewBinding.h"
#import "ReactiveCocoa/RACEXTScope.h"

@interface RBViewController ()

@property (nonatomic, strong) RBTableViewBinding *binding;
@property (nonatomic, strong) NSMutableArray *source;
@property (nonatomic, strong) RACCommand *selectionCommand;

@end

@implementation RBViewController {
}

- (RACCommand *)selectionCommand {
    //@weakify(self)
    
    if (!_selectionCommand) {
       // @strongify(self)
        _selectionCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id result) {
            NSLog(@"selectionCommand: %@", result);
            
//            DetailViewController *detail = [_assembly detailViewControllerWith:result];
//            
//            [self.navigationController pushViewController:detail
//                                                 animated:YES];
            return [RACSignal empty];
        }];
    }
    
    return _selectionCommand;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.source = [NSMutableArray new];
    
    for (int i=0; i<10; i++) {
        [self.source addObject:[NSString stringWithFormat:@"Title %i", i]];
    }
    
    UINib *templateCell = [UINib nibWithNibName:@"RBTableViewCell"
                                         bundle:nil];
    
    self.binding = [RBTableViewBinding bindingHelperForTableView:self.tableView
                                     sourceSignal:RACObserve(self, self.source)
                                 selectionCommand:self.selectionCommand
                                     templateCell:templateCell];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
