//
//  ManagerViewController.h
//  MapAss1
//
//  Created by Jorge Bejarano on 2020-02-19.
//  Copyright © 2020 Jorge Bejarano Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "TicketModel.h"
#import "ResetViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ManagerViewController : UIViewController

@property (strong, nonatomic)TicketModel * gate;
@property (strong, nonatomic)id<UpdatingTicketsDele> delegate;

@end

NS_ASSUME_NONNULL_END
