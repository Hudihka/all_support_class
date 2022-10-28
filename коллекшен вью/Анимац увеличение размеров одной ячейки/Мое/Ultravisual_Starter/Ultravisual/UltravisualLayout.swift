/// Copyright (c) 2018 Razeware LLC
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

// Высоты объявлены как константы вне класса, поэтому на них можно легко ссылаться в другом месте
struct UltravisualLayoutConstants {
  struct Cell {
    // Высота неэкспонированной ячейки
    static let standardHeight: CGFloat = 100
    // Высота первой видимой ячейки
    static let featuredHeight: CGFloat = 280
  }
}

// MARK: Properties and Variables

class UltravisualLayout: UICollectionViewLayout {
  // Количество, которое пользователь должен прокрутить перед изменением выделенной ячейки
  let dragOffset: CGFloat = 180.0
  
  var cache: [UICollectionViewLayoutAttributes] = []
  
  // Возвращает индекс элемента выбранной ячейки
  var featuredItemIndex: Int {
      // Используйте max, чтобы убедиться, что featureItemIndex никогда не <0
      
      return max(0, Int(collectionView!.contentOffset.y / dragOffset))
  }
  
  // Возвращает значение от 0 до 1, которое показывает, насколько близка следующая ячейка к выделенной ячейке
  var nextItemPercentageOffset: CGFloat {
      return (collectionView!.contentOffset.y / dragOffset) - CGFloat(featuredItemIndex)
  }
  
  // Возвращает ширину представления коллекции
  var width: CGFloat {
      return collectionView!.bounds.width
  }
  
  // возвращает высоту коллекци
  var height: CGFloat {
      return collectionView!.bounds.height
  }
  
  // Возвращает количество элементов в представлении коллекции
  var numberOfItems: Int {
      return collectionView!.numberOfItems(inSection: 0)
  }
}

// MARK: UICollectionViewLayout

extension UltravisualLayout {
  // Возвращаем размер всего содержимого в представлении коллекции
  override var collectionViewContentSize : CGSize {
    let contentHeight = (CGFloat(numberOfItems) * dragOffset) + (height - dragOffset)
    return CGSize(width: width, height: contentHeight)
  }
  
  override func prepare() {
    //чистим массив
    cache.removeAll(keepingCapacity: false)
    
    let standardHeight = UltravisualLayoutConstants.Cell.standardHeight
    let featuredHeight = UltravisualLayoutConstants.Cell.featuredHeight
      
    var frame = CGRect.zero
    var y: CGFloat = 0
    
    for item in 0..<numberOfItems {
      // берем ячейку по индексу и создаем для нее атрибуты
      let indexPath = IndexPath(item: item, section: 0)
      let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      
      //увеличиваем z индекс с низу в верх
      attributes.zIndex = item
      var height = standardHeight
      
      //Если ячейка в настоящее время находится в позиции признаковой ячейки
      if indexPath.item == featuredItemIndex {
        // 4
        let yOffset = standardHeight * nextItemPercentageOffset //это значение сколько уже заскроллено вверх
        y = collectionView!.contentOffset.y - yOffset
        height = featuredHeight //если это ячейка что нам нужна ее высота максимальная
      } else if indexPath.item == (featuredItemIndex + 1) && indexPath.item != numberOfItems {
        // Если ячейка следующая в строке, вы начинаете с вычисления наибольшего значения
        let maxY = y + standardHeight
        
        height = standardHeight + max((featuredHeight - standardHeight) * nextItemPercentageOffset, 0)
        y = maxY - height
      }
      
      // создаем фрейм ячейки,
      frame = CGRect(x: 0, y: y, width: width, height: height)
      
//      print("frame.minY \(frame.minY) - frame.maxY \(frame.maxY)")
      attributes.frame = frame
      cache.append(attributes)
      //значение у берем в конце что бы добавить если что новую ячейку
      y = frame.maxY
    }

  }
  
  // Возвращаем все атрибуты в кеше,
  //фрейм которых пересекается с прямоугольником, переданным методу
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    var layoutAttributes: [UICollectionViewLayoutAttributes] = []
    for attributes in cache {
      if attributes.frame.intersects(rect) {
        layoutAttributes.append(attributes)
      }
    }
    return layoutAttributes
  }
  
  
  // Возвращаем true, чтобы макет постоянно аннулировался при прокрутке пользователя
  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }
  
  
  
  override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                    withScrollingVelocity velocity: CGPoint) -> CGPoint {
    
    /*
     Когда пользователь поднимает палец после прокрутки, в то время как скорость прокрутки еще остается, этот метод будет смотреть в будущее и сообщать вам, где именно закончится прокрутка, благодаря proposedContentOffset. Возвращая другую точку прокрутки, вы можете сделать представление коллекции в конечном итоге прямо на ровной границе с выделенной ячейкой.

     Все, что вы делаете в реализации, - это находите ближайший элемент к предлагаемому смещению содержимого, а затем возвращаете тот, CGPointкоторый расположен так, чтобы элемент находился прямо в верхней части экрана.
     */

    let itemIndex = round(proposedContentOffset.y / dragOffset)
    let yOffset = itemIndex * dragOffset
    return CGPoint(x: 0, y: yOffset)
  }

}
