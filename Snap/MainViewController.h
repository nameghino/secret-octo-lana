
#import "UIFont+SnapAdditions.h"
#import "UIButton+SnapAdditions.h"

#import "HostViewController.h"
#import "JoinViewController.h"

@interface MainViewController : UIViewController <HostViewControllerDelegate, JoinViewControllerDelegate> {
	BOOL _buttonsEnabled;
}
@end
