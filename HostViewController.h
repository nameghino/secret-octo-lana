//
//  HostViewController.h
//  Snap
//
//  Created by Nicolas Ameghino on 29/06/12.
//  Copyright (c) 2012 Hollance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFont+SnapAdditions.h"
#import "UIButton+SnapAdditions.h"

#import "MatchmakingServer.h"

@class HostViewController;
@protocol HostViewControllerDelegate <NSObject>
-(void) hostViewControllerDidCancel:(HostViewController*) controller;
@end

@interface HostViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property(nonatomic, weak) id<HostViewControllerDelegate> delegate;
@end
