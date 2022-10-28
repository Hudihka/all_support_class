//
//  ViewController.swift
//  SwipeCell
//
//  Created by Константин Ирошников on 04.08.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private var array: [String] = []

    private var openCell: SwipeCellProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        createContent()

        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(
            SwipeCell.self,
            forCellReuseIdentifier: SwipeCell.className
        )
    }

    private func createContent() {
        for _ in 0...50 {
            array.append(randomString)
        }
    }

    private var randomString: String {
        let length = 10 + arc4random_uniform(30)
        let letters = "a bcd efghijk lmnopqr st uv wx yz ABCDEFG HIJKLMNO PQRSTUVW XY Z012 345 6789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        72
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        openCell?.closeCell()
    }

//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        true
//    }
//
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let redActions = UIContextualAction(
//            style: .normal,
//            title: "Удалить"
//        ) {  (contextualAction, view, boolValue) in
//            print("-----")
//        }
//
//        let greenActions = UIContextualAction(
//            style: .normal,
//            title: "Поделиться ссылкой"
//        ) {  (contextualAction, view, boolValue) in
//            print("-----")
//        }
//
//        let blueActions = UIContextualAction(
//            style: .destructive,
//            title: "Отправить PDF"
//        ) {  (contextualAction, view, boolValue) in
//            print("-----")
//        }
//
//        redActions.backgroundColor = .red
//        greenActions.backgroundColor = .green
//        blueActions.backgroundColor = .blue
//
//        redActions.image = UIImage(systemName: "paperplane")
//        greenActions.image = UIImage(systemName: "keyboard")
//        blueActions.image = UIImage(systemName: "tv.fill")
//
//        let swipeActions = UISwipeActionsConfiguration(actions: [redActions, greenActions, blueActions])
//        swipeActions.performsFirstActionWithFullSwipe = false
//
//        return swipeActions
//    }
//
//    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
//        print("---0")
//        return true
//    }
//
//    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
//        print("---1233")
//    }
//
//    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
//        print("---12")
//    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        array.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: SwipeCell.className,
                for: indexPath
            ) as? SwipeCell
        else {
            fatalError("DequeueReusableCell failed while casting")
        }

        updateCellOpen(cell)
        cell.textCell = array[indexPath.row]

        return cell
    }

    private func updateCellOpen(_ cell: UITableViewCell) {
        guard var cellProtocol = cell as? SwipeCellProtocol else {
            return
        }

        cellProtocol.onPan = { [weak self] in
            self?.openCell?.closeCell()
        }

        cellProtocol.openCell = { [weak self] newCell in
            self?.openCell = newCell
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.openCell?.closeCell()
    }
}

extension NSObject {
    class var className: String {
        String(describing: self)
    }
}

extension UISwipeActionsConfiguration {

    public static func makeTitledImage(
        image: UIImage?,
        title: String,
        textColor: UIColor = .white,
        font: UIFont = .systemFont(ofSize: 10),
        size: CGSize = .init(width: 50, height: 50)
    ) -> UIImage? {

        /// Create attributed string attachment with image
        let attachment = NSTextAttachment()
        attachment.image = image
        let imageString = NSAttributedString(attachment: attachment)

        /// Create attributed string with title
        let text = NSAttributedString(
            string: "\n\(title)",
            attributes: [
                .foregroundColor: textColor,
                .font: font
            ]
        )

        /// Merge two attributed strings
        let mergedText = NSMutableAttributedString()
        mergedText.append(imageString)
        mergedText.append(text)

        /// Create label and append that merged attributed string
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        label.textAlignment = .center
        label.numberOfLines = 2
        label.attributedText = mergedText

        /// Create image from that label
        let renderer = UIGraphicsImageRenderer(bounds: label.bounds)
        let image = renderer.image { rendererContext in
            label.layer.render(in: rendererContext.cgContext)
        }

        /// Convert it to UIImage and return
        if let cgImage = image.cgImage {
            return UIImage(cgImage: cgImage, scale: UIScreen.main.scale, orientation: .up)
        }

        return nil
    }
}
