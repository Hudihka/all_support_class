

import Foundation
import UIKit

/*
 с помошью этого прот окола будем получать высоту фотографии
 */
protocol PinterestLayoutDelegate: AnyObject {
  func collectionView(_ collectionView: UICollectionView,
                      heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat
}


class PinterestLayout: UICollectionViewLayout{
  
  
  weak var delegate: PinterestLayoutDelegate?

  // 2
  private let numberOfColumns = 2       //количество столбцов
  private let cellPadding: CGFloat = 6  //отступы в верху и низу

  /*
   Это массив для кэширования вычисляемых атрибутов.
   Когда вы звоните prepare(), вы рассчитываете атрибуты для
   всех элементов и добавляете их в кеш. Когда представление
   коллекции позднее запрашивает атрибуты макета, вы можете
   эффективно запрашивать кэш, а не каждый раз пересчитывать их.
   */
  private var cache: [UICollectionViewLayoutAttributes] = []

  /*
   Вы увеличиваете по contentHeightмере добавления фотографий
   и рассчитываете contentWidthна основе ширины представления
   коллекции и вставки ее содержимого.
   */
  private var contentHeight: CGFloat = 0

  private var contentWidth: CGFloat { //ширина контента
    //те ширина коллекции без правого и левого отступа
    guard let collectionView = collectionView else {
      return 0
    }
    let insets = collectionView.contentInset
    return collectionView.bounds.width - (insets.left + insets.right)
  }

  /*
      collectionViewContentSize : этот метод возвращает ширину и высоту содержимого представления коллекции. Вы должны реализовать его так, чтобы он возвращал высоту и ширину всего содержимого представления коллекции, а не только видимого содержимого. Представление коллекции использует эту информацию для настройки размера содержимого представления прокрутки.
   */
  override var collectionViewContentSize: CGSize {
    return CGSize(width: contentWidth, height: contentHeight)
  }
  
  /*
      prepare () : всякий раз, когда собирается выполнить
   операцию макета, UIKit вызывает этот метод. Это ваша возможность
   подготовить и выполнить любые вычисления, необходимые
   для определения размера представления коллекции и расположения элементов.
   
   -------------------------
   
   короче говоря вычисляем  позицию каждого элемента здесь
   */
  
    //MARK: - prepare()
  
  override func prepare() {
    // мы должны вычислять размеры ячеек только если кэш пустой
    guard cache.isEmpty, let collectionView = collectionView else {
        return
    }
    
    // это ширина ячейки
    let columnWidth = contentWidth / CGFloat(numberOfColumns)
    //это массив Х кординат для построения ячейки
    //те [0, половина дисплея]
    var xOffset: [CGFloat] = []
    for column in 0..<numberOfColumns {
      xOffset.append(CGFloat(column) * columnWidth)
    }
    
    /*
     Создает новый массив, содержащий указанное
     количество одного повторяющегося значения.
     
     этот массив будет увеличиваться по мере увеличения числа ячеек
     */

    var column = 0
    var yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumns)
    
    //получаем количество ячеек в секции
    for item in 0..<collectionView.numberOfItems(inSection: 0) {
      //берем индекс по которому рассматривать будем
      let indexPath = IndexPath(item: item, section: 0)
      
      // получаем высоту фото по индексу
      let photoHeight = delegate?.collectionView(collectionView,
                                                 heightForPhotoAtIndexPath: indexPath) ?? 180
      //высота рамки ячейки с отступами
      let height = cellPadding * 2 + photoHeight
      
      //берем фрейм рамки ячейки с учетом колонки
      let frame = CGRect(x: xOffset[column],
                         y: yOffset[column],
                         width: columnWidth,
                         height: height)
      //создаем фрейм самой ячейки
      let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
      
      // создаем атрибуты самой ячейки и добавляе в кэш архив
      let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      attributes.frame = insetFrame //если не нужно расстояниие между то поставь сюда frame
      cache.append(attributes)
      
      // задаем новое значенгие высоты контента
      contentHeight = max(contentHeight, frame.maxY)
      
      //задаем новое значение высоты контента столбца
      yOffset[column] = yOffset[column] + height
          
      //меняем столбец если это крайний с права то снова ставим 0
      column = column < (numberOfColumns - 1) ? (column + 1) : 0
    }
  }
  
  //MARK: - layoutAttributesForElements (in :)
  
  /*
      layoutAttributesForElements (in :) : В этом методе вы возвращаете атрибуты макета для всех элементов внутри данного прямоугольника. Вы возвращаете атрибуты в представление коллекции как массив UICollectionViewLayoutAttributes.
   --------------
   вызывается после prepare
   */
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
    
    // Перебрать кеш и искать элементы в прямоугольнике
    for attributes in cache {
      //пересекаются ли 2 прямоугольниика
      if attributes.frame.intersects(rect) {
        visibleLayoutAttributes.append(attributes)
      }
    }
    
    //возвращаем массив атрибутов для тех ячеек что сейчас на экране
    return visibleLayoutAttributes
  }
  
  
  //MARK: - layoutAttributesForItem
  
  /*
   layoutAttributesForItem (at :) : Этот метод предоставляет информацию макета по требованию представлению коллекции. Вам необходимо переопределить его и вернуть атрибуты макета для элемента по запросу indexPath.
   --------------
   короче атрибуты ячейки
   */
  
  
  override func layoutAttributesForItem(at indexPath: IndexPath)
      -> UICollectionViewLayoutAttributes? {
    return cache[indexPath.item]
  }

}

