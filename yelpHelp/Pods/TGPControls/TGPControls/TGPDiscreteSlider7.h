//    @file:    TGPDiscreteSlider7.h
//    @project: TGPControls
//
//    @history: Created July 4th, 2014 (Independence Day)
//    @author:  Xavier Schott
//              mailto://xschott@gmail.com
//              http://thegothicparty.com
//              tel://+18089383634
//
//    @license: http://opensource.org/licenses/MIT
//    Copyright (c) 2014, Xavier Schott
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in
//    all copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//    THE SOFTWARE.

#import <UIKit/UIKit.h>

@interface TGPDiscreteSlider7 :

//  Interface builder hides the IBInspectable for UIControl
#if TARGET_INTERFACE_BUILDER
UIView
#else // !TARGET_INTERFACE_BUILDER
UIControl
#endif // TARGET_INTERFACE_BUILDER

typedef NS_ENUM(int, ComponentStyle) {
    ComponentStyleIOS = 0,
    ComponentStyleRectangular,
    ComponentStyleRounded,
    ComponentStyleInvisible,
    ComponentStyleImage
};

@property (nonatomic) ComponentStyle tickStyle;
@property (nonatomic) CGSize tickSize;
@property (nonatomic) int tickCount;
@property (nonatomic, readonly) CGFloat ticksDistance;

@property (nonatomic) ComponentStyle trackStyle;
@property (nonatomic) CGFloat trackThickness;

@property (nonatomic) ComponentStyle thumbStyle;
@property (nonatomic) CGSize thumbSize;
@property (nonatomic) UIColor * thumbColor;
@property (nonatomic) CGFloat thumbShadowRadius;
@property (nonatomic) CGSize thumbShadowOffset;

// AKA: UISlider value (as CGFloat for compatibility with UISlider API, but expected to contain integers)
@property (nonatomic) CGFloat minimumValue;
@property (nonatomic) CGFloat value;

@property (nonatomic) int incrementValue;

@end
