//
//  Utils.swift
//  Ceorooms
//
//

import UIKit
import CommonCrypto
import PassKit

enum Utils {
    // MARK: - External apps

    static func openUrl(_ url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }

    static func openSystemSettings() {
        if let url = URL(string: "App-Prefs:") {
            openUrl(url)
        }
    }

    static func openAppSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            openUrl(url)
        }
    }

    static func call(phone: String) {
        if let url = URL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.openURL(url)
        }
    }
}

class TouchthruView: UIView {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for view in self.subviews {
            if view.isHidden {
                continue
            }
            if view.bounds.contains(view.convert(point, from: self)) {
                return true
            }
        }
        return false
    }
}

extension NSObject {
    class var className: String {
        return String(describing: self)
    }
}

extension Collection {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension String {
    func highlighted(string: String, color: UIColor, defaultTextColor: UIColor) -> NSAttributedString {
        let attributes = [NSAttributedString.Key.foregroundColor: defaultTextColor] as [NSAttributedString.Key: Any]
        let attributedString = NSMutableAttributedString(string: self, attributes: attributes)

        guard let range = self.range(of: string) else {
            return attributedString
        }

        let highlightAttributes = [NSAttributedString.Key.foregroundColor: color] as [NSAttributedString.Key: Any]
        attributedString.addAttributes(highlightAttributes, range: NSRange(range, in: self))

        return attributedString
    }

    func getDigits() -> String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
}

// MARK: - UILabel

extension UILabel {
    func highlight(string: String, color: UIColor) {
        if let text = self.text, let range = text.range(of: string) {
            let attributedString = NSMutableAttributedString(string: text)
            let attributes = [NSAttributedString.Key.foregroundColor: color] as [NSAttributedString.Key: Any]
            attributedString.addAttributes(attributes, range: NSRange(range, in: text))

            attributedText = attributedString
        }
    }

    func getRange(word: String) -> NSRange? { //получить ранг в тексте
        if let text = self.text, let termsRange = text.range(of: word) {
            return NSRange(termsRange, in: text)
        }
        return nil
    }
}

extension Range where Bound == String.Index {
    init (from: Int, to: Int) {
        self.init(uncheckedBounds: (String.Index(encodedOffset: from), String.Index(encodedOffset: to)))
    }
}

func randomString(WithLength len: Int) -> String {
    let letters: NSString = "abcdefABCDEF123456789"

    let randomString: NSMutableString = NSMutableString(capacity: len)

    for _ in 0 ..< len {
        let length = UInt32 (letters.length)
        let rand = arc4random_uniform(length)
        randomString.appendFormat("%C", letters.character(at: Int(rand)))
    }

    return randomString as String
}

class WeakRef<T> where T: AnyObject {
    private(set) weak var value: T?

    init(value: T?) {
        self.value = value
    }
}

extension Array where Element == WeakRef<AnyObject> {
    mutating func reap () {
        self = self.filter { nil != $0.value }
    }

    func strongify() -> [AnyObject] {
        return self.compactMap { $0.value }
    }
}

class BTTimer {
    private static var date: Date = Date()

    private var date: Date
    private var name: String

    static func start() {
        print("TIMER: started")
        date = Date()
    }

    static func log(_ string: String) {
        let time = -date.timeIntervalSinceNow
        print(String(format: "TIMER: %f - %@", time, string))
        date = Date()
    }

    init(_ nm: String) {
        name = nm
        print("TIMER(\(name)): started")
        date = Date()
    }

    func log(_ string: String? = nil) {
        let time = -date.timeIntervalSinceNow
        print(String(format: "TIMER(\(name)): %f - %@", time, string ?? "finished"))
        date = Date()
    }
}

extension Sequence {
    public func toDictionary<Key: Hashable>(with selectKey: (Iterator.Element) -> Key) -> [Key: Iterator.Element] {
        var dict: [Key: Iterator.Element] = [:]
        for element in self {
            dict[selectKey(element)] = element
        }
        return dict
    }
}

public extension UIWindow {
    public var visibleViewController: UIViewController? {  //UIApplication.shared.keyWindow?.visibleViewController получить активный ВК
        return UIWindow.getVisibleViewControllerFrom(self.rootViewController)
    }

    public static func getVisibleViewControllerFrom(_ vc: UIViewController?) -> UIViewController? {
        if let nc = vc as? UINavigationController {
            return UIWindow.getVisibleViewControllerFrom(nc.visibleViewController)
        } else if let tc = vc as? UITabBarController {
            return UIWindow.getVisibleViewControllerFrom(tc.selectedViewController)
        } else {
            if let pvc = vc?.presentedViewController {
                return UIWindow.getVisibleViewControllerFrom(pvc)
            } else {
                return vc
            }
        }
    }
}

extension String {
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }

    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }

    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let attributes = [NSAttributedString.Key.font: font]
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let attributes = [NSAttributedString.Key.font: font]
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)

        return ceil(boundingBox.width)
    }

    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }

    init?(_ int: Int?) {
        if let nonnil = int {
            self.init(nonnil)
        }
        return nil
    }
}

extension String {
    func localized(_ lang: String) -> String {
        if let path = Bundle.main.path(forResource: lang, ofType: "lproj"), let bundle = Bundle(path: path) {
            return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
        }
        return self
    }

    func md5() -> String {
        if let messageData = self.data(using: .utf8) {
            var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))

            _ = digestData.withUnsafeMutableBytes { digestBytes in
                messageData.withUnsafeBytes { messageBytes in
                    CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
                }
            }

            return digestData.map { String(format: "%02hhx", $0) }.joined()
        }
        return self
    }
}

extension NSObject {
    static func performOnce(selector: Selector, afterDelay delay: TimeInterval, with object: Any? = nil) {
        cancelPreviousPerformRequests(withTarget: self, selector: selector, object: nil)
        self.perform(selector, with: object, afterDelay: delay)
    }

    func performOnce(selector: Selector, afterDelay delay: TimeInterval, with object: Any? = nil) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: selector, object: nil)
        self.perform(selector, with: object, afterDelay: delay)
    }
}

enum HMACAlgorithm {
    case MD5, SHA1, SHA224, SHA256, SHA384, SHA512

    func toCCHmacAlgorithm() -> CCHmacAlgorithm {
        var result: Int = 0
        switch self {
        case .MD5:
            result = kCCHmacAlgMD5

        case .SHA1:
            result = kCCHmacAlgSHA1

        case .SHA224:
            result = kCCHmacAlgSHA224

        case .SHA256:
            result = kCCHmacAlgSHA256

        case .SHA384:
            result = kCCHmacAlgSHA384

        case .SHA512:
            result = kCCHmacAlgSHA512
        }
        return CCHmacAlgorithm(result)
    }

    func digestLength() -> Int {
        var result: CInt = 0
        switch self {
        case .MD5:
            result = CC_MD5_DIGEST_LENGTH

        case .SHA1:
            result = CC_SHA1_DIGEST_LENGTH

        case .SHA224:
            result = CC_SHA224_DIGEST_LENGTH

        case .SHA256:
            result = CC_SHA256_DIGEST_LENGTH

        case .SHA384:
            result = CC_SHA384_DIGEST_LENGTH

        case .SHA512:
            result = CC_SHA512_DIGEST_LENGTH
        }
        return Int(result)
    }
}

extension String {
    func hmac(algorithm: HMACAlgorithm, key: String) -> String {
        var digest = [UInt8](repeating: 0, count: Int(algorithm.digestLength()))
        CCHmac(CCHmacAlgorithm(algorithm.toCCHmacAlgorithm()), key, key.count, self, self.count, &digest)
        let data = Data(bytes: digest)
        return data.map { String(format: "%02hhx", $0) }.joined()
    }
}

public extension UIDevice {
    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else {
                return identifier
            }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod5,1": return "iPod Touch 5"
            case "iPod7,1": return "iPod Touch 6"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3": return "iPhone 4"
            case "iPhone4,1": return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2": return "iPhone 5"
            case "iPhone5,3", "iPhone5,4": return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2": return "iPhone 5s"
            case "iPhone7,2": return "iPhone 6"
            case "iPhone7,1": return "iPhone 6 Plus"
            case "iPhone8,1": return "iPhone 6s"
            case "iPhone8,2": return "iPhone 6s Plus"
            case "iPhone9,1", "iPhone9,3": return "iPhone 7"
            case "iPhone9,2", "iPhone9,4": return "iPhone 7 Plus"
            case "iPhone8,4": return "iPhone SE"
            case "iPhone10,1", "iPhone10,4": return "iPhone 8"
            case "iPhone10,2", "iPhone10,5": return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6": return "iPhone X"
            case "iPhone11,2": return "iPhone XS"
            case "iPhone11,4", "iPhone11,6": return "iPhone XS Max"
            case "iPhone11,8": return "iPhone XR"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4": return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3": return "iPad 3"
            case "iPad3,4", "iPad3,5", "iPad3,6": return "iPad 4"
            case "iPad4,1", "iPad4,2", "iPad4,3": return "iPad Air"
            case "iPad5,3", "iPad5,4": return "iPad Air 2"
            case "iPad6,11", "iPad6,12": return "iPad 5"
            case "iPad7,5", "iPad7,6": return "iPad 6"
            case "iPad2,5", "iPad2,6", "iPad2,7": return "iPad Mini"
            case "iPad4,4", "iPad4,5", "iPad4,6": return "iPad Mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9": return "iPad Mini 3"
            case "iPad5,1", "iPad5,2": return "iPad Mini 4"
            case "iPad6,3", "iPad6,4": return "iPad Pro (9.7-inch)"
            case "iPad6,7", "iPad6,8": return "iPad Pro (12.9-inch)"
            case "iPad7,1", "iPad7,2": return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad7,3", "iPad7,4": return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4": return "iPad Pro (11-inch)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8": return "iPad Pro (12.9-inch) (3rd generation)"
            case "AppleTV5,3": return "Apple TV"
            case "AppleTV6,2": return "Apple TV 4K"
            case "AudioAccessory1,1": return "HomePod"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default: return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }

        return mapToDevice(identifier: identifier)
    }()
}

// MARK: - UIViewController

extension UIViewController {
    func presentAlertAPay() {
        let textTitle = "Оплата не удалась"
        let textMessage = "Выберите другую карту"

        let textOk = "ОК"

        let alert = UIAlertController(title: textTitle, message: textMessage, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: textOk, style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func isZeroCartInAccount() -> Bool { //выдает да если 0 карт у аккаунта или нет активной
        if self.countCard() == 0 {
            return true
        }
        guard let myAccountCard = DefaultsUtils.currentAccount()?.getCartAccaunt() else {
            return true
        }
        return myAccountCard.filter({ $0.isActive == true }).isEmpty
    }

    func someCard() -> Bool { //есть ли активная карта
        if let myAccountCartds = DefaultsUtils.currentAccount()?.getCartAccaunt() {
            return !myAccountCartds.filter({ $0.isActive ?? false }).isEmpty
        }

        return false
    }

    func countCard() -> Int { //сколько карт у аккаунта
        if let myAccount = DefaultsUtils.currentAccount() {
            return myAccount.getCartAccaunt().count
        }
        return 0
    }

    func isApplePayActiveCard() -> Bool { //выдает YES если активная карта эпл пей

        if let myAccountCartds = DefaultsUtils.currentAccount()?.getCartAccaunt() {
            return !myAccountCartds.filter({ $0.isActive ?? false && $0.isCardAPay() }).isEmpty
        }

        return false
    }

    func buttonback(_ title: String? = nil, vc: UIViewController) { //сл вью контроллер будет с кнопкой назад или другим титульником
        self.navigationController?.pushViewController(vc, animated: true)
        let textTitle = title ?? "Назад"
        let backButton: UIBarButtonItem = UIBarButtonItem(title: textTitle, style: .bordered, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
    }

    func clearTitle() { //чистим титульник
        let color = UIColor.clear
        let textAttributes = [NSAttributedString.Key.foregroundColor: color]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
    }

    func noClearTitle() { //чистим титульник
        let color = UIColor.white
        let textAttributes = [NSAttributedString.Key.foregroundColor: color]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
    }

    func addshadow(view: UIView, viewW: Double, viewH: Double) {//тень на 3х сторонах
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        view.layer.shadowRadius = 4.0
        view.layer.shadowOpacity = 1
        view.layer.shadowColor = SupportClass.Colors.shadowColor.cgColor

        let path = UIBezierPath()

        // Move to the Bottom Right Corner
        path.move(to: CGPoint(x: viewW, y: viewH + 5))

        // Move to the Bottom Left Corner
        path.addLine(to: CGPoint(x: 0.0, y: viewH + 5))

        // Start at the Top Left Corner
        path.addLine(to: CGPoint(x: 0.0, y: 10))

        // This is the extra point in the middle :) Its the secret sauce.
        path.addLine(to: CGPoint(x: viewW / 2, y: viewH / 2))

        // Move to the Top Right Corner
        path.addLine(to: CGPoint(x: viewW, y: 10))

        path.close()

        view.layer.shadowPath = path.cgPath
    }

    func titleColorWhite(scrollView: UIScrollView) { //динамический белый цвет
        let currentOffset = scrollView.contentOffset.y

        if currentOffset >= 0 && currentOffset <= 100 {
            var alpha: CGFloat = (100 - currentOffset) / 100
            if currentOffset > 100 {
                alpha = 0.0
            }

            let color = UIColor(red: 1, green: 1, blue: 1, alpha: alpha)
            let textAttributes = [NSAttributedString.Key.foregroundColor: color]
            self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        } else if currentOffset > 100 {
            let color = UIColor.clear
            let textAttributes = [NSAttributedString.Key.foregroundColor: color]
            self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        }
    }

    func presentBlure(option: PlayBlureVC) {
        guard let VC = BlureViewController.route() else {
            return
        }
        VC.settingsPlay = option
        self.present(VC, animated: false, completion: nil)
    }

    func stackVC() -> [UIViewController] { //выдает стек вью контроллеров
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            if let viewControllers = appDelegate.window?.rootViewController?.children {
                // Array of all viewcontroller after push
                print(viewControllers)
                return viewControllers
            }
        }

        return []
    }
    //методы необходимые для суппорт вью контроллера(добавить тень/сделать прозрачным итд)
    func atributesColorNavigBar(color: UIColor) {
        self.navigationController?.navigationBar.tintColor = color

        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: color]
    }

    func addImageShadow () {
        let yHeigt: CGFloat = SupportClass.Margins.navigationBarHeight
        let viewImage = UIView(frame: CGRect(x: 0,
                                             y: yHeigt,
                                             width: SupportClass.Dimensions.wDdevice,
                                             height: 0.5))

        viewImage.backgroundColor = SupportClass.Colors.shadowColorLine
        self.view.addSubview(viewImage)
    }

    func clearNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }

    func alphaAllObj(alpha: Float) { //делает все обьекты на вью контроллере прозрачными(кроме блюра и вью)

        for view in self.view.recurrenceAllSubviews() {
            view.alpha = CGFloat(alpha)
        }
    }

    var isModal: Bool {
        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController

        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
}
// MARK: - String
extension String {
    func strikeThrough(_ clear: Bool = true) -> NSAttributedString { //делает текст зачеркнутым
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                     value: NSUnderlineStyle.single.rawValue,
                                     range: NSRange(location: 0, length: clear ? attributeString.length : 0))
        return attributeString
        //        используется
        //        label.attributedText = "222222".strikeThrough()
    }

    func separatedPrice() -> String { //выдает цену в более удобном виде
        let array = self.split(separator: ".")

        if array.isEmpty {
            return self
        } else {
            if array.last == "00"{
                return String(array.first ?? "0")
            } else {
                return self
            }
        }
    }

    var isValidEmail: Bool { //адекватный емейл
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }

    func maskNumberPasword() -> String { ///мой код для добавления маски

        let str = self.formatPhoneNumber

        let cifrArray = Array(str)
        var maskArray = Array(TelephoneLocalize.pasvordMask)

        let lenght = cifrArray.count

        if lenght == 0 {
            return ""
        }

        for i in 0...lenght - 1 {
            let indexArray = maskArray.firstIndex(of: "X")

            let cifra = cifrArray[i]

            if let index = indexArray {
                maskArray[index] = cifra
            } else {
                return String(maskArray)
            }
        }

        let badSumbol: String = " "

        guard var index = maskArray.firstIndex(of: "X") else {
            return String(maskArray)
        }

        if index != 0 {
            let sumbol = maskArray[index - 1]

            if badSumbol == String(sumbol) {
                index -= 1
            }

            if index != 0 {
                let sumbol = maskArray[index - 1]

                if badSumbol == String(sumbol) {
                    index -= 1
                }
            }
        }

        var array = maskArray.prefix(index)

        if let strlast = array.last {
            if badSumbol == String(strlast) {
                array = array.dropLast()
            }
        }

        return String(array)
    }

    var formatPhoneNumber: String { //удаляем все символы кроме тех что в сете//для отправки на сервер
        return self.components(separatedBy: CharacterSet(charactersIn: "+0123456789").inverted).joined(separator: "")
    }

    func formattedMask(mask: String) -> String { //форматирование по маске
        let cleanPhoneNumber = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()

        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask {
            if index == cleanPhoneNumber.endIndex {
                break
            }
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }

    func lineBreak() -> String { //выдает строку фио
        let arrayWord = self.split(separator: " ")

        if arrayWord.count <= 1 {
            return self
        } else if arrayWord.count == 2 {
            return String(arrayWord[0] + "\n" + arrayWord[1])
        } else {
            var str = ""
            let count = arrayWord.count

            for i in 0...count - 2 {
                str += arrayWord[i] + " "
            }

            return str + "\n" + arrayWord[count - 1]
        }
    }

    func getDatwToString() -> Date? { //переобраз строку в дату
        //2019-06-07 07:56:17+00

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: self) // replace Date String
    }

    func deleteSumbol(sumbol: String) -> String {
        var str = ""
        self.components(separatedBy: sumbol).forEach { (obj) in
            str += obj
        }

        return str
    }

    func textEditor() -> String { //удаляе с конца строки пробелы
        var text = self
        while text.last == "\n" || text.last == " " {
            if !text.isEmpty {
                text.removeLast()
            }
        }
        return text
    }
}

// MARK: - UIView
extension UIView {
    @objc func loadViewFromNib(_ name: String) -> UIView { //добавление вью созданной в ксиб файле
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: name, bundle: bundle)
        if let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView {
            return view
        } else {
            return UIView()
        }
    }

    func addShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = SupportClass.Colors.shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 4.0
    }

    func addShadowClear() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = SupportClass.Colors.shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 2.5
    }

    func roundedView(rect: UIRectCorner) { //закругление 2х углов вьюшки
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: rect, //[.topLeft, .bottomLeft]
            cornerRadii: CGSize(width: 8, height: 8))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }

    func addRadius(number: CGFloat) {
        self.layer.cornerRadius = number
        self.layer.masksToBounds = true
    }

    func cirkleView() {
        let radius = self.frame.height / 2
        self.addRadius(number: radius)
    }

    func addGradient() { //градиент фона изображения
        let gradient = CAGradientLayer()

        gradient.frame = self.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.8).cgColor]

        self.layer.insertSublayer(gradient, at: 0)
    }

    func recurrenceAllSubviews() -> [UIView] {//получение всех UIView
        var all = [UIView]()
        func getSubview(view: UIView) {
            all.append(view)
            guard !view.subviews.isEmpty else {
                return
            }
            view.subviews.forEach { getSubview(view: $0) }
        }
        getSubview(view: self)
        return all
    }

    func addshadowDown() {//тень в верху

        let viewW = self.frame.width

        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 4.0
        self.layer.shadowOpacity = 1
        self.layer.shadowColor = SupportClass.Colors.shadowColor.cgColor

        let path = UIBezierPath()

        path.move(to: CGPoint(x: 0, y: -10))

        path.addLine(to: CGPoint(x: viewW / 2, y: 16))

        path.addLine(to: CGPoint(x: viewW, y: -10))

        path.close()

        self.layer.shadowPath = path.cgPath
    }

    func setGradient(colorOne: UIColor, colorTwo: UIColor, pointOne: CGPoint, pointTwo: CGPoint) { //делает градиент на вьюшку по направлению
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = pointOne
        gradientLayer.endPoint = pointTwo

        layer.insertSublayer(gradientLayer, at: 0)
    }

    func rotate() { //вращать
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1.3
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
}

// MARK: - UISwitch

extension UISwitch {
    func desingSwitchOrange() {  //дизайнерский оранжевый свитч
        self.onTintColor = SupportClass.Colors.orangeLogo
        self.tintColor = SupportClass.Colors.cellText
        self.backgroundColor = SupportClass.Colors.cellText
        self.layer.cornerRadius = 16.0
    }
}

// MARK: - Label
extension UILabel {
    func oneStuleLabel(color: UIColor, sizeFront: CGFloat) {
        self.textColor = color
        self.font = UIFont(name: ".SFUIText", size: sizeFront)
    }

    func twoStuleLabel(myString: String,
                       oneLenght: Int,
                       tupleSizeFront: (oneSizeFront: CGFloat, twoSizeFront: CGFloat),
                       tupleColor: (oneColor: UIColor, twoColor: UIColor)) {
        let oneSizeFront = tupleSizeFront.oneSizeFront
        let twoSizeFront = tupleSizeFront.twoSizeFront

        let oneColor = tupleColor.oneColor
        let twoColor = tupleColor.twoColor

        guard let defaultFront = UIFont(name: ".SFUIText", size: twoSizeFront) else {
            return
        }

        var myMutableString = NSMutableAttributedString()

        let font = UIFont(name: ".SFUIText", size: oneSizeFront) ?? defaultFront

        myMutableString = NSMutableAttributedString(string: myString,
                                                    attributes: [NSAttributedString.Key.font: font])

        myMutableString.addAttribute(NSAttributedString.Key.font,
                                     value: UIFont(name: ".SFUIText", size: oneSizeFront) ?? defaultFront,
                                     range: NSRange(location: 0, length: oneLenght))

        let twoLenght = myString.count - oneLenght

        myMutableString.addAttribute(NSAttributedString.Key.font,
                                     value: UIFont(name: ".SFUIText", size: twoSizeFront) ?? defaultFront,
                                     range: NSRange(location: oneLenght, length: twoLenght))

        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor,
                                     value: twoColor,
                                     range: NSRange(location: oneLenght, length: twoLenght))

        self.textColor = oneColor
        self.attributedText = myMutableString
    }

    func settingsFont(number: CGFloat) {
        self.font = UIFont(name: "Helvetica-Regular", size: number)
    }
    func settingsFontSemibold(number: CGFloat) {
        self.font = UIFont(name: "Helvetica-Semibold", size: number)
    }

    func priceAndCrossedOutPrice(myString: String, oneLenght: Int) { //цена и зачеркнутая цена

        let oneColor = SupportClass.Colors.orangeLogo
        let twoColor = UIColor.white

        guard let defaultFront = UIFont(name: ".SFUIText", size: 17) else {
            return
        }

        var myMutableString = NSMutableAttributedString()

        let font = UIFont(name: ".SFUIText", size: 15) ?? defaultFront

        myMutableString = NSMutableAttributedString(string: myString,
                                                    attributes: [NSAttributedString.Key.font: font])

        myMutableString.addAttribute(NSAttributedString.Key.font,
                                     value: UIFont(name: ".SFUIText", size: 15) ?? defaultFront,
                                     range: NSRange(location: 0, length: oneLenght))

        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor,
                                     value: twoColor,
                                     range: NSRange(location: oneLenght, length: myString.count - oneLenght))

        myMutableString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                     value: NSUnderlineStyle.single.rawValue,
                                     range: NSRange(location: 0, length: oneLenght))

        self.textColor = oneColor
        self.attributedText = myMutableString
    }

    //функция изменения ширифта
    func scaleUIFont(scale: CGFloat, label: UILabel) {
        label.minimumScaleFactor = scale
        label.adjustsFontSizeToFitWidth = true
    }

    //количество линий UILAbel
    func lines(label: UILabel) -> Int {
        let textSize = CGSize(width: label.frame.size.width, height: CGFloat(Float.infinity))
        let rHeight = lroundf(Float(label.sizeThatFits(textSize).height))
        let charSize = lroundf(Float(label.font.lineHeight))
        let lineCount = rHeight / charSize
        return lineCount
    }

    private func textWidth(text: String, font: UIFont?) -> CGFloat {
        let attributes = font != nil ? [NSAttributedString.Key.font: font] : [:]
        return text.size(withAttributes: attributes as [NSAttributedString.Key: Any]).width
    }
}

// MARK: - TextField
extension UITextField {
    func canBeEdited(lenght: Int, lenghtMax: Int, string: String) -> Bool {//можно редактировать тексФилд с телефонным номером

        if lenght < lenghtMax {
            return isBadSumbolRegistrationVC(string: string)
        } else if lenght == lenghtMax && string.isEmpty {
            return true
        } else {
            return false
        }
    }

    func editingCountryCode(range: NSRange) -> Bool {//запрет на редактирование кода страны
        let prefixNumber = TelephoneLocalize.prefixNumber

        if range.location < prefixNumber.count {
            return false
        }

        return true
    }

    func getPhoneNoLandCode() -> String { //получение текушего номера в текс филде без кода страны

        guard let text = self.text else {
            return ""
        }

        let textLeng = text.count
        let lengLand = TelephoneLocalize.prefixNumber.count

        return String(text.suffix(textLeng - lengLand))
    }

    func getCountCifr () -> Int { //функция возвращает количество чисел в строке но без кода страны
        let array = Array(self.getPhoneNoLandCode())
        let setGoodSumbol: NSSet = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]

        var counter = 0

        for i in array {
            if setGoodSumbol.contains(String(i)) {
                counter += 1
            }
        }

        return counter
    }

    func getCountCifrPassword () -> Int { //то же что и выше но для пароля

        guard let text = self.text else {
            return 0
        }

        let array = Array(text)

        let setGoodSumbol: NSSet = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]

        var counter = 0

        for i in array {
            if setGoodSumbol.contains(String(i)) {
                counter += 1
            }
        }

        return counter
    }

    func getPhoneNoLandCodeMASK() -> String { //получение текушего номера в тексфилде без кода страны НО С МАСКОЙ
        return self.getPhoneNoLandCode().formattedMask(mask: TelephoneLocalize.telephoneMask)
    }

    func getPhoneLandCodeAndMASK() -> String { //тоже что и выше но уже с кодом страны. Короче готовый текст
        let number = self.maskNumber(mask: TelephoneLocalize.telephoneMask)

        return TelephoneLocalize.prefixNumber + number
    }

    func isBadSumbolRegistrationVC(string: String) -> Bool { //благодаря этой ф-ии нельзя вводить ни чего кроме чисел в телефон текстФилд
        let setGoodSumbol: NSSet = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", ""]

        return setGoodSumbol.contains(string)
    }

    func maskNumber(mask: String) -> String { ///мой код для добавления маски

        let str = self.getPhoneNoLandCode().formatPhoneNumber

        let cifrArray = Array(str)
        var maskArray = Array(mask)

        let lenght = cifrArray.count

        if lenght == 0 {
            return ""
        }

        for i in 0...lenght - 1 {
            let indexArray = maskArray.firstIndex(of: "X")

            let cifra = cifrArray[i]

            if let index = indexArray {
                maskArray[index] = cifra
            } else {
                return String(maskArray)
            }
        }

        let setBadSumbol: NSSet = [" ", "-", ")", "(", ""]

        guard var index = maskArray.firstIndex(of: "X") else {
            return String(maskArray)
        }

        if index != 0 {
            let sumbol = maskArray[index - 1]

            if setBadSumbol.contains(String(sumbol)) {
                index -= 1
            }

            if index != 0 {
                let sumbol = maskArray[index - 1]

                if setBadSumbol.contains(String(sumbol)) {
                    index -= 1
                }
            }
        }

        var array = maskArray.prefix(index)

        if let strlast = array.last {
            if setBadSumbol.contains(String(strlast)) {
                array = array.dropLast()
            }
        }

        return String(array)
    }

    func isBadSumbolName(string: String) -> Bool { //имя по формату
        let setBadSumbol: NSSet = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0",
                                   "!", "@", "#", "$", "%", "^", "&", "*", "(", ")",
                                   "№", ":", ",", ";", "/", "*", "+", "{", "}", "?",
                                   "<", ">", "\""]

        return !setBadSumbol.contains(string)
    }

    func isBadSumbolEMail(string: String, range: NSRange) -> Bool { //емейл по формату
        guard let text = self.text else {
            return false
        }

        let arrayText = Array(text)

        let setSumbol: NSSet = ["_", "%", "+", "-"]

        let setAll: NSSet = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0",
                             "q", "w", "e", "r", "t", "y", "u", "i", "o", "p",
                             "a", "s", "d", "f", "g", "h", "j", "k", "l", "z",
                             "x", "c", "v", "b", "n", "m",
                             "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P",
                             "A", "S", "D", "F", "G", "H", "J", "K", "L", "Z",
                             "X", "C", "V", "B", "N", "M", "@",
                             ".", "_", "%", "+", "-", "", " "]

        if string == "@" && text.contains("@") {
            return false
        }

        let location = arrayText.firstIndex(of: "@")

        if let loc = location {
            if range.location > loc {
                if setSumbol.contains(string) {
                    return false
                }

                let newArray = arrayText.suffix(from: loc)

                if string == "." {
                    return !newArray.contains(".")
                }
            }
        }

        print(string)
        if text.count > 63 || string.count > 63 {
            return false
        } else if string.count > 1 {
            for sumbol in Array(string) {
                if !setAll.contains(String(sumbol)) {
                    return false
                }
            }
            return true
        }

        return setAll.contains(string)
    }
}

// MARK: - Float
extension Float {
    func separatedFloat() -> String { //перевод числа в строку нормального вида
        let str = String(self)
        let array = str.split(separator: ".")

        if array.isEmpty {
            return str
        } else {
            if array.last == "00" || array.last == "0" {
                return String(array.first ?? "0")
            } else {
                return str
            }
        }
    }
}

// MARK: - Double

extension Double {
    func formaterDistance() -> String { //переводит расстояние в м/км
        let km = "%@ км"
        let meter = "%@ м"

        if self < 1_000 {
            return String(format: meter, String(Int(floor(self))))
        } else {
            let distance = String((self / 1_000).rounded(toPlaces: 1))
            return String(format: km, distance)
        }
    }

    func rounded(toPlaces places: Int) -> Double {//округление
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

// MARK: - UIScrollView

extension UIScrollView {
    func paralax(constraitArray: [NSLayoutConstraint]) { //паралакс эффект
        let delta: CGFloat = self.contentOffset.y

        if delta < 0 {
            for obj in constraitArray {
                obj.constant = delta
            }
        }
    }
}

// MARK: - ARRAY

extension Array {
    func unique<T: Hashable>(map: ((Element) -> (T))) -> [Element] { //возвращает массив уникальных элементов
        var set = Set<T>()
        var arrayOrdered = [Element]()
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                arrayOrdered.append(value)
            }
        }

        return arrayOrdered
    }

    func getFirstElements(upTo position: Int) -> Array<Element> {  //удаляет элементы в массив е начиная с 0 до position не включая
        let arraySlice = self[0 ..< position]
        return Array(arraySlice)
    }
}

// MARK: - UIImage

extension UIImage {
    func noir() -> UIImage { //делаем изображение черно белым
        let context = CIContext(options: nil)

        let currentFilter = CIFilter(name: "CIPhotoEffectNoir")
        currentFilter!.setValue(CIImage(image: self), forKey: kCIInputImageKey)

        guard let output = currentFilter!.outputImage else {
            return self
        }

        let cgimg = context.createCGImage(output, from: output.extent)
        let processedImage = UIImage(cgImage: cgimg!, scale: scale, orientation: imageOrientation)
        return processedImage
    }

    //делаем качество изображения подстать нашему девайсу
    func resizeImage(toFill targetView: UIImageView, width: CGFloat, height: CGFloat) -> UIImage {
        let size = self.size

        let widthRatio = width / size.width
        let heightRatio = height / size.height

        var newSize: CGSize
        if widthRatio < heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }

    func getKeyFromData() -> String { //получаем уникальный ключ из изображения
        let data = self.pngData()
        if let str = data?.base64EncodedString() {
            let clearStr = str.deleteSumbol(sumbol: "/").deleteSumbol(sumbol: ".")
            return String(clearStr.characters.suffix(200))
        }
        return "key"
    }

    func compactImage() -> UIImage {
        let koef = self.getKoefCompress()
        if koef != 1, let data = self.jpegData(compressionQuality: koef), let image = UIImage(data: data) {
            return image
        }

        return self
    }

    private func getKoefCompress() -> CGFloat {
        let maxData = 10_216_790
        if let factData = self.pngData(), factData.count > maxData {
            return CGFloat(maxData / factData.count)
        }

        return 1
    }
}

// MARK: - UIImageView

extension UIImageView {
    func blackAndWhiteImage() {
        if let img = self.image {
            self.image = img.noir()
        }
    }
}

// MARK: - Date

extension Date {
    func secondsHavePassed(_ seconds: Int) -> Bool { //проверяем, прошло ли данное количество секунд
        let delta = -1 * seconds
        let frieDaysHave = Date(timeIntervalSinceNow: TimeInterval(delta))
        let deltaTime = Calendar.current.compare(frieDaysHave, to: self, toGranularity: .second)

        if deltaTime.rawValue == -1 {
            return false // не прошло 3е суток
        } else {
            return true
        }
    }

    func printDate(format: String = "d MMMM yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: self)
    }
}

// MARK: - URL

extension URL {
    //получаем ключ из урла

    var getKey: String {
        if let str = self.absoluteString.components(separatedBy: "/").last?.components(separatedBy: ".").first {
            return str
        }

        return "key"
    }

    // методы ниже нужны для получения/извлечения/проверки есть ли такое изображение в директории
    var attributes: [FileAttributeKey: Any]? {
        do {
            return try FileManager.default.attributesOfItem(atPath: path)
        } catch let error as NSError {
            print("FileAttribute error: \(error)")
        }
        return nil
    }

    var fileSize: UInt64 {
        return attributes?[.size] as? UInt64 ?? UInt64(0)
    }

    var fileSizeString: String {
        return ByteCountFormatter.string(fromByteCount: Int64(fileSize), countStyle: .file)
    }

    var creationDate: Date? {
        return attributes?[.creationDate] as? Date
    }
}

// MARK: - Button

extension UIButton {
    func grayButton(_ text: String) {
        self.backgroundColor = SupportClass.Colors.imageCirkle

        self.setTitleColor(SupportClass.Colors.cellText, for: .normal)

        self.setTitle(text, for: .normal)
        self.setTitle(text, for: .highlighted)

        self.addRadius(number: 8)
    }

    func underline() { //подчеркнутый текст на кнопке
        guard let text = self.titleLabel?.text else {
            return
        }

        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: text.count))

        self.setAttributedTitle(attributedString, for: .normal)
    }
}

// MARK: - ApplePAY
extension UIViewController: PKPaymentAuthorizationViewControllerDelegate {
    func applePayGO(_ error: GGError? = nil) { //оплатить
        let request = PKPaymentRequest()
        request.merchantIdentifier = "merchant.com.ginzago"
        request.supportedNetworks = [PKPaymentNetwork.visa, PKPaymentNetwork.masterCard, PKPaymentNetwork.amex]
        request.merchantCapabilities = PKMerchantCapability.capability3DS
        request.countryCode = "RU"
        request.currencyCode = "RUB"

        var numberStr = "Привязка платежной системы"
        var summ = "1 Р"

        if let error = error {
            numberStr = "Оплата заказа номер " + String(SupportOrders.numberUnpaidOrder() ?? 0)
            let text = error.message ?? "1"
            summ = text + " Р"
        }

        let number = NSDecimalNumber(string: summ)

        request.paymentSummaryItems = [
            PKPaymentSummaryItem(label: numberStr, amount: number)
        ]

        if let applePayController = PKPaymentAuthorizationViewController(paymentRequest: request) {
            applePayController.delegate = self
            self.present(applePayController, animated: true, completion: nil)
        }
    }

    private func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didSelect paymentMethod: PKPaymentMethod, completion: @escaping ([PKPaymentSummaryItem]) -> Void) {
    }

    @available(iOS 11.0, *)
    public func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        if let paymentData = String(data: payment.token.paymentData.base64EncodedData(), encoding: .utf8) {
            self.isGoodPay(controller, tocken: paymentData)
        } else {
            self.isBadPay(controller)
        }
    }

    public func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)

        if !self.isNoBilligInfoVC() {
            SupportNotification.notificAPay(false)
        }
    }

    private func isNoBilligInfoVC() -> Bool {  //да если это гуглВК или менюВК
        let value = (self is BillingInformationVC) || (self is OrdersViewController)
        return !value
    }

    private func isBadPay(_ controller: PKPaymentAuthorizationViewController) { //если не получилось сгенерировать токен
        controller.dismiss(animated: false) {
            self.presentAlertAPay()
            if !self.isNoBilligInfoVC() {
                SupportNotification.notificAPay(false)
            }
        }
    }

    private func isGoodPay(_ controller: PKPaymentAuthorizationViewController, tocken: String) { //если получилось сгенерировать токен
        controller.dismiss(animated: true) {
            if self.isNoBilligInfoVC() {
                if SupportOrders.numberUnpaidOrder() != nil {
                    CurtainViewController.payUnpaidOrder(self, tocken: tocken) ///оплатить долг после закрытия шторки
                } else {
                    self.openRefrigerator(tocken: tocken, completion: {})    ///открыть холодос
                }
            } else {
                SupportNotification.notificAPay(true, tocken: tocken)        ///оплатить долг на экране платежн инфо
            }
        }
    }
}

extension NSMutableAttributedString {   //делает часть строки другим цветом

    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }

    public func setAsLink(textToFind: String, linkURL: String) -> Bool {
        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            self.addAttribute(.link, value: linkURL, range: foundRange)
            return true
        }
        return false
    }

    //    func setTwoColorForText(textForAttribute: String, withColor color: UIColor) {
    //        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
    //        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    //    }
}

extension UITapGestureRecognizer {
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)

        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize

        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                          y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)

        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x,
                                                     y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)

        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}

public extension UITextView {
    /// количество линий в текстВью
    public var numberOfLines: Int {
        guard compare(beginningOfDocument, to: endOfDocument).same == false else {
            return 0
        }

        let direction: UITextDirection = UITextDirection(rawValue: UITextStorageDirection.forward.rawValue)
        var lineBeginning = beginningOfDocument
        var lines = 0
        while true {
            lines += 1
            guard let lineEnd = tokenizer.position(from: lineBeginning, toBoundary: .line, inDirection: direction) else {
                fatalError()
            }
            guard compare(lineEnd, to: endOfDocument).same == false else {
                break
            }
            guard let newLineBeginning = tokenizer.position(from: lineEnd, toBoundary: .character, inDirection: direction) else {
                fatalError()
            }
            guard compare(newLineBeginning, to: endOfDocument).same == false else {
                return lines + 1
            }
            lineBeginning = newLineBeginning
        }
        return lines
    }
}

public extension ComparisonResult {
    public var ascending: Bool {
        switch self {
        case .orderedAscending:
            return true

        default:
            return false
        }
    }

    public var descending: Bool {
        switch self {
        case .orderedDescending:
            return true

        default:
            return false
        }
    }

    public var same: Bool {
        switch self {
        case .orderedSame:
            return true

        default:
            return false
        }
    }
}
