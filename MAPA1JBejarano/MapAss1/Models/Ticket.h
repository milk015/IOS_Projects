//
//  Ticket.h
//  MapAss1
//
//  Created by Jorge Bejarano on 2020-02-19.
//  Copyright © 2020 Jorge Bejarano Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Ticket : NSObject

@property double ticketPrice;
@property int ticketQty;
@property int ticketID;
@property (strong, nonatomic) NSString * ticketName;
@property (strong, nonatomic) NSDate * ticketDate;

@end

NS_ASSUME_NONNULL_END
