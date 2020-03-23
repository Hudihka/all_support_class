//
//  BFPaperTableViewCell.h
//  BFPaperKit
//
//  Created by Bence Feher on 7/11/14.
//  Copyright (c) 2014 Bence Feher. All rights reserved.
//
// The MIT License (MIT)
//
// Copyright (c) 2014 Bence Feher
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.


#import <UIKit/UIKit.h>

// Nice circle diameter constants:
extern const CGFloat bfPaperTableViewCell_tapCircleDiameterMedium;
extern const CGFloat bfPaperTableViewCell_tapCircleDiameterLarge;
extern const CGFloat bfPaperTableViewCell_tapCircleDiameterSmall;
extern const CGFloat bfPaperTableViewCell_tapCircleDiameterFull;
extern const CGFloat bfPaperTableViewCell_tapCircleDiameterDefault;

IB_DESIGNABLE
#if __IPHONE_OS_VERSION_MAX_ALLOWED < 100000
// CAAnimationDelegate is not available before iOS 10 SDK
@interface BFPaperTableViewCell : UITableViewCell
#else
@interface BFPaperTableViewCell : UITableViewCell <CAAnimationDelegate>
#endif


#pragma mark - Properties
#pragma mark Animation
/** A CGFLoat representing the duration of the animations which take place on touch DOWN! Default is 0.25f seconds. (Go Steelers) */
@property IBInspectable CGFloat touchDownAnimationDuration;
/** A CGFLoat representing the duration of the animations which take place on touch UP! Default is 2 * touchDownAnimationDuration seconds. */
@property IBInspectable CGFloat touchUpAnimationDuration;


#pragma mark Prettyness and Behaviour
/** A flag to set YES to use Smart Color, or NO to use a custom color scheme. While Smart Color is recommended, customization is cool too. */
@property (nonatomic) IBInspectable BOOL usesSmartColor;

/** A CGFLoat representing the diameter of the tap-circle as soon as it spawns, before it grows. Default is 5.f. */
@property IBInspectable CGFloat tapCircleDiameterStartValue;

/** The CGFloat value representing the Diameter of the tap-circle. By default it will be the result of MAX(self.frame.width, self.frame.height). tapCircleDiameterFull will calculate a circle that always fills the entire view. Any value less than or equal to tapCircleDiameterFull will result in default being used. The constants: tapCircleDiameterLarge, tapCircleDiameterMedium, and tapCircleDiameterSmall are also available for use. */
@property IBInspectable CGFloat tapCircleDiameter;

/** The CGFloat value representing how much we should increase the diameter of the tap-circle by when we burst it. Default is 100.f. */
@property IBInspectable CGFloat tapCircleBurstAmount;

/** The UIColor to use for the circle which appears where you tap. NOTE: Setting this defeats the "Smart Color" ability of the tap circle. Alpha values less than 1 are recommended. */
@property IBInspectable UIColor *tapCircleColor;

/** The UIColor to fade clear backgrounds to. NOTE: Setting this defeats the "Smart Color" ability of the background fade. Alpha values less than 1 are recommended. */
@property IBInspectable UIColor *backgroundFadeColor;

/** A flag to set to YES to have the tap-circle ripple from point of touch. If this is set to NO, the tap-circle will always ripple from the center of the tab. Default is YES. */
@property (nonatomic) IBInspectable BOOL rippleFromTapLocation;

/** A BOOL flag that determines whether or not to keep the background around after a tap, essentially "highlighting/selecting" the cell. Note that this does not trigger setSelected:! It is purely aesthetic. Also this kinda clashes with cell.selectionStyle, so by defualt the constructor sets that to UITableViewCellSelectionStyleNone.
    Default is YES. */
@property IBInspectable BOOL letBackgroundLinger;

/** A BOOL flag indicating whether or not to always complete a full animation cycle (bg fade in, tap-circle grow and burst, bg fade out) before starting another one. NO will behave just like the other BFPaper controls, tapping rapidly spawns many circles which all fade out in turn. Default is YES. */
@property IBInspectable BOOL alwaysCompleteFullAnimation;

/** A CGFLoat to set the amount of time in seconds to delay the tap event / trigger to spawn circles. For example, if the tapDelay is set to 1.f, you need to press and hold the cell for 1.f seconds to trigger spawning a circle. Default is 0.1f. */
@property IBInspectable CGFloat tapDelay;

/** A UIBezierPath you can set to override the mask path of the ripples and background fade. Set this if you have a custom path for your cell. If this is nil, BFPaperTableViewCell will try its best to provide a correct mask. Default is nil. */
@property IBInspectable UIBezierPath *maskPath;
@end


/*

 свойства
 BOOL usesSmartColor

 Флаг для установки YES для использования Smart Color или NO для использования пользовательской цветовой схемы. Хотя по умолчанию используется Smart Color (использует SmartColor = YES), настройка тоже хороша.

 CGFloat touchDownAnimationDuration

 CGFLoat, представляющий продолжительность анимации, происходящей при касании ВНИЗ! По умолчанию это 0.25fсекунды. (Иди Стилерс)

 CGFloat touchUpAnimationDuration

 CGFLoat, представляющий продолжительность анимаций, которые происходят при касании UP! По умолчанию это 2 * touchDownAnimationDurationсекунды.

 CGFloat tapCircleDiameterStartValue

 CGFLoat, представляющий диаметр круга ответвления, как только он появляется, прежде чем он вырастет. По умолчанию это 5.f.

 CGFloat tapCircleDiameter

 Значение CGFloat, представляющее диаметр круга крана. По умолчанию это будет результат MAX(self.frame.width, self.frame.height). tapCircleDiameterFullрассчитает круг, который всегда заполняет весь вид. Любое значение меньше или равно tapCircleDiameterFullприведет к использованию по умолчанию. Константы: tapCircleDiameterLarge, tapCircleDiameterMediumи tapCircleDiameterSmallтакже доступны для использования.

 CGFloat tapCircleBurstAmount

 Значение CGFloat, представляющее, насколько мы должны увеличить диаметр круга ответвления, когда мы его разрываем. По умолчанию это 100.f.

 UIColor *tapCircleColor

 UIColor использовать для круга, который появляется там, где вы нажимаете. ПРИМЕЧАНИЕ. Установка этого параметра отменяет способность «Умный цвет» круга крана. Альфа-значения меньше 1рекомендуемых.

 UIColor *backgroundFadeColor

 UIColor, чтобы исчезнуть ясный фон для. ПРИМЕЧАНИЕ. При установке этого параметра способность «Умный цвет» исчезает с фона. Альфа-значения меньше 1рекомендуемых.

 BOOL rippleFromTapLocation

 Флаг, чтобы установить, чтобы YESиметь пульсацию круга касания от точки касания. Если для этого параметра установлено NO, круг-метчик всегда будет колебаться от центра обзора. По умолчанию это YES.

 BOOL letBackgroundLinger

 Флаг BOOL, который определяет, стоит ли сохранять фон вокруг после нажатия, по сути, «выделяя / выделяя» ячейку. Обратите внимание, что это не срабатывает setSelected:! Это чисто эстетично. Кроме того, это своего рода cell.selectionStyleпротиворечит, так что по умолчанию конструктор устанавливает это значение UITableViewCellSelectionStyleNone. По умолчанию ДА.

 BOOL alwaysCompleteFullAnimation

 Флаг BOOL, указывающий, нужно ли всегда завершать полный цикл анимации (bg постепенно увеличивать, увеличивать и увеличивать круг, bg исчезать) перед запуском другого. NO будет вести себя так же, как и другие элементы управления BFPaper, быстрое нажатие порождает множество кругов, которые постепенно исчезают. По умолчанию это YES.

 CGFloat tapDelay

 CGFLoat для установки количества времени в секундах для задержки события касания / триггера для появления кругов. Например, если tapDelay установлен на 1.f, вам нужно нажать и удерживать ячейку в течение 1 секунды, чтобы вызвать появление круга. По умолчанию это 0.1f.

 UIBezierPath *maskPath

 UIBezierPath, который вы можете установить для переопределения траектории маски ряби и исчезновения фона. Установите это, если у вас есть собственный путь для вашей ячейки. Если это так nil, BFPaperTableViewCell постарается предоставить правильную маску. По умолчанию это nil.


 */
