//
//  RequestManage.swift
//  LoginProject
//
//  Created by Phan Hai on 31/07/2020.
//  Copyright © 2020 Phan Hai. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RxCocoa
import RxSwift


struct ApiUrl{
    static let BASE_API_URL = "http://yelp-test.kennjdemo.com/api/v1/"
//    http://yelp-test.kennjdemo.com/api/v1/user/login
}

struct ApiConfig{
    static let TIMEOUT_INTERVAL = 10
}

public class RequestManager {
    static let disposeBag = DisposeBag()
    class func getJSON(url: String!, parameters: Dictionary<String, Any>?, method: HTTPMethod) -> Observable<JSON>{
        return Observable.create({ (observe) -> Disposable in
            let request =  Alamofire.request(ApiUrl.BASE_API_URL + url,
                                                    method: method,
                                                    parameters: parameters,
                                                    encoding: JSONEncoding.default,
                                                    headers: nil).responseJSON { (response) in
                                                        switch response.result {
                                                        case .success(let value):
                                                            let swiftJsonVar = JSON(value)
                                                            observe.onNext(swiftJsonVar)
                                                            observe.onCompleted()
                                                                print("------------ API RESPONSE ---------")
                                                                print("//")
                                                                print("//Method: POST")
                                                                print("//url")
                                                                print("//\(ApiUrl.BASE_API_URL + url)")
                                                                print("//Parameters")
                                                                print("\(String(describing: parameters))")
                                                                print("//")
                                                                print("\(swiftJsonVar)")
                                                                print("-----------------------------------")
                                                        case .failure(let error):
                                                            observe.onError(error)
                                                            observe.onCompleted()
                                                            print("Check res", response)
                                                        }
            }
            return Disposables.create {
                request.cancel()
            }
        })
    }
    
    class func APIData<T:Codable>(ofType type: T.Type, url: String, parameters: Dictionary<String, Any>?, method: HTTPMethod ) -> Observable<ApiResult<T, ErrorGeneral>> {
        return Observable<ApiResult<T, ErrorGeneral>>.create({ (observe) -> Disposable in
            getJSON(url: url, parameters: parameters, method: method)
                .asObservable()
                .subscribe(onNext: { (msg) in
                    do {
                        if let jsonDic = msg.dictionaryObject {
                            if msg["result"] == true {
                                let data = try JSONSerialization.data(withJSONObject: jsonDic, options: .prettyPrinted)
                                let objec = try JSONDecoder().decode(T.self, from: data)
                                observe.onNext(.success(objec))
                                observe.onCompleted()
                            } else {
                                let data = try JSONSerialization.data(withJSONObject: jsonDic, options: .prettyPrinted)
                                let objec = try JSONDecoder().decode(ErrorGeneral.self, from: data)
                                observe.onNext(.failure(objec))
                                observe.onCompleted()
                            }
                        }
                    } catch let err {
                        print(err.localizedDescription)
                        observe.onError(err)
                        observe.onCompleted()
                    }
                }, onError: { (err) in
                    print(err.localizedDescription)
                    observe.onError(err)
                    observe.onCompleted()
                }, onCompleted: {
                    print("Todo completed")
                }).disposed(by: disposeBag)
            return Disposables.create()
        })
    }

}

enum ApiResult<Value, Error> {
    case success(Value)
    case failure(Error)
    
    init(value: Value) {
        self = .success(value)
    }
    init(error: Error) {
        self = .failure(error)
    }
}

struct ErrorGeneral: Codable {
    let result: Bool?
    let message: String?
    enum CodingKeys: String, CodingKey {
        case result = "result"
        case message = "message"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(Bool.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
}

