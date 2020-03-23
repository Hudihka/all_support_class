/// Copyright (c) 2017 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

//--------------1

class FlipPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {


  //инициализация говорящая о том что что мы собираемся использовать повернутую карточку для начала перехода
  private let originFrame: CGRect
  
  init(originFrame: CGRect) {
    self.originFrame = originFrame
  }


  //длительность перехода \метод делегатта\
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 3
  }

  //метод делегатта сообсттвенно где и описываем анимацию
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {


    /*
     Извлеките ссылку как на заменяемый контроллер представления, так и на представляемый.
     Сделайте снимок того, как будет выглядеть экран после перехода.
     */
    
    guard let fromVC = transitionContext.viewController(forKey: .from), //заменяемый
      let toVC = transitionContext.viewController(forKey: .to),         //какой будет
      let snapshot = toVC.view.snapshotView(afterScreenUpdates: true)   //снимок(фолз это текущее состояние, ттру конечное, после изменений)
      else {
        return
    }

    /*
     UIKit инкапсулирует весь переход внутри контейнерного представления,
     чтобы упростить управление иерархией представления и анимациями.
     Получите ссылку на контейнерное представление и определите,
     каким будет последний кадр нового представления.
     */
    
    let containerView = transitionContext.containerView
    let finalFrame = transitionContext.finalFrame(for: toVC) //конечный размер

    /*
     Сконфигурируйте рамку и чертеж снимка так,
     чтобы он точно совпадал и покрывал карту в виде «из».
     */
    
    snapshot.frame = originFrame
    snapshot.layer.cornerRadius = CardViewController.cardCornerRadius
    snapshot.layer.masksToBounds = true


    containerView.addSubview(toVC.view) /*добавляем в контейнер вью вью будущего контроллера к котторому мы идем*/
    containerView.addSubview(snapshot)   //добавляем снимок после иизменений
    toVC.view.isHidden = true           /*говорим что конечный вью прозрачный*/
    
    AnimationHelper.perspectiveTransform(for: containerView) // перспектива просмотра на вью
    snapshot.layer.transform = AnimationHelper.yRotation(.pi / 2) //поворачиваем снимок по оси игрик
    let duration = transitionDuration(using: transitionContext) //ну и длительностть
    
    UIView.animateKeyframes( //анимации одна за другой
      withDuration: duration,
      delay: 0,
      options: .calculationModeCubic,
      animations: {

        //Начните с поворота вида «из» на 90˚ вокруг своей оси y, чтобы скрыть его от вида.

        UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/3) { //задержка а поттом время движения относительно duration
          fromVC.view.layer.transform = AnimationHelper.yRotation(-.pi / 2)
        }

        //поскольку моментальный снимок второго экрана скрыт, мы его поворачиваем лицом
        UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3) {
          snapshot.layer.transform = AnimationHelper.yRotation(0.0)
        }

        //снапшот делаем во весь экран и убираем круглые углы
        UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3) {
          snapshot.frame = finalFrame
          snapshot.layer.cornerRadius = 0
        }
    },
      completion: { _ in
        //после завершения конечный вью конроллер больше не скрытт
        toVC.view.isHidden = false
        //удаляем снапшот
        snapshot.removeFromSuperview()
        //возвращаем в начальное положение вид из тк он сейчас повернут
        fromVC.view.layer.transform = CATransform3DIdentity
        //анимация завершена
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    })
  }
}

