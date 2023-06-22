import Flutter
import UIKit
import NewRelic

class SwiftFlutterNotificationPlugin: NSObject, FlutterPlugin, FlutterStreamHandler, UNUserNotificationCenterDelegate {
    
    static var result: FlutterResult!
    static var eventSink: FlutterEventSink? //觸發事件
    var _deviceToken: String = "" //紀錄deviceToken
    static var _notificationAuth: NotificationAuth = .none //授權狀態
    var _message: String = "" //紀錄message資訊
    var _appProjectName: String = "MobilePossApp";
    static var _fromGetNotificationPermissionMethod: Bool = false;
    
    static func register(with registrar: FlutterPluginRegistrar) {
        NSLog("SwiftFlutterNotificationPlugin registrar")
        let channel = FlutterMethodChannel(name: "flutter_notification", binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterNotificationPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        let eventChannel = FlutterEventChannel(name: "flutter_notification_event", binaryMessenger: registrar.messenger())
        eventChannel.setStreamHandler(instance)
        registrar.addApplicationDelegate(instance)
    }
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        NSLog("SwiftFlutterNotificationPlugin onListen")
        SwiftFlutterNotificationPlugin.eventSink = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        NSLog("SwiftFlutterNotificationPlugin onCancel")
        return nil
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        SwiftFlutterNotificationPlugin.result = result
        SwiftFlutterNotificationPlugin._fromGetNotificationPermissionMethod = false
        self.newRelicNotification(message: "FlutterMethodCall:\(call.method)")
        if call.arguments == nil {
            result(FlutterError( code: "Error", message: "arg empty", details: ""))
            return
        }
        let args = call.arguments as! Dictionary<String, AnyObject>;
        switch call.method {
        case "getDeviceToken":
            self.getDeviceToken();
            break
        case "eventGetDeviceToken":
            self.eventGetDeviceToken()
            break
        case "clearDeviceToken":
            self.clearDeviceToken()
            break
        case "getApplicationIconBadgeNumber":
            self.getApplicationIconBadgeNumber()
            break
        case "updateApplicationIconBadgeNumber":
            self.updateApplicationIconBadgeNumber(args: args)
            break
        case "eventGetNotificationRouterMessage":
            self.eventGetNotificationRouterMessage()
            break
        case "clearNotificationRouterMessage":
            self.clearNotificationRouterMessage()
            break
        case "getNotificationPermission":
            SwiftFlutterNotificationPlugin._fromGetNotificationPermissionMethod = true
            self.getNotificationPermission()
            break
        default:
            result(FlutterError( code: "Error", message: "call method error", details: ""))
            break
        }
    }
    
    //new relic error訊息
    func newRelicError(message: String){
        NewRelic.recordCustomEvent("FTError", attributes: ["errorMessage" : message, "appProjectName": self._appProjectName])
    }
    
    //new relic notification訊息
    func newRelicNotification(message: String){
        NewRelic.recordCustomEvent("FTNotification", attributes: ["Messages" : message, "appProjectName": self._appProjectName])
    }
    
    //app運作起點
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [AnyHashable : Any] = [:]) -> Bool {
        NSLog("SwiftFlutterNotificationPlugin didFinishLaunchingWithOptions");
        self.newRelicNotification(message: "SwiftFlutterNotificationPlugin didFinishLaunchingWithOptions")
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if error != nil {
                NSLog(String(describing: error))
                self.newRelicError(message: "requestAuthorization error:\(String(describing: error?.localizedDescription))")
                return
            }
            NSLog("SwiftFlutterNotificationPlugin didFinishLaunchingWithOptions granted:\(String(describing: granted))");
            self.newRelicNotification(message: "didFinishLaunchingWithOptions granted:\(String(describing: granted))")
            if granted {
//                 self.getNotificationSettings()
            }
        }
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    //取得推播權限
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            NSLog("getNotificationSettings authorizationStatus:\(String(describing: settings.authorizationStatus.rawValue))")
            self.newRelicNotification(message: "getNotificationSettings authorizationStatus:\(String(describing: settings.authorizationStatus.rawValue))")
            guard settings.authorizationStatus == .authorized else {
                SwiftFlutterNotificationPlugin._notificationAuth = .none
                return
            }
            SwiftFlutterNotificationPlugin._notificationAuth = .agree
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications() //註冊接收推播訊息服務
            }
        }
    }
    
    //取得device token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        var tokenString : String = ""
        for byte in deviceToken {
            let hexString = String(format: "%02x", byte)
            tokenString += hexString
        }
        NSLog("SwiftFlutterNotificationPlugin Device Token: \(tokenString), _fromGetNotificationPermissionMethod: \(String(describing: SwiftFlutterNotificationPlugin._fromGetNotificationPermissionMethod))")
        guard !tokenString.isEmpty else {
            self.newRelicError(message: "didRegisterForRemoteNotificationsWithDeviceToken deviceToken empty, _fromGetNotificationPermissionMethod: \(String(describing: SwiftFlutterNotificationPlugin._fromGetNotificationPermissionMethod))")
            return
        }
        self.newRelicNotification(message: "didRegisterForRemoteNotificationsWithDeviceToken finish")
        self._deviceToken = tokenString
        if SwiftFlutterNotificationPlugin._fromGetNotificationPermissionMethod {
            self.resultNotificationPermission()
        }else{
            self._sendDeviceToken()
        }
    }
    
    //取得device token error
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        NSLog("SwiftFlutterNotificationPlugin didFailToRegisterForRemoteNotificationsWithError error: \(error.localizedDescription), _fromGetNotificationPermissionMethod: \(String(describing: SwiftFlutterNotificationPlugin._fromGetNotificationPermissionMethod))")
        self.newRelicError(message: "apns get deviceToken error,\(error.localizedDescription), _fromGetNotificationPermissionMethod: \(String(describing: SwiftFlutterNotificationPlugin._fromGetNotificationPermissionMethod))")
        self.resultNotificationPermission()
    }
    
    //換回前景時
    func applicationWillEnterForeground(_ application: UIApplication) {
        self._sendBadgeNumber()
        self.eventGetNotificationRouterMessage()
    }
    
    //讓app前景也可以收到訊息
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        NSLog("SwiftFlutterNotificationPlugin userNotificationCenter willPresent")
        completionHandler([.badge, .sound, .alert])
    }
    
    //點擊推播訊息
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        self._message = "";
        NSLog("SwiftFlutterNotificationPlugin userNotificationCenter didReceive")
        let userInfo = response.notification.request.content.userInfo
        guard userInfo["aps"] != nil,
              userInfo["message"] != nil else {
            self._message = ""
            NSLog("userNotificationCenter userInfo error : \(String(describing: userInfo))")
            self.newRelicError(message: "userNotificationCenter userInfo error : \(String(describing: userInfo))")
            completionHandler()
            return
        }
        
        guard let object = userInfo["message"] as? [String: Any] else {
            NSLog("userNotificationCenter userInfo cover error : \(String(describing: userInfo))")
            self.newRelicError(message: "userNotificationCenter userInfo cover error : \(String(describing: userInfo))")
            self._message = ""
            completionHandler()
            return
        }
        
        let data = self.encodeJson(object: object);
        if data.isEmpty {
            self._message = ""
            completionHandler()
            return
        }
        self._message = data
        self.eventGetNotificationRouterMessage()
        completionHandler()
    }
    
    //回傳NotificationPermission 因為會有非同步狀況,導致native還未取得deviceToken,就已經完成流程,導致顯示裝置取得推播失敗訊息出現
    func resultNotificationPermission(){
        NSLog("resultNotificationPermission _fromGetNotificationPermissionMethod: \(String(describing: SwiftFlutterNotificationPlugin._fromGetNotificationPermissionMethod)), _notificationAuth:\(String(describing: SwiftFlutterNotificationPlugin._notificationAuth))")
        self.newRelicNotification(message: "resultNotificationPermission _fromGetNotificationPermissionMethod: \(String(describing: SwiftFlutterNotificationPlugin._fromGetNotificationPermissionMethod)), _notificationAuth:\(String(describing: SwiftFlutterNotificationPlugin._notificationAuth))")
        guard SwiftFlutterNotificationPlugin._fromGetNotificationPermissionMethod,
              SwiftFlutterNotificationPlugin.result != nil else {
            return
        }
        if SwiftFlutterNotificationPlugin._notificationAuth == .agree {
            SwiftFlutterNotificationPlugin.result("agree")
        }else {
            SwiftFlutterNotificationPlugin.result("none")
        }
    }
    
    
    //取得deviceToken
    func getDeviceToken() {
        if SwiftFlutterNotificationPlugin._notificationAuth == .none {
            NSLog("SwiftFlutterNotificationPlugin getDeviceToken _notificationAuth is none")
            self.newRelicError(message: "getDeviceToken Notification not allow")
            SwiftFlutterNotificationPlugin.result("")
            return
        }else if self._deviceToken.isEmpty {
            NSLog("SwiftFlutterNotificationPlugin getDeviceToken _deviceToken empty")
            self.newRelicError(message: "getDeviceToken Notification _deviceToken empty")
            SwiftFlutterNotificationPlugin.result("")
            return
        }
        SwiftFlutterNotificationPlugin.result(self._deviceToken)
    }
    
    //event 回傳 deviceToken
    func eventGetDeviceToken() {
        if SwiftFlutterNotificationPlugin._notificationAuth == .none {
            NSLog("SwiftFlutterNotificationPlugin eventGetDeviceToken _notificationAuth is none")
            self.newRelicError(message: "eventGetDeviceToken Notification not allow")
            return
        }else if self._deviceToken.isEmpty {
            NSLog("SwiftFlutterNotificationPlugin eventGetDeviceToken _deviceToken empty")
            self.newRelicError(message: "eventGetDeviceToken Notification _deviceToken empty")
            return
        }
        self._sendDeviceToken()
    }
    
    //清除token
    func clearDeviceToken() {
        self._deviceToken = "";
    }
    
    //更新未讀數
    func updateApplicationIconBadgeNumber(args : Dictionary<String, AnyObject>) {
        guard var number = args["number"] as? Int else {
            SwiftFlutterNewRelicPlugin.result(FlutterError( code: "Error", message: "arg number error", details: ""))
            return
        }
        if number <= 0 {
            number = -1
        }
        //更新未讀數
        UIApplication.shared.applicationIconBadgeNumber = number
    }
    
    //取得未讀數
    func getApplicationIconBadgeNumber() {
        let number = UIApplication.shared.applicationIconBadgeNumber
        if number <= 0 { return }
        SwiftFlutterNotificationPlugin.result(number)
    }
    
    private func _sendDeviceToken(){
        guard !self._deviceToken.isEmpty else {
            return
        }
        let object: [String: String] = [
            "notificationType" : "deviceToken",
            "content" : self._deviceToken
        ]
        let data = self.encodeJson(object: object);
        if data.isEmpty {
            NSLog("_sendDeviceToken json string empty")
            return
        }
        SwiftFlutterNotificationPlugin.eventSink?(data)
    }
    
    //傳送未讀數
    func _sendBadgeNumber() {
        guard UIApplication.shared.applicationIconBadgeNumber > 0 else {
            NSLog("_sendBadgeNumber BadgeNumber <= 0")
            return;
        }
        let object: [String: String] = [
            "notificationType" : "badgeNumber",
            "content" : String(UIApplication.shared.applicationIconBadgeNumber)
        ]
        
        let data = self.encodeJson(object: object);
        if data.isEmpty {
            NSLog("_sendBadgeNumber json string empty")
            return
        }
        SwiftFlutterNotificationPlugin.eventSink?(data)
    }
    
    //推送router 資訊
    func eventGetNotificationRouterMessage() {
        guard !self._message.isEmpty else {
            NSLog("eventGetNotificationRouterMessage self._router empty")
            return
        }
        let object: [String: String] = [
            "notificationType" : "routerMessage",
            "content" : self._message
        ]
        let data = self.encodeJson(object: object);
        if data.isEmpty {
            NSLog("eventGetNotificationRouterMessage json string empty")
            return
        }
        SwiftFlutterNotificationPlugin.eventSink?(data)
    }
    
    //清空router 資訊
    func clearNotificationRouterMessage(){
        self._message = ""
    }
    
    // object to json string
    private func encodeJson(object: [String: Any]) -> String {
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: object, options: .fragmentsAllowed)
            let data = String(data: jsonData as Data, encoding: .utf8) ?? ""
            return data
        }catch{
            NSLog("encodeJson error :\(error.localizedDescription)")
            return ""
        }
    }
    
    //取得推播授權
    private func getNotificationPermission() {
        //simulator 不支援推播
        #if targetEnvironment(simulator)
            NSLog("getNotificationPermission in simulator")
            SwiftFlutterNotificationPlugin.result("none")
        #else
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                NSLog("getNotificationPermission authorizationStatus:\(String(describing: settings.authorizationStatus.rawValue))")
                guard settings.authorizationStatus == .authorized else {
                    SwiftFlutterNotificationPlugin._notificationAuth = .none
                    SwiftFlutterNotificationPlugin.result("none")
                    return
                }
                SwiftFlutterNotificationPlugin._notificationAuth = .agree
                if self._deviceToken.isEmpty {
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications() //重新註冊接收推播訊息服務
                    }
                }else{
                    SwiftFlutterNotificationPlugin.result("agree")
                }
            }
        #endif
    }
    
}

//推播授權狀態
enum NotificationAuth {
    case none
    case agree
}
