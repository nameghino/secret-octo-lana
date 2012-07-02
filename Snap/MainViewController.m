
#import "MainViewController.h"

@interface MainViewController ()
@property (nonatomic, weak) IBOutlet UIImageView *sImageView;
@property (nonatomic, weak) IBOutlet UIImageView *nImageView;
@property (nonatomic, weak) IBOutlet UIImageView *aImageView;
@property (nonatomic, weak) IBOutlet UIImageView *pImageView;
@property (nonatomic, weak) IBOutlet UIImageView *jokerImageView;

@property (nonatomic, weak) IBOutlet UIButton *hostGameButton;
@property (nonatomic, weak) IBOutlet UIButton *joinGameButton;
@property (nonatomic, weak) IBOutlet UIButton *singlePlayerGameButton;
@end

@implementation MainViewController

@synthesize sImageView = _sImageView;
@synthesize nImageView = _nImageView;
@synthesize aImageView = _aImageView;
@synthesize pImageView = _pImageView;
@synthesize jokerImageView = _jokerImageView;

@synthesize hostGameButton = _hostGameButton;
@synthesize joinGameButton = _joinGameButton;
@synthesize singlePlayerGameButton = _singlePlayerGameButton;

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	[self.hostGameButton rw_applySnapStyle];
	[self.joinGameButton rw_applySnapStyle];
	[self.singlePlayerGameButton rw_applySnapStyle];
}

- (void)prepareForIntroAnimation
{
	self.sImageView.hidden = YES;
	self.nImageView.hidden = YES;
	self.aImageView.hidden = YES;
	self.pImageView.hidden = YES;
	self.jokerImageView.hidden = YES;
	
	self.hostGameButton.alpha = 0.0f;
	self.joinGameButton.alpha = 0.0f;
	self.singlePlayerGameButton.alpha = 0.0f;
	
	_buttonsEnabled = NO;
	
}

- (void)performIntroAnimation
{
	self.sImageView.hidden = NO;
	self.nImageView.hidden = NO;
	self.aImageView.hidden = NO;
	self.pImageView.hidden = NO;
	self.jokerImageView.hidden = NO;
	
	CGPoint point = CGPointMake(self.view.bounds.size.width / 2.0f, self.view.bounds.size.height * 2.0f);
	
	self.sImageView.center = point;
	self.nImageView.center = point;
	self.aImageView.center = point;
	self.pImageView.center = point;
	self.jokerImageView.center = point;
	
	[UIView animateWithDuration:0.65f
						  delay:0.5f
						options:UIViewAnimationOptionCurveEaseOut
					 animations:^
	 {
		 self.sImageView.center = CGPointMake(80.0f, 108.0f);
		 self.sImageView.transform = CGAffineTransformMakeRotation(-0.22f);
		 
		 self.nImageView.center = CGPointMake(160.0f, 93.0f);
		 self.nImageView.transform = CGAffineTransformMakeRotation(-0.1f);
		 
		 self.aImageView.center = CGPointMake(240.0f, 88.0f);
		 
		 self.pImageView.center = CGPointMake(320.0f, 93.0f);
		 self.pImageView.transform = CGAffineTransformMakeRotation(0.1f);
		 
		 self.jokerImageView.center = CGPointMake(400.0f, 108.0f);
		 self.jokerImageView.transform = CGAffineTransformMakeRotation(0.22f);
	 }
					 completion:nil];
	
	[UIView animateWithDuration:0.5f
						  delay:1.0f
						options:UIViewAnimationOptionCurveEaseOut
					 animations:^
	 {
		 self.hostGameButton.alpha = 1.0f;
		 self.joinGameButton.alpha = 1.0f;
		 self.singlePlayerGameButton.alpha = 1.0f;
	 }
					 completion:^(BOOL finished)
	 {
		 _buttonsEnabled = YES;
	 }];
	
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self prepareForIntroAnimation];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self performIntroAnimation];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void)performExitAnimationWithCompletionBlock:(void (^)(BOOL))block {
	_buttonsEnabled = NO;
	
	[UIView animateWithDuration:0.3f
						  delay:0.0f
						options:UIViewAnimationOptionCurveEaseOut
					 animations:^ {
						 self.sImageView.center = self.aImageView.center;
						 self.sImageView.transform = self.aImageView.transform;
						 
						 self.nImageView.center = self.aImageView.center;
						 self.nImageView.transform = self.aImageView.transform;
						 
						 self.pImageView.center = self.aImageView.center;
						 self.pImageView.transform = self.aImageView.transform;
						 
						 self.jokerImageView.center = self.aImageView.center;
						 self.jokerImageView.transform = self.aImageView.transform;
					 }
					 completion:^(BOOL finished) {
						 CGPoint point = CGPointMake(self.aImageView.center.x, self.view.frame.size.height * -2.0f);
						 
						 [UIView animateWithDuration:1.0f
											   delay:0.0f
											 options:UIViewAnimationOptionCurveEaseOut
										  animations:^ {
											  self.sImageView.center = point;
											  self.nImageView.center = point;
											  self.aImageView.center = point;
											  self.pImageView.center = point;
											  self.jokerImageView.center = point;
										  }
										  completion:block];
						 
						 [UIView animateWithDuration:0.3f
											   delay:0.3f
											 options:UIViewAnimationOptionCurveEaseOut
										  animations:^ {
											  self.hostGameButton.alpha = 0.0f;
											  self.joinGameButton.alpha = 0.0f;
											  self.singlePlayerGameButton.alpha = 0.0f;
										  }
										  completion:nil];
					 }];
}


- (IBAction)hostGameAction:(id)sender {
	if (_buttonsEnabled) {
		[self performExitAnimationWithCompletionBlock:^(BOOL finished) {	
			HostViewController *controller = [[HostViewController alloc] initWithNibName:@"HostViewController" bundle:nil];
			controller.delegate = self;
			[self presentViewController:controller animated:NO completion:nil];
		}];
	}
}

- (IBAction)joinGameAction:(id)sender {
	if (_buttonsEnabled) {
		[self performExitAnimationWithCompletionBlock:^(BOOL finished) {
			 JoinViewController *controller = [[JoinViewController alloc] initWithNibName:@"JoinViewController" bundle:nil];
			 controller.delegate = self;
			 [self presentViewController:controller animated:NO completion:nil];
		 }];
	}
}

- (IBAction)singlePlayerGameAction:(id)sender
{
}

-(void)joinViewControllerDidCancel:(JoinViewController *)controller {
	[self dismissViewControllerAnimated:NO completion:nil];
}

-(void)hostViewControllerDidCancel:(HostViewController *)controller {
	[self dismissViewControllerAnimated:NO completion:nil];
}



@end
