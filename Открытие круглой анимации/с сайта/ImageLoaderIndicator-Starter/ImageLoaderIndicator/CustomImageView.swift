/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
import UIKit

class CustomImageView: UIImageView {

  let progressIndicatorView = CircularLoaderView (frame: .zero)

  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    addSubview(progressIndicatorView)

    /*
     добавляете два ограничения макета, чтобы гарантировать,
     что представление индикатора прогресса остается того же размера, что и представление изображения


     ПРИИМЕР

     | SuperView

     - стандартный интервал (обычно 8 баллов; значение можно изменить,
        если это интервал до края суперпредставления)

     == одинаковая ширина (может быть опущена)

     -20- нестандартный интервал (20 баллов)
     <= меньше или равно
     >= больше или равно
     @250приоритет ограничения; может иметь любое значение от 0 до 1000
     250 - низкий приоритет
     750 - высокий приоритет
     1000 - обязательный приоритет
     Пример формата строки
     H : | - [icon (== iconDate)] - 20 - [iconLabel ( 120 @ 250 )] - 20 @ 750 - [iconDate (> = 50 )] - |

     Вот пошаговое объяснение этой строки:

     H: горизонтальное направление

     |-[icon Передний край иконки должен иметь стандартное расстояние от переднего края суперпредставления.

     ==iconDate ширина значка должна быть равна ширине iconDate.

     ]-20-[iconLabel Задний край значка должен быть в 20 точках от переднего края iconLabel.

     [iconLabel(120@250)]iconLabel должен иметь ширину 120 точек. Приоритет установлен на низкий уровень, и автоматическое расположение может нарушить это ограничение в случае возникновения конфликта.

     -20@750-Задний край iconLabel должен быть в 20 точках от переднего края iconDate. Приоритет установлен на высокий уровень, поэтому автоматическое расположение не должно нарушать это ограничение в случае конфликта.
     [iconDate(>=50)] Ширина iconDate должна быть больше или равна 50 точкам.
     -| Задний край iconDate должен иметь стандартное расстояние от заднего края своего суперпредставления.
     */



    let constreintVertical = NSLayoutConstraint.constraints(withVisualFormat: "V:|[v]|",
                                                    options: .init(rawValue: 0),
                                                    metrics: nil,
                                                    views: ["v": progressIndicatorView])

    let constreintHorizontal = NSLayoutConstraint.constraints(withVisualFormat: "H:|[v]|",
                                                              options: .init(rawValue: 0),
                                                              metrics: nil,
                                                              views:  ["v": progressIndicatorView])

    addConstraints(constreintVertical)
    addConstraints(constreintHorizontal)

    //нельзя менять позицию

    progressIndicatorView.translatesAutoresizingMaskIntoConstraints = false

    
    let url = URL(string: "https://koenig-media.raywenderlich.com/uploads/2015/02/mac-glasses.jpeg")
    sd_setImage(with: url, placeholderImage: nil, options: .cacheMemoryOnly, progress:
      { [weak self] receivedSize, expectedSize, _ in
      // Update progress here
        self?.progressIndicatorView.progress = CGFloat(receivedSize) / CGFloat(expectedSize)
        //полученный обьем на загруженный

      }) { [weak self] _, error, _, _ in
        if let error = error {
          print(error)
        }
        
        self?.progressIndicatorView.reveal()

    }
  }
  
}
