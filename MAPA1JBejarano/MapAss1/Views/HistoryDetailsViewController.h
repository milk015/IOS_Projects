//
//  HistoryDetailsViewController.h
//  MapAss1
//
//  Created by Jorge Bejarano on 2020-02-19.
//  Copyright © 2020 Jorge Bejarano Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ticket.h"
NS_ASSUME_NONNULL_BEGIN

@interface HistoryDetailsViewController : UIViewController

@property (strong,nonatomic)NSString* ticketID;
@property (strong, nonatomic) NSString* ticketName;
@property (strong, nonatomic) NSString* ticketPrice;
@property (strong, nonatomic) NSString* ticketqty;
@property (strong, nonatomic) NSString* ticketDate;

@end

NS_ASSUME_NONNULL_END
