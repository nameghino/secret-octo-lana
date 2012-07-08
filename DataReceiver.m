//
//  DataReceiver.m
//  Snap
//
//  Created by Nicolas Ameghino on 7/2/12.
//  Copyright (c) 2012 Hollance. All rights reserved.
//

#import "DataReceiver.h"

@implementation DataReceiver

- (void) receiveData:(NSData *)data fromPeer:(NSString *)peer inSession: (GKSession *)session context:(void *)context {
    /*
    NSDictionary *ctx = (__bridge_transfer NSDictionary*)context;
    NSLog(@"%@ --> %@", @"type", [ctx objectForKey:@"type"]);
    */
    NSLog(@"Received: %@", data);
}

@end
