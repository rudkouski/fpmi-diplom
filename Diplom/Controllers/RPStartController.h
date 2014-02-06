//
//  RPStartController.h
//  Diplom
//
//  Created by Pavel Rudkovsky on 02/02/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import "RPBaseController.h"

@interface RPStartController : RPBaseController

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnMainMenu;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@end
