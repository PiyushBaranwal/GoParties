
#import "Utils.h"
#import "GSNSDataExtensions.h"
#import <QuartzCore/QuartzCore.h>
#import "MBProgressHUD.h"

#define MOVE_ANIMATION_DURATION_SECONDS_FOR_C1 .5


//@implementation ImageOnNavigationBar
//
//- (void) drawRect:(CGRect)rect
//{
//	UIImage *tabImage=[UIImage imageNamed:@"navBar.png"];
//	[tabImage drawAtPoint:CGPointMake(0, 0)];
//}
//@end


@implementation Utils


#pragma mark -
////----- show a alert massage
+ (void) showAlertView :(NSString*)title message:(NSString*)msg delegate:(id)delegate 
													cancelButtonTitle:(NSString*)CbtnTitle otherButtonTitles:(NSString*)otherBtnTitles
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:delegate 
										  cancelButtonTitle:CbtnTitle otherButtonTitles:otherBtnTitles, nil];
	[alert show];
	[alert release];
}

+ (void) showAlertViewWithTag:(NSInteger)tag title:(NSString*)title message:(NSString*)msg delegate:(id)delegate 
      cancelButtonTitle:(NSString*)CbtnTitle otherButtonTitles:(NSString*)otherBtnTitles
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:delegate 
										  cancelButtonTitle:CbtnTitle otherButtonTitles:otherBtnTitles, nil];
    alert.tag = tag;
	[alert show];
	[alert release];
}


#pragma mark UIButton

+ (UIButton *)newButtonWithTarget:(id)target  selector:(SEL)selector frame:(CGRect)frame
							image:(UIImage *)image
					selectedImage:(UIImage *)selectedImage
							  tag:(NSInteger)aTag
{	
	//UIButton *button = [[UIButton alloc] initWithFrame:frame];
	// or you can do this:
	UIButton *button = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
	button.frame = frame;
	[button setImage:image forState:UIControlStateNormal];
	[button setImage:selectedImage forState:UIControlStateSelected];
	
	[button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    // in case the parent view draws with a custom color or gradient, use a transparent color
	button.backgroundColor = [UIColor clearColor];
	button.showsTouchWhenHighlighted = YES;
	button.tag = aTag;
	return button;
}

#pragma mark textField
+(UITextField*) createTextFieldWithTag:(NSInteger)aTag startX:(CGFloat)aX startY:(CGFloat)aY width:(CGFloat)aW height:(CGFloat)aH placeHolder:(NSString*)aPl keyBoard:(BOOL)isNumber
{
	UITextField *aTextField=[[UITextField alloc] init];
	aTextField.frame = CGRectMake(aX,aY ,aW ,aH);
	aTextField.tag = aTag;
	aTextField.placeholder = aPl;
	aTextField.backgroundColor=[UIColor clearColor];
	aTextField.textColor = [UIColor brownColor];
	aTextField.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
	aTextField.borderStyle = UITextBorderStyleNone ;
	if (isNumber)
		aTextField.keyboardType = UIKeyboardTypeNumberPad;
	else
	  aTextField.keyboardType = UIKeyboardTypeDefault;
	aTextField.returnKeyType = UIReturnKeyDone;
	aTextField.contentVerticalAlignment = YES;
	//aTextField.text = aPl;
	aTextField.textAlignment = NSTextAlignmentLeft;
	return [aTextField autorelease];
}

#pragma mark label
+(UILabel*) createNewLabelWithTag:(NSInteger)aTag startX:(CGFloat)aX startY:(CGFloat)aY width:(CGFloat)aW height:(CGFloat)aH text:(NSString*)aText noOfLines:(NSInteger)noOfLine
{
	UILabel *aLabel = [[UILabel alloc] init];
	aLabel.frame = CGRectMake(aX, aY, aW, aH);
	aLabel.text = aText;
	aLabel.tag = aTag;
	aLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:(16.0)];
	aLabel.textColor = [UIColor blackColor];
	aLabel.backgroundColor = [UIColor clearColor];
	aLabel.adjustsFontSizeToFitWidth = YES;
	aLabel.numberOfLines = noOfLine;
	aLabel.textAlignment = NSTextAlignmentLeft;
	return [aLabel autorelease];
}

#pragma mark - Image Resize 
+ (UIImage *)scaleImage:(UIImage *)image maxWidth:(int) maxWidth maxHeight:(int) maxHeight
{
    CGImageRef imgRef = image.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
	
    if (width <= maxWidth && height <= maxHeight)
	{
		return image;
	}
	
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
	
    if (width > maxWidth || height > maxHeight)
	{
		CGFloat ratio = width/height;
		
		if (ratio > 1)
		{
			bounds.size.width = maxWidth;
			bounds.size.height = bounds.size.width / ratio;
		}
		else
		{
			bounds.size.height = maxHeight;
			bounds.size.width = bounds.size.height * ratio;
		}
	}
	
    CGFloat scaleRatio = bounds.size.width / width;
    UIGraphicsBeginImageContext(bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, scaleRatio, -scaleRatio);
    CGContextTranslateCTM(context, 0, -height);
    CGContextConcatCTM(context, transform);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
	
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
    return imageCopy;
	
}

#pragma mark Image Conversion
+ (NSString*) stringFromImage:(UIImage*)image
{
	
	NSData* imageData = UIImagePNGRepresentation(image);
	
	//NSData *imageData = UIImageJPEGRepresentation(image, 1);
	
	NSString* str = [imageData base64EncodingWithLineLength:80];
	return str;
	
}

+ (UIImage*) imageFromString:(NSString*)imageString
{
	NSData* imageData = [NSData dataWithBase64EncodedString:imageString];
	return [UIImage imageWithData: imageData];
}

#pragma mark - Use it when pickup an image from imagepicker
+ (UIImage *)generatePhotoThumbnail:(UIImage *)image 
{
	//int kMaxResolution = 320; 
	
	CGImageRef imgRef = image.CGImage; 
	
	CGFloat width = CGImageGetWidth(imgRef); 
	CGFloat height = CGImageGetHeight(imgRef); 
	
	CGAffineTransform transform = CGAffineTransformIdentity; 
	CGRect bounds = CGRectMake(0, 0, width, height); 
	/*if (width > kMaxResolution || height > kMaxResolution) 
	 { 
	 CGFloat ratio = width/height; 
	 if (ratio > 1)
	 { 
	 bounds.size.width = kMaxResolution; 
	 bounds.size.height = bounds.size.width / ratio; 
	 } 
	 else
	 { 
	 bounds.size.height = kMaxResolution; 
	 bounds.size.width = bounds.size.height * ratio; 
	 } 
	 } */
	
	CGFloat scaleRatio = bounds.size.width / width; 
	CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));  
	CGFloat boundHeight;                       
	UIImageOrientation orient = image.imageOrientation;                         
	switch(orient)
	{ 
		case UIImageOrientationUp: //EXIF = 1 
			transform = CGAffineTransformIdentity; 
			break;
			
		case UIImageOrientationUpMirrored: //EXIF = 2  
			transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0); 
			transform = CGAffineTransformScale(transform, -1.0, 1.0); 
			break; 
			
		case UIImageOrientationDown: //EXIF = 3 
			transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height); 
			transform = CGAffineTransformRotate(transform, M_PI); 
			break; 
			
		case UIImageOrientationDownMirrored: //EXIF = 4 
			transform = CGAffineTransformMakeTranslation(0.0, imageSize.height); 
			transform = CGAffineTransformScale(transform, 1.0, -1.0); 
			break; 
			
		case UIImageOrientationLeftMirrored: //EXIF = 5 
			boundHeight = bounds.size.height; 
			bounds.size.height = bounds.size.width; 
			bounds.size.width = boundHeight; 
			transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width); 
			transform = CGAffineTransformScale(transform, -1.0, 1.0); 
			transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0); 
			break; 
			
		case UIImageOrientationLeft: //EXIF = 6 
			boundHeight = bounds.size.height; 
			bounds.size.height = bounds.size.width; 
			bounds.size.width = boundHeight; 
			transform = CGAffineTransformMakeTranslation(0.0, imageSize.width); 
			transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0); 
			break; 
			
		case UIImageOrientationRightMirrored: //EXIF = 7 
			boundHeight = bounds.size.height; 
			bounds.size.height = bounds.size.width; 
			bounds.size.width = boundHeight; 
			transform = CGAffineTransformMakeScale(-1.0, 1.0); 
			transform = CGAffineTransformRotate(transform, M_PI / 2.0); 
			break; 
			
		case UIImageOrientationRight: //EXIF = 8 
			boundHeight = bounds.size.height; 
			bounds.size.height = bounds.size.width; 
			bounds.size.width = boundHeight; 
			transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0); 
			transform = CGAffineTransformRotate(transform, M_PI / 2.0); 
			break; 
		default: 
			[NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"]; 
			break;
	} 
	
	UIGraphicsBeginImageContext(bounds.size); 
	
	CGContextRef context = UIGraphicsGetCurrentContext(); 
	
	if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft)
	{ 
		CGContextScaleCTM(context, -scaleRatio, scaleRatio); 
		CGContextTranslateCTM(context, -height, 0); 
	} 
	else
	{ 
		CGContextScaleCTM(context, scaleRatio, -scaleRatio); 
		CGContextTranslateCTM(context, 0, -height); 
	} 
	
	CGContextConcatCTM(context, transform); 
	
	CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef); 
	UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext(); 
	UIGraphicsEndImageContext(); 
	
	return imageCopy;
	
}

+ (void) addLabelOnNavigationBarWithTitle:(NSString*)aTitle OnNavigation:(UINavigationController*)naviController
{
    // Add Title on NavigationBar
    UILabel *titleLabel = [[self createNewLabelWithTag:1 startX:0 startY:0 width:140 height:44 text:aTitle noOfLines:1] retain];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:(20.0)];
    naviController.navigationBar.topItem.titleView = titleLabel;
    //ReleaseObject(titleLabel);
}



#pragma mark - Activity Indicator
+(void) startActivityIndicatorInView:(UIView*)aView withMessage:(NSString*)aMessage
{
    MBProgressHUD *_hud = [MBProgressHUD showHUDAddedTo:aView animated:YES];
    _hud.dimBackground  = YES;
    _hud.labelText      = aMessage;
}

+(void) stopActivityIndicatorInView:(UIView*)aView
{
    [MBProgressHUD hideHUDForView:aView animated:YES];
}


@end
