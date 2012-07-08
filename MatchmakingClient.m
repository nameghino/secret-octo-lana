//
//  MatchmakingClient.m
//  Snap
//
//  Created by Nicolas Ameghino on 02/07/12.
//  Copyright (c) 2012 Hollance. All rights reserved.
//

#define CONNECTION_TIMEOUT 15.0f

#import "MatchmakingClient.h"

@implementation MatchmakingClient {
	NSMutableArray *_availableServers;
}

@synthesize session = _session;
@synthesize delegate = _delegate;

-(NSArray *)availableServers {
	if(!_availableServers) {
		_availableServers = [[NSMutableArray alloc] init];
	}
	return _availableServers;
}

-(void)startSearchingForServersWithSessionID:(NSString *)sessionID {
	_session = [[GKSession alloc] initWithSessionID:sessionID
										displayName:nil
										sessionMode:GKSessionModeClient];
	_session.delegate = self;
	_session.available = YES;
    NSDictionary *d = [NSDictionary dictionaryWithObjectsAndKeys:
                       self, @"type", nil];
    
    [_session setDataReceiveHandler:[DataReceiver new] withContext:(void*)d];

}

-(void) connectToPeerID:(NSString*) peerID {
    [_session connectToPeer:peerID withTimeout:CONNECTION_TIMEOUT];
}

#pragma mark - GKSessionDelegate

- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state {
	NSLog(@"MatchmakingClient: peer %@ changed state %d", peerID, state);
	if (state == GKPeerStateAvailable) {
		if (!_availableServers) { _availableServers = [[NSMutableArray alloc] init]; }
		[_availableServers addObject:peerID];
		[self.delegate clientDidUpdateAvailableServers:self];
	} else if (state == GKPeerStateConnected) {
        NSData *myNameData = [[[UIDevice currentDevice] name] dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        [_session sendDataToAllPeers:myNameData
                        withDataMode:GKSendDataReliable
                               error:&error];
    }
}

- (void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID {
	NSLog(@"MatchmakingClient: connection request from peer %@", peerID);
}

- (void)session:(GKSession *)session connectionWithPeerFailed:(NSString *)peerID withError:(NSError *)error {
	NSLog(@"MatchmakingClient: connection with peer %@ failed %@", peerID, error);
}

- (void)session:(GKSession *)session didFailWithError:(NSError *)error {
	NSLog(@"MatchmakingClient: session failed %@", error);
}


@end
