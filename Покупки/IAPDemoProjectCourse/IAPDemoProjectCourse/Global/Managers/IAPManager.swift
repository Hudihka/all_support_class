//
//  IAPManager.swift
//  IAPDemoProjectCourse
//
//  Created by Ivan Akulov on 30/10/2017.
//  Copyright © 2017 Ivan Akulov. All rights reserved.
//

import Foundation
import StoreKit              //не забудь импортировать фраемворк для работы с покупками

class IAPManager: NSObject { //класс синглтон в котором и осуществляется работа по получению покупок
    
    static let productNotificationIdentifier = "IAPManagerProductIdentifier"    //ну это просто ключ для нотификации
    static let shared = IAPManager()
    private override init() {}
    
    var products: [SKProduct] = []                                              //массив продуктов что мы получим с сервера
    let paymentQueue = SKPaymentQueue.default()                                 //очередь в которой совершаются все покупки
    
    public func setupPurchases(callback: @escaping(Bool) -> ()) {               //проверка на то, разрешенно ли пользователю совершать платежи
                                                                                //функцию необходимо добавить в апп делегат
        if SKPaymentQueue.canMakePayments() {                                   
            paymentQueue.add(self)
            callback(true)
            return
        }
        callback(false)
    }
    
    public func getProducts() {                                                     //функция получения идентиф товаров
        let identifiers: Set = [                                                    //сет товаров что нам доступны
            IAPProducts.consumable.rawValue,                                        //это простые товары наподобие алмазов в игре, обычно не возобновлямые
            IAPProducts.nonConsumable.rawValue,                                     //например ПРОверсия приложения, обычно возобнавляемая
            IAPProducts.autoRenewable.rawValue,                                     //автовозобнавляемая подписка
            IAPProducts.nonRenewable.rawValue,                                      //НЕавтовозобнавляемая подписка
        ]
        
        let productRequest = SKProductsRequest(productIdentifiers: identifiers)     //запрос покупок с сервака по идентифаер
        productRequest.delegate = self                                              //нужно добавить расширение SKProductsRequestDelegate
        productRequest.start()
    }
    
    public func purchase(productWith identifier: String) {                          //функция которая собственно и начинает процесс покупки, процесс покупки осуществляется по идентифаеру
        guard let product = products.filter({ $0.productIdentifier == identifier }).first else { return }   //получаем нужную продукт из списка доступных
        let payment = SKPayment(product: product)                                   //создаем транзакцию
        paymentQueue.add(payment)                                                   //добавляем транзакцию в очередь
    }
    
    public func restoreCompletedTransactions() {
        paymentQueue.restoreCompletedTransactions()                                 //востановление покупок
    }
}


extension IAPManager: SKPaymentTransactionObserver {                               //делегат в котором и происходит процес оплаты
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {      //функция процесса оплаты
        for transaction in transactions {
            switch transaction.transactionState {                       //статаус транзакции
            case .deferred: break                                       //ситуация когда транзакция в процессе ожидания внешнего воздествия(например ответа родительского контроля)
            case .purchasing: break                                     //Транзакция обрабатывается в App Store.
            case .failed: failed(transaction: transaction)              //НЕудача
            case .purchased: completed(transaction: transaction)        //В App Store успешно обработан платеж. Ваше приложение должно предоставлять контент, приобретенный пользователем.
            case .restored: restored(transaction: transaction)          //Эта транзакция восстанавливает контент
            }
        }
    }
    
    private func failed(transaction: SKPaymentTransaction) {            //обработка ошибки
        if let transactionError = transaction.error as NSError? {
            if transactionError.code != SKError.paymentCancelled.rawValue { //проверяем что это НЕ ошибка отмены платежа
                print("Ошибка транзакции: \(transaction.error!.localizedDescription)")
            }
        }

        //подробней о ошибках здесь https://developer.apple.com/documentation/storekit/skerror
        paymentQueue.finishTransaction(transaction)    //чистим очередь
    }
    
    private func completed(transaction: SKPaymentTransaction) {    //покупка прошла успешно
        let receiptValidator = ReceiptValidator()
        let result = receiptValidator.validateReceipt()            //это валидация чека, подробней о ней в описании проекта
        
        switch result {
        case let .success(receipt):                                 //прошли валидацию и все хорошо и есть рецепт
            guard let purchase = receipt.inAppPurchaseReceipts?.filter({ $0.productIdentifier == IAPProducts.autoRenewable.rawValue }).first else { //проверяем. Указанно ли что это автовозоб подписка
                NotificationCenter.default.post(name: NSNotification.Name(transaction.payment.productIdentifier), object: nil) //если не автовозобн то просто сообщаем куда надо передая идентиф покупки
                paymentQueue.finishTransaction(transaction)                                                                    //ну и конечно чистим очередь
                return
            }
            
            if purchase.subscriptionExpirationDate?.compare(Date()) == .orderedDescending {        //здесь мы проверяем действует ли еще покупка
                UserDefaults.standard.set(true, forKey: IAPProducts.autoRenewable.rawValue)         //и в зависимости от этого сохраняем что надо
            } else {
                UserDefaults.standard.set(false, forKey: IAPProducts.autoRenewable.rawValue)
                print("Subscription has ended")
            }
            
               NotificationCenter.default.post(name: NSNotification.Name(transaction.payment.productIdentifier), object: nil)  //так же сообщаем куда надо что бы обновить контент
            
        case let .error(error):                             //не прошли валидацию
            print(error.localizedDescription)
        }
        
        paymentQueue.finishTransaction(transaction)         //чистим очередь
    }
    
    private func restored(transaction: SKPaymentTransaction) {   //здесь мы просто востанавливаем контент
        paymentQueue.finishTransaction(transaction)
    }
}

extension IAPManager: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.products = response.products                               //наш массив заполняем полученными продуктами
        products.forEach { print($0.localizedTitle) }
        if products.count > 0 {     //нужно для ситуации когда заходим на вью контроллер с продуктами а они могут еще не подгрузится
            NotificationCenter.default.post(name: NSNotification.Name(IAPManager.productNotificationIdentifier), object: nil)
        }
    }
}




























