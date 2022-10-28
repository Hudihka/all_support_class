

import Foundation
import UIKit


class PinterestLayout: UICollectionViewLayout{
  

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
    guard let collectionView = collectionView else {
      return 0
    }
    return collectionView.bounds.width
  }

  /*
      collectionViewContentSize : этот метод возвращает ширину и высоту содержимого представления коллекции. Вы должны реализовать его так, чтобы он возвращал высоту и ширину всего содержимого представления коллекции, а не только видимого содержимого. Представление коллекции использует эту информацию для настройки размера содержимого представления прокрутки.
   */
  override var collectionViewContentSize: CGSize {
    return CGSize(width: contentWidth, height: contentHeight)
  }
  
  /*
   вычисляем  позицию каждого элемента здесь
   */
  
    //MARK: - prepare()
  
  override func prepare() {
    // мы должны вычислять размеры ячеек только если кэш пустой
    guard cache.isEmpty, let collectionView = collectionView else {
        return
    }
    
    
    /*
     Создает новый массив, содержащий указанное
     количество одного повторяющегося значения.
     
     этот массив будет увеличиваться по мере увеличения числа ячеек
     */
    
    //получаем количество ячеек в секции
    for item in 0..<collectionView.numberOfItems(inSection: 0) {
      //берем индекс по которому рассматривать будем
      let indexPath = IndexPath(item: item, section: 0)
      
      //берем фрейм рамки ячейки с учетом колонки
      let frame = frameToIndex(row: item)
      //создаем фрейм самой ячейки
      let insetFrame = frame.insetBy(dx: 1, dy: 1) //1 это боковые отступы ячейки
      
      // создаем атрибуты самой ячейки и добавляе в кэш архив
      let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      attributes.frame = insetFrame //если не нужно расстояниие между то поставь сюда frame
      cache.append(attributes)
      
      // задаем новое значенгие высоты контента
      contentHeight = frame.maxY
      
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

//MARK: - GABARITES

extension PinterestLayout{
    
    func frameToIndex(row: Int) -> CGRect{
        let point = CGPoint(x: pointXToIndex(row: row),
                            y: pointYToIndex(row: row))
        
        return CGRect(origin: point, size: sizeCellToIndex(row: row))
    }
    
    
    private func sizeCellToIndex(row: Int) -> CGSize{
        
        if row == 0 {
            return CGSize(width: wDevice, height: twoFrie)
        }
        
        return isBigCell(row) ? CGSize(width: twoFrie, height: twoFrie) :
                                CGSize(width: oneFrie, height: oneFrie)
        
    }
    
    
    private func pointXToIndex(row: Int) -> CGFloat{
        
        if row == 0 ||
           isBigLeftCell(index: row) ||
           smallCellLeftUp(index: row) ||
           smallCellLeftDown(index: row){
            return 0
        }
        
        if isBigRightCell(index: row){
            return oneFrie
        }
        
        if smallCellRightUp(index: row) || smallCellRightDown(index: row){
            return twoFrie
        }
        
        
        return CGFloat((row % 6) - 1) * oneFrie
    }
    
    func pointYToIndex(row: Int) -> CGFloat{
        
        if row == 0 {
            return 0
        }
        
        if isRowCell(index: row){
            return yPointRow(index: row)
        }
        
        if smallCellRightUp(index: row) {
            return smallCellRightUpYpoint(index: row)
        }
        
        if smallCellRightDown(index: row){
            return smallCellRightDownYpoint(index: row)
        }
        
        if smallCellLeftUp(index: row){
            return smallCellLeftUpYpoint(index: row)
        }
        
        if smallCellLeftDown(index: row){
            return smallCellLeftDownYpoint(index: row)
        }
        
        
        if isBigLeftCell(index: row){
            return bigCellLeftYpoint(index: row)
        }
        
        if isBigRightCell(index: row){
            return bigCellRightYpoint(index: row)
        }
        
        
//        if smallCellRightUp(index: row) || smallCellRightDown(index: row){
//            return twoFrie
//        }
        
        
        return CGFloat((row % 6) - 1) * oneFrie
    }
    
    
    //MARK: - большие ячейки
    
    private func isBigCell(_ index: Int) -> Bool{
        return isBigRightCell(index: index) || isBigLeftCell(index: index)
    }
    
    private func isBigRightCell(index: Int) -> Bool{
        return index % 12 == 0
    }
    
    private func isBigLeftCell(index: Int) -> Bool{
        return index == 4 || index % 12 == 4
    }
    
    //MARK: - мелкие ячейки
    
    /*мелкая ячейка с лево в верху*/
    private func smallCellLeftUp(index: Int) -> Bool{
        return (index + 2) % 12 == 0
    }
    
    /*мелкая ячейка с лево в низу*/
    private func smallCellLeftDown(index: Int) -> Bool{

        return (index + 1) % 12 == 0
    }
    
    /*мелкая ячейка с право в верху*/
    private func smallCellRightUp(index: Int) -> Bool{
        return (index - 5) % 12 == 0
    }
    
    /*мелкая ячейка с право в низу*/
    private func smallCellRightDown(index: Int) -> Bool{
        return (index - 6) % 12 == 0
    }
    
    //ячейки в ряд
    private func isRowCell(index: Int) -> Bool{
        if index % 6 > 0, index % 6 < 4 {
            return true
        }
        
        return false
    }
    
    
    //MARK: y Позиция
    
    private func yPointRow(index: Int) -> CGFloat{
        
        let ost: CGFloat = CGFloat(index / 6)
        let k = ost * wDevice
        
        return twoFrie + k
    }

    func smallCellRightUpYpoint(index: Int) -> CGFloat{
        return wDevice * CGFloat((index + 1)/6)
    }
    
    func smallCellRightDownYpoint(index: Int) -> CGFloat{
        return oneFrie + (wDevice * CGFloat(index / 6))
    }
    
    ////
    func smallCellLeftUpYpoint(index: Int) -> CGFloat{
        if index == 10 {
            return 2 * wDevice
        }
        let k: CGFloat = CGFloat((index - 10)/6)
        return wDevice * (k + 2)
    }
    
    
    func smallCellLeftDownYpoint(index: Int) -> CGFloat{

        let upPosition = smallCellLeftUpYpoint(index: index - 1)

        return upPosition + oneFrie
    }
    
    func bigCellLeftYpoint(index: Int) -> CGFloat{
        let k: CGFloat = CGFloat((index + 2)/6)
        return wDevice * k
    }
    
    func bigCellRightYpoint(index: Int) -> CGFloat{
        return wDevice * CGFloat(index) / 6
    }
    
    
}
