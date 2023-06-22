import UIKit
import Flutter
import NewRelic

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, XMLParserDelegate {
    
    private var _checkVersionState: CheckVersionState = .stop
    private var _xmlElementType: XmlElementType = .null
    private var _bundleVersionState: BundleVersionState = .no
    private var _bundleVersion : String?
    private var _appVersion: String?
    private var _downloadUrl: String?
    private var _localeString: String = "新版本已發布請下載更新"
    private var _appProjectName: String = "MobilePossApp";
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let _locale: String = Locale.preferredLanguages.first ?? ""
        NSLog("_locale: \(_locale)")
        if !_locale.isEmpty {
            let _locale = _locale.replacingOccurrences(of: "-", with: "_")
            if _locale.contains("zh_Hans") || _locale.contains("wuu_Hans") || _locale.contains("yue_Hans") || _locale.contains("zh_CN") {
                self._localeString = "新版本已发布请下载更新"
            }
        }
        NSLog("_localeString: \(self._localeString)")
        
        if let NewRelicToken = Bundle.main.object(forInfoDictionaryKey: "NewRelicToken") as? String {
            NSLog("NewRelicToken: \(NewRelicToken)")
            NewRelic.start(withApplicationToken: NewRelicToken)
        }
        
        //self.getManifestFile()
//         SwiftFlutterNotificationPlugin.register(with: self.registrar(forPlugin: "SwiftFlutterNotificationPlugin")!)
        SwiftFlutterNewRelicPlugin.register(with: self.registrar(forPlugin: "SwiftFlutterNewRelicPlugin")!)
        GeneratedPluginRegistrant.register(with: self)
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    /* ===== check version ==== */
    //取得getManifestFile
    func getManifestFile(){
        let _log: String = "getManifestFile _checkVersionState:\(String(describing: self._checkVersionState)) isInDebugMode:\(String(describing: AppUtil.isInDebugMode))"
        NSLog(_log)
        self.newRelicCustomEvent(event: "FTVersion", message: _log)
        if self._checkVersionState == .start {
            NSLog("AppDelegate getManifestFile getManifestUrl start")
            return;
        }else if AppUtil.isInDebugMode { //開發過程不需要判斷
            NSLog("AppDelegate getManifestFile Debug")
            return
        }
        
        //取得info.plist 資料
        guard let getManifestUrl = Bundle.main.object(forInfoDictionaryKey: "GetManifestUrl") as? String,
             let _version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String,
             let _downloadUrl = Bundle.main.object(forInfoDictionaryKey: "AppDownloadUrl") as? String
        else {
            NSLog("AppDelegate getManifestFile get Bundle plist error")
            self.newRelicCustomEvent(event:"FTError", message: "AppDelegate getManifestFile get Bundle plist error")
            self._checkVersionState = .stop
            return
        }
        
        self._appVersion = _version
        self._downloadUrl = _downloadUrl
        
        self.checkVersion(url: getManifestUrl)
    }
    
    //版本確認
    func checkVersion(url: String) {
        let now = Date()
        let timeInterval:TimeInterval = now.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        let _url = "\(url)?v=\(timeStamp)"
        self.newRelicCustomEvent(event: "FTVersion", message: "checkVersion url:\(String(describing: _url))")
        //抓取檔案內容
        let url = URL(string: _url)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data else {
                self._checkVersionState = .stop
                self.newRelicCustomEvent(event:"FTError", message: "AppDelegate getManifestFile http error")
                return
            }
            let plist = data as Data
            let parser: XMLParser? = XMLParser(data: plist)
            parser?.delegate = self
            let result: Bool? = parser?.parse()
            if result == false {
                self.newRelicCustomEvent(event:"FTError", message: "AppDelegate XMLParser.parse() false")
                self._checkVersionState = .stop
            }
        }.resume()
    }
    
    //解析key
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        switch elementName {
        case "key":
            self._xmlElementType = .key
            break
        case "string":
            self._xmlElementType = .string
            break
        default:()
        }
        
    }
    
    //回傳key裡面的值
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        //NSLog("XMLParser foundCharacters :\(string)")
        if self._xmlElementType == .key, string == "bundle-version" {
            self._bundleVersionState = .yes
        }else if self._bundleVersionState == .yes, self._xmlElementType == .string, !string.contains("\n") {
            self._bundleVersionState = .no
            self._bundleVersion = string
        }
    }
    
    //解析完成
    func parserDidEndDocument(_ parser: XMLParser) {
        NSLog("XMLParser parserDidEndDocument _bundleVersion:\(String(describing: self._bundleVersion)), _appVersion:\(String(describing: self._appVersion)), AppUtil.isInDebugMode: \(String(describing: AppUtil.isInDebugMode)) ")
        self._checkVersionState = .stop
       if self._bundleVersion != self._appVersion {
            self.showDownloadMessage()
        }
    }
    
    //解析失敗
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        NSLog("XMLParser parseErrorOccurred :\(parseError.localizedDescription)")
        self.newRelicCustomEvent(event:"FTError", message: "XMLParser parseErrorOccurred :\(parseError.localizedDescription)")
        self._checkVersionState = .stop
    }
    
    /* ========= */
    
    //newRelicCustomEvent
    func newRelicCustomEvent(event: String, message: String){
        NewRelic.recordCustomEvent(event, attributes: ["errorMessage" : message, "appProjectName": self._appProjectName])
    }
    
    //顯示下載訊息
    func showDownloadMessage() {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: self._localeString, message: nil, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {(_) -> Void in
                guard let url: URL = URL(string: self._downloadUrl!),
                      UIApplication.shared.canOpenURL(url) else{
                    return;
                }
                UIApplication.shared.openURL(url)
            }))
            
            let topMostViewController = UIApplication.shared.keyWindow?.rootViewController
            let presentedViewController = topMostViewController?.presentedViewController
            if presentedViewController != nil{
                presentedViewController?.present(alertController, animated: true, completion: nil)
            }else{
                self.window.rootViewController?.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
}

//確認版本狀態
enum CheckVersionState {
    //開始確認
    case start
    //停止確認
    case stop
}

//xml parser Element 類型 key or string
enum XmlElementType {
    case key
    case string
    case null
}

//是否為bundle-version
enum BundleVersionState {
    case yes
    case no
}

//判斷是否為debug模式
struct AppUtil {
  static var isInDebugMode: Bool {
    // Ensure this matches the custom flag you defined in Step 1
    #if MARKUS_DEBUG
      return true
    #else
      return false
    #endif
  }
}


