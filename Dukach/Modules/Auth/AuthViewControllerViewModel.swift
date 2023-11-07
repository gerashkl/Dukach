import Foundation
import Firebase
import UIKit


class AuthViewControllerViewModel {
    
    var onRegistrationSuccess: (() -> Void)?
    var onError: ((Error) -> Void)?
    var onSignInSuccess: (() -> Void)?
    

    func registerUser(name:String, email:String, password:String) {
        Auth.auth().createUser(withEmail: email, password: password) { [self] authDataResult, error in
            guard let result = authDataResult, error == nil else{
                if let authError = error {
                    self.onError?(authError)
                }
                     return
                 }
            onRegistrationSuccess?()
            self.sendUserDataToServer(result: result)
            }
        }
    
    func signInUser(email:String, password:String){
        Auth.auth().signIn(withEmail: email, password: password) { [self] authDataResult, error in
            guard let result = authDataResult, error == nil else{
//                let authError = error?.localizedDescription ?? "something wrong"
//                self.present(self.viewModel.alertUserAuthError(authError: authError ), animated: true)
                if let signInError = error {
                    self.onError?(signInError)
                }
                return
            }
            let user = result.user
            onSignInSuccess?()
        }
    }
    

    private func sendUserDataToServer (result: AuthDataResult) {
        let ref = Database.database().reference().child("users")
        ref.child(result.user.uid).updateChildValues(["name" : result.user.displayName ,"email" : result.user.email, ])
        
    }
    
    func alertUserAuthError(authError:String) -> UIAlertController {
        print("error")
        let alert = UIAlertController(title: "Message", message: authError, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        return alert
    }
}
