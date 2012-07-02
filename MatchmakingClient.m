//
//  MatchmakingClient.m
//  Snap
//
//  Created by Nicolas Ameghino on 02/07/12.
//  Copyright (c) 2012 Hollance. All rights reserved.
//

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
}

#pragma mark - GKSessionDelegate

- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state {
	NSLog(@"MatchmakingClient: peer %@ changed state %d", peerID, state);
	if (state == GKPeerStateAvailable) {
		if (!_availableServers) { _availableServers = [[NSMutableArray alloc] init]; }
		[_availableServers addObject:peerID];
		[self.delegate clientDidUpdateAvailableServers:self];
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
