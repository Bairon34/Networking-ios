//
//  ViewController.swift
//  Networking
//
//  Created by Bairon Yeferson Imbacuan Yandun on 5/10/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var idUser: UILabel!
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var emailUser: UILabel!
    @IBOutlet weak var progres: UIActivityIndicatorView!
    
    var networkVieModel = NetworkViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progres.hidesWhenStopped = true
        
        cleanInputs()
        observerData()
        observerLoading()
        
    }
   
    
    func cleanInputs(){
        idUser.text = ""
        nameUser.text = ""
        emailUser.text = ""
    }

    func observerLoading(){
        self.networkVieModel.loadingClosure = {
            if self.networkVieModel.loading! {
                self.progres.startAnimating()
            }else{
                self.progres.stopAnimating()
            }
        }
    }
    
    func observerData(){
        self.networkVieModel.usersClosure = {
            if let response = self.networkVieModel.usersResponse{
                print(response)
                self.cleanInputs()
                self.idUser.text = String (response.id!)
                self.nameUser.text = response.name
                self.emailUser.text = response.email
            }else{
                print(self.networkVieModel.errorUsers!)
            }
        }
    }

    @IBAction func getUsersButton(_ sender: Any) {
        
        progres.startAnimating()
        
        NetworkingProvider.shared.getUserId (
            idUser: "5354491",
            success: {(user) in
                self.progres.stopAnimating()
                
                self.idUser.text = user.id?.description
                self.nameUser.text = user.name
                self.emailUser.text = user.email
            },
            failure: {(error) in
                self.progres.stopAnimating()
                print(error!)
            }
        )
    }
    
    
    
    @IBAction func postUserButton(_ sender: Any) {
        
        progres.startAnimating()
        
        
        let newUser = NewUser(name: "Pedro",email: "pedro4@hotmail.com",gender: "male",status: "active")
        
        NetworkingProvider.shared.addUsers(
            newUser: newUser,
            success: {(user) in
                self.progres.stopAnimating()
                
                self.idUser.text = user.id?.description
                self.nameUser.text = user.name
                self.emailUser.text = user.email
            },
            failure: {(error) in
                self.progres.stopAnimating()
                print(error!)
            }
        )
    }
    
    @IBAction func putUserButton(_ sender: Any) {
        
        
    }
    
    
    
    @IBAction func getUsersVMButton(_ sender: Any) {
        self.networkVieModel.getUsers(idUser: "5354463")
    }
    
    
    
    
}

