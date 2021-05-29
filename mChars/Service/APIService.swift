//
//  APIService.swift
//  mChars
//
//  Created by f4ni on 29.05.2021.
//


import Alamofire
import SwiftyJSON
import CryptoSwift

class APIService {
    static let instance = APIService()
    

    let pubKey = "fc33ca41a0cf7d0e0125b4bdc47eef42"
    let privKey = "ed556ca1a756ee7a941c7ada92314b07285b9f61"
    let ts = 1
    
     func fetch<T: Codable> ( method: HTTPMethod, url: String, parameters: [String: Any]?, model: T.Type, completion: @escaping (AFResult<Codable>) ->Void ){

        AF.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value as [String: AnyObject]):
                    do{
                        let responseJsonData = JSON(value)
                        let responseModel = try JSONDecoder().decode(model.self, from: responseJsonData.rawData())
                        completion(.success(responseModel))
                        
                    }
                    catch let parsingError {
                        print("fetch success but: \(parsingError)")
                    }

                case .failure(let error):
                    print("failure '\(url)': \(error.errorDescription ?? "")")
                completion(.failure(error))
                default:
                    fatalError("fatal error")
                }
            }
    }
    
    
    public func fetchCharacterts( offset: Int, completion: @escaping(AFResult<Codable>) ->Void ){

        let hash = "\(self.ts)\(self.privKey)\(self.pubKey)".md5()
        
        let urlString = "https://gateway.marvel.com/v1/public/characters?offset=\(offset)&ts=\(self.ts)&apikey=\(self.pubKey)&hash=\(hash)"
        
        self.fetch( method: .get, url: urlString, parameters: nil, model: MCharacterWrapper.self) { (res) in
            completion(res)
        }
            
        

    }
    public func fetchComics(id: Int, completion: @escaping(AFResult<Codable>) ->Void ){
        let hash = "\(self.ts)\(self.privKey)\(self.pubKey)".md5()
        
        let urlString = "https://gateway.marvel.com/v1/public/characters/1011334/comics?dateRange=2005-01-01,2021-01-02&limit=10&ts=\(self.ts)&apikey=\(self.pubKey)&hash=\(hash)"
      
        self.fetch( method: .get, url: urlString, parameters: nil, model: MComicsWrapper.self) { (res) in
            completion(res)
        }

    }
    
    static func toParameters<T:Encodable>(model: T?) -> [String: AnyObject]? {
        if model == nil {
            return nil
        }
        
        let jsonData = modelToJson(model: model)
        let parameters = jsonToParameters(from: jsonData!)
        return parameters! as [String: AnyObject]
    }
    
    static func modelToJson<T:Encodable>(model: T)-> Data? {
        return try? JSONEncoder().encode(model.self)
    }
    
    static func jsonToParameters(from data: Data) ->[String: Any]? {
        return try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
    }
    
}

