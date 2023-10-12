import Foundation
import Alamofire
import SwiftyJSON

class NetworkViewModel {
    
    private var api : NetworkingProvider
    
    var error: Error? {
        didSet {
            guard error == nil else { return }
            self.errorinFetchData?() }
    }
    
    var usersResponse : UserResponse?{
        didSet{
            self.usersClosure?()
        }
    }
    var errorUsers : UserResponse?{
        didSet{
            self.errorUsersClosure?()
        }
    }
    
    var loading : Bool?{
        didSet{
            self.loadingClosure?()
        }
    }
    
    //constructors
    init (){
        self.api = NetworkingProvider()
    }
    

    
    //Clousers
    var errorinFetchData: (() -> ())?
    var usersClosure : (() -> ())?
    var errorUsersClosure : (() -> ())?
    var loadingClosure : (() -> ())?
    
 
 
    func getUsers(idUser:String){
        self.loading = true
        self.api.getUserIdVM(
            idUser:idUser,
            jsonSucces: { (success) in
                do{
                    let jsoncodabledata = try JSONDecoder().decode(UserResponse.self, from: success)
                    self.usersResponse = jsoncodabledata
                    self.loading = false
                }catch let error{
                    print("catch_error" , error)
                }
            },
            jsonError: { (jsonerror) in
                do{
            
                    let jsoncodabledata = try JSONDecoder().decode(UserResponse.self, from: jsonerror)
                    self.errorUsers = jsoncodabledata
                    self.loading = false
                }catch let error{
                    print("catch_error" , error)
                }
            },
            error: { (error) in
                self.error = error
                self.loading = false
                return
            })
    }
    
    
}
