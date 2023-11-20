import Flutter
import UIKit
import Payze_iOS_sdk

public class PayzePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "payze", binaryMessenger: registrar.messenger())
    let instance = PayzePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "pay":
        let args = call.arguments as? [String:Any]
        guard let arg = args else {
            result(nil)
            return
        }
        let card = PayCard.fromJson(args: arg)
        guard let paymentDetails = PaymentDetails.init(number: card.cardNumber, cardHolder: card.cardHolderName, expirationDate: card.expiryDate, securityNumber: card.cvv, transactionId: card.transactionId, billingAddress: PaymentDetails.defaultBillingAddress) else {
            result(nil)
            return
        }
        PaymentService.shared.startPayment(paymentDetails: paymentDetails) { r in
            result("\(r)")
        }
    default:
      result(FlutterMethodNotImplemented)
    }
  }
    
}

struct PayCard {
    var cardNumber: String
    var cardHolderName: String
    var cvv: String
    var expiryDate: String
    var transactionId: String
    
    init(cardNumber: String, cardHolderName: String, cvv: String, expiryDate: String, transactionId: String) {
        self.cardNumber = cardNumber
        self.cardHolderName = cardHolderName
        self.cvv = cvv
        self.expiryDate = expiryDate
        self.transactionId = transactionId
    }
    
    static func fromJson(args: [String: Any]) -> PayCard {
        return PayCard(cardNumber: (args["cardNumber"] as? String)!, cardHolderName: (args["cardNumber"] as? String)!, cvv: (args["cvv"] as? String)!, expiryDate: (args["expiryDate"] as? String)!, transactionId: (args["transactionId"] as? String)!)
    }
    
}
