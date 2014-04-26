//
//  RPModelPreviewModalController.h
//  Diplom
//
//  Created by Pavel Rudkovsky on 26/04/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import "RPBaseController.h"

@interface RPModelPreviewModalController : RPBaseController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tblModel;
@property (weak, nonatomic) IBOutlet UILabel *lblObjects;

@end
