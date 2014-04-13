//
//  RPMethodPickerController.m
//  Diplom
//
//  Created by Pavel Rudkovsky on 13/04/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import "RPMethodPickerController.h"

@implementation RPMethodPickerController {
    NSArray *methods;
    
    UITableView *tblMethods;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    methods = @[@"Евклида", @"Махалалобиса", @"Комбинированный"];
    
    tblMethods = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
    tblMethods.delegate = self;
    tblMethods.dataSource = self;
    
    [tblMethods reloadData];
    self.preferredContentSize = [tblMethods contentSize];
    
    [self.view addSubview:tblMethods];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return methods.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"Cell"];
    }

    cell.textLabel.text = methods[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.customDelegate isKindOfClass:[UITextField class]]) {
        UITextField *tmp = self.customDelegate;
        
        tmp.text = methods[indexPath.row];
        [self.parentController dismissPopoverAnimated:YES];
    }
}

@end
