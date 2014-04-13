//
//  RPBaseModalController.m
//  Diplom
//
//  Created by Pavel Rudkovsky on 12/04/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import "RPBaseModalController.h"
#import "UIColorAdditions.h"

@implementation RPBaseModalController 

- (id)init {
    self = [super init];
    
    if (self) {
        self.modalPresentationStyle = UIModalPresentationFormSheet;
        self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        
        [self.navigationBar setBarTintColor:[UIColor colorWithRGB:0x10a8ab]];
        [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil]];
        [self.navigationBar setTintColor:[UIColor whiteColor]];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
//    self.view.backgroundColor = [UIColor whiteColor];
    
    rootController = [UIViewController new];
    rootController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    rootController.view.backgroundColor = [UIColor whiteColor];
    rootController.title = self.title;
    
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithTitle:@"Отмена" style:(UIBarButtonItemStylePlain) target:self action:@selector(onClose)];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Сохранить" style:(UIBarButtonItemStylePlain) target:self action:@selector(onDone)];
    
    rootController.navigationItem.rightBarButtonItem = doneButton;
    rootController.navigationItem.leftBarButtonItem = closeButton;

    [self setViewControllers:@[rootController]];
}

- (void)setCustomView:(UIView *)view {
    view.frame = CGRectMake(20, 100, 500, 500);

    [self.view addSubview:view];
}

- (void) onClose {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) onDone {    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
