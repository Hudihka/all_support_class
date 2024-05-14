
protocol Event {
    var generateTextOfEvent: String { get }
}

protocol GenerateEvent {
    static func generateTextOfEvent(postfix: Event) -> String
}

enum AnalyticsEvent: GenerateEvent {
    static func generateTextOfEvent(postfix: Event) -> String {
        "qrpay_\(postfix.generateTextOfEvent)"
    }
    
    enum Connection: String, Event {
        var generateTextOfEvent: String {
            "connection_\(self.rawValue)"
        }
        
        case comditions    = "comditions"
    }
    
    enum Choose: String, Event {
        var generateTextOfEvent: String {
            "choose_\(self.rawValue)"
        }
        
        case pointSale     = "point_sale"
        case comditions    = "comditions"
    }
    
    enum New: String, Event {
        var generateTextOfEvent: String {
            "new_\(self.rawValue)"
        }
        
        case dynamicqr                  = "dynamicqr"
        case dynamicqrEntry             = "dynamicqr_entry"
        case dynamicqrReplay            = "dynamicqr_replay"
        case dynamicqrShare             = "dynamicqr_share"
        case dynamicqrShareLink         = "dynamicqr_share_link"
        case dynamicqrPaymentHistory    = "dynamicqr_payment_history"
        case dynamicqrSucces            = "dynamicqr_succes"
        case statqr                     = "statqr"
        case statqrEntryRandom          = "statqr_entry_random"
        case statqrEntry                = "statqr_entry"
        case statqrDelete               = "statqr_delete"
        case statqrSent                 = "statqr_sent"
        case statqrSucces               = "statqr_succes"
    }
    
    enum Statqr: String, Event {
        var generateTextOfEvent: String {
            "statqr_\(self.rawValue)"
        }
        
        case sorting                  = "sorting"
    }
    
    enum Dynamicqr: String, Event {
        var generateTextOfEvent: String {
            "dynamicqr_\(self.rawValue)"
        }
        
        case filters            = "filters"
        case settings           = "settings"
        case refund             = "refund"
        case refundReturn       = "refund_return"
        case refundSucces       = "refund_succes"
    }
}
