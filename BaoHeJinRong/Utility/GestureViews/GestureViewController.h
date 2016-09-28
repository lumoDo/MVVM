
#import <UIKit/UIKit.h>
//#import "HXWebBasicViewController.h"

typedef enum{
    GestureViewControllerTypeSetting = 1,
    GestureViewControllerTypeLogin
}GestureViewControllerType;

typedef enum{
    buttonTagReset = 1,
    buttonTagManager,
    buttonTagForget
    
}buttonTag;

@protocol GestureViewControllerDelegate <NSObject>
@optional
- (void) gestureSuccess;
- (void) gestureLoginSuccess:(NSInteger)tag;
- (void) pushToFisrtVC_Gesture;

@end

@interface GestureViewController : UIViewController<UIAlertViewDelegate>

/**
 *  控制器来源类型
 */
@property (nonatomic, assign) NSInteger vcTag;
@property (nonatomic, assign) BOOL isNewUser;
@property (nonatomic, assign) GestureViewControllerType type;
@property (nonatomic, assign) id<GestureViewControllerDelegate> delegate;

@end
