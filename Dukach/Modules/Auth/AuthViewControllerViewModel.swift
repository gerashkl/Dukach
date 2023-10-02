import Foundation
import Firebase


extension AuthViewController {
   
    func registerUser(name:String, email:String, password:String) {
        Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in
            guard let result = authDataResult, error == nil else{
                let authError = error?.localizedDescription ?? "something wrong"
                self.present(self.alertUserAuthError(authError: authError ), animated: true)
                return
                    }
                    let ref = Database.database().reference().child("users")
                    ref.child(result.user.uid).updateChildValues(["name" : name,"email" : email, ])
                    self.dismiss(animated: true)

            }
        
        }
    func signInUser(email:String, password:String){
        Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
            guard let result = authDataResult, error == nil else{
                let authError = error?.localizedDescription ?? "something wrong"
                self.present(self.alertUserAuthError(authError: authError ), animated: true)
                return
            }
            let user = result.user
            self.dismiss(animated: true)
        }
    }
}


class AuthViewControllerViewModel{
    
}
