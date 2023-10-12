import Foundation
import Alamofire
import SwiftyJSON

final class NetworkingProvider {
    static let shared = NetworkingProvider()
    
    
    private let kBaseUrl = "https://gorest.co.in/public"
    private let kStatusOK = 200...299
    private let kVersion = "/v2"
    private let kToken = "8fa8e08a57d049badb57008e3acae4e2d670e3f7ef4f8135137ab9e6ecc04952"
    

    func getUserIdVM(
        idUser :String,
        jsonSucces: @escaping (Data)->(),
        jsonError: @escaping (Data)->(),
        error : @escaping (Error)->()
    ) {
        let url = "\(kBaseUrl)\(kVersion)/users/\(idUser)"
        
        AF.request(url,method: .get)
            .validate(statusCode: kStatusOK)
            .responseDecodable(of: UserResponse.self){ (jsonResponse) in
                
                print("consume: \(url)")
                switch jsonResponse.response?.statusCode {
                    case 200:
                        jsonSucces(jsonResponse.data!)
                    break
                    default:
                        jsonError(jsonResponse.data!)
                    break
                }
                
            }
    }
    
    
    
    
    func getUserId(idUser :String,
        success: @escaping(_ user: UserResponse) ->(),
        failure: @escaping(_ error: Error?) ->()

    ) {
        let url = "\(kBaseUrl)\(kVersion)/users/\(idUser)"
        
    
        AF.request(url,method: .get)
            .validate(statusCode: kStatusOK)
            .responseDecodable(of: UserResponse.self) { response in
        
            if let user = response.value {
                success(user)
            }else{
            
                failure(response.error)
                print(response.error? .responseCode ?? "no error")
            }
        }
    }
    
    func getUserAll(){
        let url = "\(kBaseUrl)\(kVersion)/users"
        
    
        AF.request(url,method: .get)
            .validate(statusCode: kStatusOK)
            .responseDecodable(of: UserResponseAll.self) { response in
        
                if let user = response.value {
                print(user)
            }else{
                print("error")
            }
        }
    }
    
    func addUsers(
        newUser : NewUser,
        success: @escaping(_ user: UserResponse) ->(),
        failure: @escaping(_ error: Error?) ->()
    ){
        
        let url = "\(kBaseUrl)\(kVersion)/users"
        
        let headers : HTTPHeaders = [.authorization(bearerToken: kToken)]
        
        AF.request(
            url,method: .post,
            parameters: newUser,
            encoder: JSONParameterEncoder.default,
            headers: headers
        )
        .validate(statusCode: kStatusOK)
        .responseDecodable(of: UserResponse.self) { response in
                
                if let user = response.value, user.id != nil {
                    success(user)
                }else{
                    
                    failure(response.error)
                    print(response.error? .responseCode ?? "no error")
                }
            }
        
    }
    
    
    
    
    func updateUsers(
        idUser: Int,
        newUser : NewUser,
        success: @escaping(_ user: UserResponse) ->(),
        failure: @escaping(_ error: Error?) ->()
    ){
        
        let url = "\(kBaseUrl)\(kVersion)/users/\(idUser)"
        
        let headers : HTTPHeaders = [.authorization(bearerToken: kToken)]
        
        AF.request(
            url,method: .put,
            parameters: newUser,
            encoder: JSONParameterEncoder.default,
            headers: headers
        )
        .validate(statusCode: kStatusOK)
        .responseDecodable(of: UserResponse.self) { response in
                
                if let user = response.value, user.id != nil {
                    success(user)
                }else{
                    
                    failure(response.error)
                    print(response.error? .responseCode ?? "no error")
                }
            }
        
    }
    
    
    
}
