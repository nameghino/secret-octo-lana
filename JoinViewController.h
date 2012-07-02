//
//  JoinViewController.h
//  Snap
//
//  Created by Nicolas Ameghino on 02/07/12.
//  Copyright (c) 2012 Hollance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MatchmakingClient.h"
#import "MatchmakingServer.h"

#import "UIFont+SnapAdditions.h"
#import "UIColor+SnapAdditions.h"

@class JoinViewController;

@protocol JoinViewControllerDelegate <NSObject>

- (void)joinViewControllerDidCancel:(JoinViewController *)controller;

@end

@interface JoinViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, MatchmakingClientDelegate>

@property (nonatomic, weak) id <JoinViewControllerDelegate> delegate;

@end