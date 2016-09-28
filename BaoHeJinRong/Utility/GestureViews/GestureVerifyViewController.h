
#import <UIKit/UIKit.h>
@protocol GestureVerifyViewControllerDelegate <NSObject>
@optional
- (void) gestureVerifySuccess;
//- (void) pushToFisrtVC_GestureVerify;

@end
@interface GestureVerifyViewController : UIViewController

@property (nonatomic, assign) BOOL isToSetNewGesture;
@property (nonatomic,assign) id<GestureVerifyViewControllerDelegate> delegate;

@end
