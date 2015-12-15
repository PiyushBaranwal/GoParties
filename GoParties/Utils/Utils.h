
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//@interface ImageOnNavigationBar : UINavigationBar 
//{
//	
//}
//
//@end


@interface Utils : NSObject 
{

}


+ (void) showAlertView :(NSString*)title message:(NSString*)msg delegate:(id)delegate cancelButtonTitle:(NSString*)CbtnTitle otherButtonTitles:(NSString*)otherBtnTitles;
+ (void) showAlertViewWithTag:(NSInteger)tag title:(NSString*)title message:(NSString*)msg delegate:(id)delegate 
			cancelButtonTitle:(NSString*)CbtnTitle otherButtonTitles:(NSString*)otherBtnTitles;

//+ (UIButton *)newButtonWithTarget:(id)target
//						 selector:(SEL)selector
//							frame:(CGRect)frame
//							image:(UIImage *)image
//					selectedImage:(UIImage *)selectedImage
//							  tag:(NSInteger)aTag;
//+(UITextField*) createTextFieldWithTag:(NSInteger)aTag startX:(CGFloat)aX startY:(CGFloat)aY width:(CGFloat)aW height:(CGFloat)aH placeHolder:(NSString*)aPl keyBoard:(BOOL)isNumber;
//+(UILabel*) createNewLabelWithTag:(NSInteger)aTag startX:(CGFloat)aX startY:(CGFloat)aY width:(CGFloat)aW height:(CGFloat)aH text:(NSString*)aText noOfLines:(NSInteger)noOfLine;
//+ (UIImage *)scaleImage:(UIImage *)image maxWidth:(int) maxWidth maxHeight:(int) maxHeight;
//+ (NSString*) stringFromImage:(UIImage*)image;
//+ (UIImage*) imageFromString:(NSString*)imageString;
//+ (UIImage *)generatePhotoThumbnail:(UIImage *)image ;
//+ (void) addLabelOnNavigationBarWithTitle:(NSString*)aTitle OnNavigation:(UINavigationController*)naviController;


+(void) startActivityIndicatorInView:(UIView*)aView withMessage:(NSString*)aMessage;
+(void) stopActivityIndicatorInView:(UIView*)aView;

+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;


@end




