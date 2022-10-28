//
//  ViewUnderSwipeCell.swift
//  SwipeCell
//
//  Created by Константин Ирошников on 05.08.2022.
//

import Foundation
import UIKit

final class ViewUnderSwipeCell: UIView {
    private enum Constants {
        static let sizeImage: CGFloat = 24
        static let topImageOffset: CGFloat = 14
        static let topLabelOffset: CGFloat = 6
        static let botomLabelOffset: CGFloat = 4

        static let widthColorView: CGFloat = 80
    }

    private var action: (ViewUnderSwipeCell.Style) -> Void = { _ in }

    enum Style {
        case red
        case green
        case blue

        fileprivate var text: String {
            switch self {
            case .red:
                return "Удалить"
            case .green:
                return "Копировать ссылку"
            case .blue:
                return "Сохранить в пдф"
            }
        }

        fileprivate var color: UIColor {
            switch self {
            case .red:
                return .red
            case .green:
                return .green
            case .blue:
                return .blue
            }
        }

        fileprivate var image: UIImage? {
            switch self {
            case .red:
                return UIImage(systemName: "paperplane")
            case .green:
                return UIImage(systemName: "keyboard")
            case .blue:
                return UIImage(systemName: "tv.fill")
            }
        }
    }

    init(action: @escaping (ViewUnderSwipeCell.Style) -> Void) {
        self.action = action

        super.init(frame: .zero)

        desingUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func desingUI() {
        backgroundColor = ViewUnderSwipeCell.Style.blue.color

        let redView = createOneView(.red)
        let greenView = createOneView(.green)
        let blueView = createOneView(.blue)

        addSubview(redView)
        addSubview(greenView)
        addSubview(blueView)

        redView.snp.makeConstraints { make in
            make.right.top.bottom.equalTo(0)
            make.width.equalTo(Constants.widthColorView)
        }

        greenView.snp.makeConstraints { make in
            make.top.bottom.equalTo(0)
            make.right.equalTo(redView.snp.left)
            make.width.equalTo(Constants.widthColorView)
        }

        blueView.snp.makeConstraints { make in
            make.top.bottom.equalTo(0)
            make.right.equalTo(greenView.snp.left)
            make.width.equalTo(Constants.widthColorView)
        }
        
    }

    private func createOneView(_ style: ViewUnderSwipeCell.Style) -> UIView {
        let buttonsView = UIView()
        buttonsView.backgroundColor = style.color

        let image = UIImageView(image: style.image)

        let label = UILabel()
        label.text = style.text
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        label.textColor = .white

        let button = UIButton()
        button.backgroundColor = .clear

        switch style {
        case .red:
            button.addTarget(self, action: #selector(tapedButtonRed), for: .touchUpInside)
        case .green:
            button.addTarget(self, action: #selector(tapedButtonGreen), for: .touchUpInside)
        case .blue:
            button.addTarget(self, action: #selector(tapedButtonBlue), for: .touchUpInside)
        }

        buttonsView.addSubview(image)
        buttonsView.addSubview(label)
        buttonsView.addSubview(button)

        image.snp.makeConstraints { make in
            make.width.height.equalTo(Constants.sizeImage)
            make.top.equalTo(Constants.topImageOffset)
            make.centerX.equalTo(buttonsView.snp.centerX)
        }

        label.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(0)
            make.top.equalTo(image.snp.bottom).offset(Constants.topLabelOffset)
            make.left.right.equalTo(0)
        }

        button.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(0)
        }

        return buttonsView
    }

    @objc
    private func tapedButtonRed() {
        action(.red)
    }

    @objc
    private func tapedButtonGreen() {
        action(.green)
    }

    @objc
    private func tapedButtonBlue() {
        action(.blue)
    }
}

/*
 final class DataSinglton {
     static let shared = DataSinglton()

     private init() {}

     var viewModelForTableOperation: [LastOperationsViewModel] {
         var array = [LastOperationsViewModel]()
         for i in 0...25 {
             let qrOperation = QROperation.generateValue(i)
             let boolValue = (arc4random() / 2) == 0
             let operation = LastOperationsViewModel.operation(qrOperation, boolValue)

             array.append(operation)
         }

         return array
     }

     var viewModelForTableStaticQR: [LastOperationsViewModel] {
         var array = [LastOperationsViewModel]()
         for i in 0...25 {
             let qrOperation = StaticQR.generateRandom
             let boolValue = (arc4random() % 2) == 0
             let operation = LastOperationsViewModel.staticQR(qrOperation, boolValue)

             array.append(operation)
         }

         return array
     }

 }

 private extension QROperation {
     static func generateValue(_ index: Int) -> QROperation {
         let amountFull: Double = Double(arc4random_uniform(1000))
         let amountDouble: Double = Double(arc4random_uniform(100)/100)
         let amount: Double = amountFull + amountDouble

         let currencyRardom = (arc4random() % 2) == 0
         let currency = currencyRardom ? "$" : "₽"

         let dtOperRardom = (arc4random() % 2) == 0
         let dtOper = dtOperRardom ? nil : String.randomString(length: 5)

         let mkIdRardom = (arc4random() % 2) == 0
         let mkId = mkIdRardom ? nil : String.randomString(length: 9)

         let operationIdRardom = (arc4random() % 2) == 0
         let operationId = operationIdRardom ? nil : String.randomString(length: 25)

         let orderIdRardom = (arc4random() % 2) == 0
         let orderId = orderIdRardom ? nil : String.randomString(length: 10)

         let purpose = String.randomString(length: 15)

         let qrcIdRandom = (arc4random() % 2) == 0
         let qrcId = qrcIdRandom ? nil : String.randomString(length: 8)

         let qReasonRandom = (arc4random() % 2) == 0
         let qReason = qReasonRandom ? nil : String.randomString(length: 6)

         let qrStatesArray: [OperationState] = [.unknown, .inProgress, .cancelled, .ok, .refund, .partialRefund]
         let qrStatesArrayIndex = index % qrStatesArray.count
         let qState = qrStatesArray[qrStatesArrayIndex]

         let requestIdRandom = (arc4random() % 2) == 0
         let requestId = requestIdRandom ? nil : String.randomString(length: 6)

         let senderIdRandom = (arc4random() % 2) == 0
         let senderId = senderIdRandom ? nil : String.randomString(length: 16)

         var operationType: OperationType? = nil
         let operationTypeRandom = arc4random_uniform(3000)
         if operationTypeRandom < 1000 {
             operationType = .refund
         } else if operationTypeRandom < 2000 {
             operationType = .payment
         }

         return QROperation(
             amount: amount,
             currency: currency,
             dtOper: dtOper,
             mkId: mkId,
             operationId: operationId,
             orderId: orderId,
             purpose: purpose,
             qrcId: qrcId,
             qReason: qReason,
             qState: qState,
             requestId: requestId,
             senderId: senderId,
             operationType: operationType
         )
     }

     private init(
         amount: Double?,
         currency: String?,
         dtOper: String?,
         mkId: String?,
         operationId: String?,
         orderId: String?,
         purpose: String,
         qrcId: String?,
         qReason: String?,
         qState: OperationState?,
         requestId: String?,
         senderId: String?,
         operationType: OperationType?
     ) {
         self.amount = amount
         self.currency = currency
         self.dtOper = dtOper
         self.mkId = mkId
         self.operationId = operationId
         self.orderId = orderId
         self.purpose = purpose
         self.qrcId = qrcId
         self.qReason = qReason
         self.qState = qState
         self.requestId = requestId
         self.senderId = senderId
         self.operationType = operationType
     }
 }

 extension StaticQR {
     static var generateRandom: Self {

         let amountFull: Double = Double(arc4random_uniform(1000))
         let amountDouble: Double = Double(arc4random_uniform(100)/100)
         let amount: Double = amountFull + amountDouble

         return StaticQR(
             qrcId: String.randomString(length: 5),
             date: String.randomString(length: 9),
             name: String.randomString(length: 25),
             payload: String.randomString(length: 10),
             amount: amount
         )
     }

     private init(
         qrcId: String?,
         date: String?,
         name: String?,
         payload: String?,
         amount: Double?
     ) {
         self.qrcId = qrcId
         self.date = date
         self.name = name
         self.payload = payload
         self.amount = amount
     }
 }

 extension PaymentDetails {
     static var randomGenerate: Self {

         let absOperationIdRandom = (arc4random() % 2) == 0
         let absOperationId = absOperationIdRandom ? nil : String.randomString(length: 6)

         let clientFioRandom = (arc4random() % 2) == 0
         let clientFio = clientFioRandom ? nil : String.randomString(length: 6)

         let clientPhone = String.randomString(length: 10)

         var assocOperations = [AssocOperation]()
         for _ in 0...7 {
             let date = String.randomString(length: 10)

             let amountFull: Double = Double(arc4random_uniform(1000))
             let amountDouble: Double = Double(arc4random_uniform(100)/100)
             let amount: Double = amountFull + amountDouble

             let operation = AssocOperation(amount: amount, date: date)

             assocOperations.append(operation)
         }

         return PaymentDetails(
             absOperationId: absOperationId,
             clientFio: clientFio,
             clientPhone: clientPhone,
             assocOperations: assocOperations
         )
     }
 }

 extension String {
     static func randomString(length: Int) -> String {
         let letters = "abcdefghij klmno pqrstuvwx yzABCDEFGHIJ KLMNOPQRSTUV WXY Z0123 456789"
         return String((0..<length).map{ _ in letters.randomElement()! })
       }
 }

 */
