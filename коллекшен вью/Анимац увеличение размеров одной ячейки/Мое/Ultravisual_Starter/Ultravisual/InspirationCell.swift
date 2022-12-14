
import UIKit

class InspirationCell: UICollectionViewCell {
  static let reuseIdentifier = String(describing: InspirationCell.self)
    
  @IBOutlet private weak var imageView: UIImageView!
  @IBOutlet private weak var imageCoverView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  
  @IBOutlet private weak var timeAndRoomLabel: UILabel!
  @IBOutlet private weak var speakerLabel: UILabel!

  
  var inspiration: Inspiration? {
    didSet {
      if let inspiration = inspiration {
        imageView.image = inspiration.backgroundImage
        titleLabel.text = inspiration.title
        
        timeAndRoomLabel.text = inspiration.roomAndTime
        speakerLabel.text = inspiration.speaker
      }
    }
  }
  
  override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
    super.apply(layoutAttributes)
    
    
    //Механизм благодаря которому и меняем альфу
    let standardHeight = UltravisualLayoutConstants.Cell.standardHeight
    let featuredHeight = UltravisualLayoutConstants.Cell.featuredHeight
    
    let delta = 1 - ((featuredHeight - frame.height) / (featuredHeight - standardHeight))
    
    let minAlpha: CGFloat = 0.3
    let maxAlpha: CGFloat = 0.75
    imageCoverView.alpha = maxAlpha - (delta * (maxAlpha - minAlpha))
    
    
    //здесь меняем размер текста
    
    let scale = max(delta, 0.5)
    titleLabel.transform = CGAffineTransform(scaleX: scale, y: scale)
    
    
    timeAndRoomLabel.alpha = delta
    speakerLabel.alpha = delta
    
  }

}
