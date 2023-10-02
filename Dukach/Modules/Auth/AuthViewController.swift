

import UIKit
import Firebase


class AuthViewController: UIViewController {
    

    @IBOutlet weak var authStackView: UIStackView!
    @IBOutlet weak var authTitleLabel: UILabel!
    
    @IBOutlet weak var authNameLabel: UILabel!
    @IBOutlet weak var authMailLabel: UILabel!
    @IBOutlet weak var authPassLabel: UILabel!
    @IBOutlet weak var authTermsConditionLabel: UILabel!
    
    
    @IBOutlet weak var authNameTextField: UITextField!
    @IBOutlet weak var authEmailTextField: UITextField!
    @IBOutlet weak var authPassTextField: UITextField!
    
    @IBOutlet weak var authButton: UIButton!

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.clipsToBounds = true
        scrollView.layer.borderColor = UIColor.red.cgColor
        return scrollView
    }()

    
    weak var delegate: AuthDelegate?
//    var authSwitcher : Const.authSwitcher = .registration
    var authSwitcher : Const.authSwitcher = .login
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInterface()
        

    }
    
    @IBAction func authButton(_ sender: Any) {
        print("click")

        guard let email = authEmailTextField.text, let password = authPassTextField.text, !email.isEmpty, !password.isEmpty else {
            present(alertUserAuthError(authError:Const.userAuthErrorMessage.emptyField.rawValue), animated: true)
            return
        }
        authEnterButtonPresed(authType: authSwitcher)
        
        authenticateUser()

        
        
        func authEnterButtonPresed(authType:Const.authSwitcher){ //перейменувати і зробити у VM
            if authType == .registration{
                registerUser(name: authNameTextField.text ?? Const.unownName, email: email, password: password)

            }else{
                signInUser(email: email, password: password)
            }
        }
        
        
    }
//    @IBAction func authButton(_ sender: UIButton) {
//           guard let email = authEmailTextField.text, let password = authPassTextField.text, !email.isEmpty, !password.isEmpty else {
//               present(alertUserAuthError(authError: Const.userAuthErrorMessage.emptyField.rawValue), animated: true)
//               return
//           }
//        print("click2")
//           authEnterButtonPresed(authType: authSwitcher)
           
           

//           func authEnterButtonPresed(authType:Const.authSwitcher){ //перейменувати і зробити у VM
//               if authType == .registration{
//                   registerUser(name: nameField.text ?? Const.unownName, email: email, password: password)
//               }else{
//                   signInUser(email: email, password: password)
//               }
//           }
//       }


// MARK: - Navigation
    
    private func authenticateUser() {
         // Логіка авторизації
         // При успішній авторизації викликаємо метод делегата
        print ("main VC")
        self.delegate?.userDidAuthenticate()
//         delegate?.userDidAuthenticate()
     }

     private func signOutUser() {
         // Логіка виходу з облікового запису
         // При виході з облікового запису викликаємо метод делегата
         delegate?.userDidSignOut()
     }

}


protocol AuthDelegate: AnyObject {
    func userDidAuthenticate()
    func userDidSignOut()
    
}

// MARK: - setupInterface AuthViewController
extension AuthViewController{

    func setupInterface() {
        setupScrollView()
        setupAuthStackView()
        setupLabels()
        setupTextFields()
        setupAuthButton()
        addSubviews()
        setupConstraints()
    }

    private func setupScrollView() {
        scrollView.backgroundColor = UIColor(red: 5/255, green: 5/255, blue: 245/255, alpha: 1)
    }

    private func setupAuthStackView() {
        authStackView.backgroundColor  = UIColor(red: 245/255, green: 5/255, blue: 245/255, alpha: 1)
        authStackView.axis = .vertical
        authStackView.spacing = 10
        authStackView.alignment = .fill
        authStackView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupLabels() {
        authNameLabel.text = "Ім'я користувача:"
        authMailLabel.text = "Email:"
        authPassLabel.text = "Пароль:"
    }

    private func setupTextFields() {
        setupTextField(authNameTextField, placeholder: "Your Name")
        setupTextField(authEmailTextField, placeholder: "Your Email")
        setupTextField(authPassTextField, placeholder: "********", isSecureTextEntry: true)
        
    }

    private func setupTextField(_ textField: UITextField, placeholder: String, isSecureTextEntry: Bool = false) {
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .continue
        textField.layer.cornerRadius = 4
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.red.cgColor
        textField.placeholder = placeholder
        textField.isSecureTextEntry = isSecureTextEntry
    }
    
    private func setupAuthButton() {
//        authButton = UIButton(type: .system)
        authButton.setTitle("Зареєструватися", for: .normal)
        authButton.addTarget(self, action: #selector(getter: authButton), for: .touchUpInside)
        authButton.layer.cornerRadius = 20
        
    }

    private func addSubviews() {
        authStackView.addArrangedSubview(authNameLabel)
        authStackView.addArrangedSubview(authNameTextField)
        authStackView.addArrangedSubview(authMailLabel)
        authStackView.addArrangedSubview(authEmailTextField)
        authStackView.addArrangedSubview(authPassLabel)
        authStackView.addArrangedSubview(authPassTextField)
        authStackView.addArrangedSubview(authButton)
        
        scrollView.addSubview(authStackView)
        view.addSubview(scrollView)
    }

    private func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        authStackView.translatesAutoresizingMaskIntoConstraints = false
        authNameTextField.translatesAutoresizingMaskIntoConstraints = false
        authEmailTextField.translatesAutoresizingMaskIntoConstraints = false
        authPassTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 180),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            authStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            authStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            authStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            authStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            authStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            authNameTextField.widthAnchor.constraint(equalTo: authStackView.widthAnchor, multiplier: 1.0),
            authEmailTextField.widthAnchor.constraint(equalTo: authStackView.widthAnchor, multiplier: 1.0),
            authPassTextField.widthAnchor.constraint(equalTo: authStackView.widthAnchor, multiplier: 1.0),
            
            authNameLabel.leadingAnchor.constraint(equalTo: authStackView.leadingAnchor),
            authNameLabel.trailingAnchor.constraint(equalTo: authStackView.trailingAnchor),
            authMailLabel.leadingAnchor.constraint(equalTo: authStackView.leadingAnchor),
            authMailLabel.trailingAnchor.constraint(equalTo: authStackView.trailingAnchor),
//
//            authButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            authButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            authButton.widthAnchor.constraint(equalToConstant: 100),
            authButton.heightAnchor.constraint(equalToConstant: 40)

        ])
    }
}


extension AuthViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == authEmailTextField {
            authPassTextField.becomeFirstResponder()
        }else if
            textField == authPassTextField{
//            authButton
        }
        return true
    }
    
    func alertUserAuthError(authError:String) -> UIAlertController {
        print("error")
        let alert = UIAlertController(title: "Message", message: authError, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        return alert
    }
    
    
    
}
