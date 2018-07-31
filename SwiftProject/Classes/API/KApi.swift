
//  KApi.swift
//  Created by KJoe on 2018/3/7.


import Moya
import SwiftyJSON

//初始化豆瓣FM请求的provider
let KJoeApiProvider = MoyaProvider<KJoeApi>()
 
/** 下面定义豆瓣FM请求的endpoints（供provider使用）**/

//请求分类
public enum KJoeApi {
    case channels  //获取频道列表
    case playlist(String) //获取歌曲
    case upload(img:UIImage) //上传文件
    case reying
    case banner(type:String)
}

//请求配置
extension KJoeApi: TargetType {
    //服务器地址
    public var baseURL: URL {
        switch self {
        case .channels:
            return URL(string: "https://www.douban.com")!
        case .playlist(_):
            return URL(string: "https://douban.fm")!
        case .banner(_):
            return URL(string: "http://api.wtlyhqb.com/onewallet-webapi")!
        default:
            return URL(string: "https://www.douban.com")!
        }
        //return URL(string: "https://www.douban.com")!
    }
    //各个请求的具体路径
    public var path: String {
        switch self {
        case .channels:
            return "/j/app/radio/channels"
        case .playlist(_):
            return "/j/mine/playlist"
        case .upload( _):
            return "/j/mine/playlist"
        case .reying:
            return "/v2/movie/in_theaters"
        case .banner:
            return "/wallet/getAdverts"
        }
    }
    
    //请求类型
    public var method: Moya.Method {
        return .get
    }
    
    //请求任务事件（这里附带上参数）
    public var task: Task {
        switch self {
        case .playlist(let channel):
            var params: [String: Any] = [:]
            params["channel"] = channel
            params["type"] = "n"
            params["from"] = "mainsite"
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding.default)
        case .reying:
            var params: [String: Any] = [:]
            params["city"] = "北京"
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding.default)
            
        case let.banner(type):
            var params: [String: Any] = [:]
            params["advertType"] =  type
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding.default)
            
        case let .upload(img):
            
            var params: [String: Any] = [:]
            params["type"] = "n"
            params["from"] = "mainsite"
            let data = UIImageJPEGRepresentation(img, 0.7)
            let img = MultipartFormData(provider: .data(data!), name: "参数名", fileName: "名称随便写.jpg", mimeType: "image/jpeg")
            return .uploadCompositeMultipart(([img]), urlParameters: params)
        default:
            return .requestPlain
        }
    }
    
    //是否执行Alamofire验证
    public var validate: Bool {
        return false
    }
    
    //这个就是做单元测试模拟的数据，只会在单元测试文件中有作用
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    //请求头
    public var headers: [String: String]? {
        return nil
    }
    
}


let LoadingPlugin = NetworkActivityPlugin { (type, target) in
    guard let vc = topVC else { return }
    
    switch type {
    case .began:
        print("begin")
    case .ended:
        print("end")
    }
}

let timeoutClosure = {(endpoint: Endpoint<KJoeApi>, closure: MoyaProvider<KJoeApi>.RequestResultClosure) -> Void in
    
    if var urlRequest = try? endpoint.urlRequest() {
        urlRequest.timeoutInterval = 20
        closure(.success(urlRequest))
    } else {
        closure(.failure(MoyaError.requestMapping(endpoint.url)))
    }
}

//
struct KNetwork {

    static let provider = MoyaProvider<KJoeApi>()
    static let providerLoading = MoyaProvider<KJoeApi>(requestClosure: timeoutClosure, plugins: [LoadingPlugin])

    static func request(
        _ target: KJoeApi,
        success successCallback: @escaping (JSON) -> Void,
        error errorCallback: @escaping (Int) -> Void,
        failure failureCallback: @escaping (MoyaError) -> Void
        ) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    //如果数据返回成功则直接将结果转为JSON
                    try response.filterSuccessfulStatusCodes()
                    let json = try JSON(response.mapJSON())
                    successCallback(json)
                }
                catch let error {
                    //如果数据获取失败，则返回错误状态码
                    errorCallback((error as! MoyaError).response!.statusCode)
                }
            case let .failure(error):
                failureCallback(error)
            }
        }
    }

    static func loadingrequest(
        _ target: KJoeApi,
        success successCallback: @escaping (JSON) -> Void,
        error errorCallback: @escaping (Int) -> Void,
        failure failureCallback: @escaping (MoyaError) -> Void
        ) {
        providerLoading.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    //如果数据返回成功则直接将结果转为JSON
                    try response.filterSuccessfulStatusCodes()
                    let json = try JSON(response.mapJSON())
                    successCallback(json)
                }
                catch let error {
                    //如果数据获取失败，则返回错误状态码
                    errorCallback((error as! MoyaError).response!.statusCode)
                }
            case let .failure(error):
                failureCallback(error)
            }
        }
    }
}


