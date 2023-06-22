import Flutter
import UIKit
import NewRelic

enum NewRelicInit {
    case start
    case unowned
}

public class SwiftFlutterNewRelicPlugin: NSObject, FlutterPlugin {
    static var result: FlutterResult!
    private var newRelicInit: NewRelicInit = .unowned
    private let appProjectName: String = "MobilePossApp"
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_new_relic", binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterNewRelicPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.arguments == nil {
            result(FlutterError( code: "Error", message: "arg empty", details: ""))
            return
        }
        SwiftFlutterNewRelicPlugin.result = result
        let args = call.arguments as! Dictionary<String, AnyObject>;
        switch call.method {
        case "initNewRelic":
            self.initNewRelic(args: args);
            break;
        case "incrementAttribute":
            self.incrementAttribute(args: args)
            break
        case "setUserId":
            self.recordCustomEventByUserId(args: args)
            break
        case "setInteraction":
            self.recordCustomEventByInteraction(args: args)
            break
        case "recordCustomEventByJson":
            self.recordCustomEventByJson(args: args)
            break
        case "recordCustomEventByMessage":
            self.recordCustomEventByMessage(args: args)
            break
        case "recordCustomEventByError":
            self.recordCustomEventByError(args: args)
            break
        case "noticeHttpTransaction":
            self.noticeHttpTransaction(args: args)
            break
        case "noticeNetworkFailure":
            self.noticeNetworkFailure(args: args)
            break
        default:
            result(FlutterError( code: "Error", message: "call method error", details: ""))
            break
        }
    }
    
    //new relic 開始監聽
    func initNewRelic(args : Dictionary<String, AnyObject>) {
        guard let token = args["token"] as? String,
              !token.isEmpty
              else {
            SwiftFlutterNewRelicPlugin.result(FlutterError( code: "Error", message: "arg token error", details: ""))
            return
        }
        guard self.newRelicInit == .unowned else {
            SwiftFlutterNewRelicPlugin.result(FlutterError( code: "Error", message: "newrelic start already", details: ""))
            return
        }
        self.newRelicInit = .start
        NewRelic.start(withApplicationToken: token)
    }
    
    //追蹤發生次數
    func incrementAttribute(args : Dictionary<String, AnyObject>) {
        guard let name = args["name"] as? String,
              var value = args["value"] as? Int,
              !name.isEmpty
              else {
            SwiftFlutterNewRelicPlugin.result(FlutterError( code: "Error", message: "arg name or value error", details: ""))
            return
        }
        if value <= 0 {
            value = 1
        }
        let bool = NewRelic.incrementAttribute(name, value: value as NSNumber)
        if bool == false {
            SwiftFlutterNewRelicPlugin.result(FlutterError( code: "NewRelicError", message: "send fail", details: ""))
        }
    }
    
    //紀錄userId
    func recordCustomEventByUserId(args : Dictionary<String, AnyObject>) {
        guard let userId = args["userId"] as? String,
              !userId.isEmpty  else {
            SwiftFlutterNewRelicPlugin.result(FlutterError( code: "Error", message: "arg userId error", details: ""))
            return
        }
        let bool = NewRelic.recordCustomEvent("FTUserId", attributes: ["UserId" : userId, "appProjectName": self.appProjectName])
        if bool == false {
            SwiftFlutterNewRelicPlugin.result(FlutterError( code: "NewRelicError", message: "send fail", details: ""))
        }
    }
    
    //紀錄頁面名稱
    func recordCustomEventByInteraction(args : Dictionary<String, AnyObject>) {
        guard let screen = args["screen"] as? String,
              !screen.isEmpty else {
            SwiftFlutterNewRelicPlugin.result(FlutterError( code: "Error", message: "arg screen empty", details: ""))
            return
        }
        let bool = NewRelic.recordCustomEvent("FTInteraction", attributes: ["Screen" : screen, "appProjectName": self.appProjectName])
        if bool == false {
            SwiftFlutterNewRelicPlugin.result(FlutterError( code: "NewRelicError", message: "send fail", details: ""))
        }
    }
    
    //自訂義事件名稱與內容 by json
    func recordCustomEventByJson(args : Dictionary<String, AnyObject>) {
        guard let eventName = args["eventName"] as? String,
              let jsonString = args["jsonString"] as? String,
              !eventName.isEmpty,
              !jsonString.isEmpty,
              let data = jsonString.data(using: .utf8) else {
            SwiftFlutterNewRelicPlugin.result(FlutterError( code: "Error", message: "arg eventName or jsonString error", details: ""))
            return
        }
        
        do{
            let json = try JSONSerialization.jsonObject(with: data, options:[]) as? Dictionary<String, Any>
            guard let _json = json else {
                SwiftFlutterNewRelicPlugin.result(FlutterError( code: "Error", message: "jsonString json decode", details: ""))
                return
            }
            var newJson: [String: String] = [:]
            for (key, value) in _json {
                var _newValue: String?
                if value is NSDictionary || value is NSArray {
                    let _value = try JSONSerialization.data(withJSONObject: value, options: [])
                    _newValue = String(data: _value, encoding: .utf8)
                } else {
                    _newValue = value as? String
                }
                newJson[key] = _newValue
            }
            guard !newJson.isEmpty else {
                SwiftFlutterNewRelicPlugin.result(FlutterError( code: "Error", message: "send json data nil", details: ""))
                return
            }
            newJson["appProjectName"] = self.appProjectName
            let bool = NewRelic.recordCustomEvent(eventName, attributes: newJson)
            if bool == false {
                SwiftFlutterNewRelicPlugin.result(FlutterError( code: "NewRelicError", message: "send fail", details: ""))
            }
        } catch {
            SwiftFlutterNewRelicPlugin.result(FlutterError( code: "Exception", message: error.localizedDescription, details: ""))
        }
    }
    
    //自訂義事件名稱與內容 by Message
    func recordCustomEventByMessage(args : Dictionary<String, AnyObject>) {
        guard let eventName = args["eventName"] as? String,
              let message = args["message"] as? String,
              !eventName.isEmpty,
              !message.isEmpty
              else {
            SwiftFlutterNewRelicPlugin.result(FlutterError( code: "Error", message: "arg eventName or message error", details: ""))
            return
        }
        let bool = NewRelic.recordCustomEvent(eventName, attributes: ["Messages" : message, "appProjectName": self.appProjectName])
        if bool == false {
            SwiftFlutterNewRelicPlugin.result(FlutterError( code: "NewRelicError", message: "send fail", details: ""))
        }
    }
    
    //錯誤訊息
    func recordCustomEventByError(args : Dictionary<String, AnyObject>) {
        guard let errorMessage = args["errorMessage"] as? String,
              !errorMessage.isEmpty
              else {
            SwiftFlutterNewRelicPlugin.result(FlutterError( code: "Error", message: "arg errorMessage error", details: ""))
            return
        }
        let bool = NewRelic.recordCustomEvent("FTError", attributes: ["errorMessage" : errorMessage, "appProjectName": self.appProjectName])
        if bool == false {
            SwiftFlutterNewRelicPlugin.result(FlutterError( code: "NewRelicError", message: "send fail", details: ""))
        }
    }
    
    //Http Transaction
    func noticeHttpTransaction(args : Dictionary<String, AnyObject>) {
        guard let url = args["url"] as? String,
              !url.isEmpty,
              let httpMethod = args["httpMethod"] as? String,
              !httpMethod.isEmpty,
              let statusCode = args["statusCode"] as? Int,
              !(statusCode == 0),
              let startTime = args["startTime"] as? Int,
              !(startTime == 0),
              let endTime = args["endTime"] as? Int,
              !(endTime == 0),
              let requestSize = args["requestSize"] as? UInt,
              let responseSize = args["responseSize"] as? UInt
              else {
            SwiftFlutterNewRelicPlugin.result(FlutterError( code: "Error", message: "arg error", details: ""))
            return
        }
        let _time = endTime - startTime
        NSLog("noticeHttpTransaction asyncAfter _time: \(String(describing: _time)) milliseconds, start")
        let timer = NRTimer()
        timer.startTimeInMillis()
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(_time), execute: {
            NewRelic.noticeNetworkRequest(for: URL(string: url),
                                          httpMethod: httpMethod,
                                          with: timer,
                                          responseHeaders: nil,
                                          statusCode: statusCode,
                                          bytesSent: requestSize,
                                          bytesReceived: responseSize,
                                          responseData: nil,
                                          andParams: [:])
            timer.endTimeInMillis()
            NSLog("noticeHttpTransaction stop")
        })
        
    }
    
    //Http NetworkFailure
    func noticeNetworkFailure(args : Dictionary<String, AnyObject>) {
        guard let url = args["url"] as? String,
              !url.isEmpty,
              let httpMethod = args["httpMethod"] as? String,
              !httpMethod.isEmpty,
              let statusCode = args["statusCode"] as? Int,
              let startTime = args["startTime"] as? Int,
              !(startTime == 0),
              let endTime = args["endTime"] as? Int,
              !(endTime == 0)
              else {
            SwiftFlutterNewRelicPlugin.result(FlutterError( code: "Error", message: "arg error", details: ""))
            return
        }
        
        let _time = endTime - startTime
        NSLog("noticeNetworkFailure asyncAfter _time: \(String(describing: _time)) milliseconds, start")
        let timer = NRTimer()
        timer.startTimeInMillis()
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(_time), execute: {
            NewRelic.noticeNetworkFailure(for: URL(string: url), httpMethod: httpMethod, with: timer, andFailureCode: statusCode)
            timer.endTimeInMillis()
            NSLog("noticeNetworkFailure stop")
        })
    }
    
}
