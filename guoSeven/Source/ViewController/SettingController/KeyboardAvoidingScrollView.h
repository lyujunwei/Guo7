//
//  KeyboardAvoidingScrollView.h
//
//

@interface KeyboardAvoidingScrollView : UIScrollView<UIScrollViewDelegate> {
    UIEdgeInsets    _priorInset;
    BOOL            _keyboardVisible;
    CGRect          _keyboardRect;
    CGSize          _originalContentSize;
}

@property(nonatomic,assign) BOOL handAjust;

- (void)adjustOffsetToIdealIfNeeded;
@end
