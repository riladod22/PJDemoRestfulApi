//
//  WebService.swift
//  DemoRestfulApi
//
//  Created by PujieLee on 2022/9/22.
//

import Foundation

class WebService {
    
    static let sharedInstance = WebService()

    func httpRequest<T: Codable>(_ path: String, method: HTTPMethod, paramaters: [String:String]?, needValidate: Bool = false, completion: @escaping (Result<T>) -> Void){
        
        //產生URL & Body
        var url: URL?
        var data: Data?
        if method == .get {
            url = createPath(apiMethod: Domain.URL_HOST+path, parameter: paramaters)
        }else{
            url = URL(string: Domain.URL_HOST+path)
            
            let encoder = JSONEncoder()
            data = try? encoder.encode(paramaters)
        }
        
        //產生header
        let headerCreator = HTTPHeaderCreater(method: method)
        if needValidate {
            headerCreator.addSessionToken(LoginDataStorage.sharedInstance.loginData?.sessionToken)
        }
        
        if let url = url{
            
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            request.allHTTPHeaderFields = headerCreator.output()
            request.httpBody = data
            
            sendRequest(request) { result in
                completion(result)
            }
        }else{
            completion(.failure(NetworkResponse.failed.rawValue))
        }
    }
}

extension WebService{
    
    private func sendRequest<T: Codable>(_ request: URLRequest, completion: @escaping (Result<T>) -> Void ) {
        
        URLSession.shared.dataTask(with: request) { data, response, error in

            if error != nil {
                completion(.failure("網路連線出現異常"))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                
                switch response.statusCode {
                case 200...299:
                    //success
                    guard let data = data else {
                        completion(.failure(NetworkResponse.noData.rawValue))
                        return
                    }
                    
                    do {
                        let jsonDecoder = JSONDecoder()
                        let response = try jsonDecoder.decode(T.self, from: data)
                        completion(.success(response))
                    } catch {
                        completion(.failure(NetworkResponse.unableToDecode.rawValue))
                    }
                default:
                    //failure
                    let errorMsg = self.handleNetworkResponseMessage(response)
                    completion(.failure(errorMsg))
                }
            }
        }.resume()

    }
    
}

extension WebService{
    
    private func createPath(apiMethod: String, parameter: [String: String]?) -> URL? {
        
        var sUrl = apiMethod
        
        if let par = parameter{
            
            sUrl.append("?")
            
            for key in par.keys {
                sUrl.append("\(key)=\(par[key] ?? "")")
            }
        }
        
        return URL(string: sUrl)
    }
    
    
    private func handleNetworkResponseMessage(_ response: HTTPURLResponse) -> String{
        switch response.statusCode {
        case 200...299: return ""
        case 401...500: return NetworkResponse.authenticationError.rawValue
        case 500...599: return NetworkResponse.badRequest.rawValue
        case 600: return NetworkResponse.outdated.rawValue
        default: return NetworkResponse.failed.rawValue
        }
    }
    
}

//header 產生器
class HTTPHeaderCreater {
    private var headers: [String: String] = [:]
    
    init(method: HTTPMethod){
        headers = [
            "X-Parse-Application-Id": Domain.APPLICATION_ID,
            "X-Parse-Revocable-Session": Domain.REST_API_KEY,
            "X-Parse-REST-API-Key": "1"
        ]
        
        if method != .get {
            headers["Content-Type"] = "application/json"
        }
    }
    
    fileprivate func addSessionToken(_ sToken: String?){
        //增加驗證 Session Token
        headers["X-Parse-Session-Token"] = sToken ?? ""
    }
    
    fileprivate func output() -> [String: String]{
        return headers
    }
}

//class path產生器？？ {
