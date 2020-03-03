//
//  ResetViewController.h
//  MapAss1
//
//  Created by Jorge Bejarano on 2020-02-19.
//  Copyright © 2020 Jorge Bejarano Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ticket.h"
NS_ASSUME_NONNULL_BEGIN
@protocol UpdatingTicketsDele

@required
-(void) managerReset:(Ticket *) ticket atID:(int) ID;
@end

@interface ResetViewController : UIViewController

@property NSMutableArray* allTickets;
@property (strong, nonatomic)id<UpdatingTicketsDele> delegate;

@end

NS_ASSUME_NONNULL_END
