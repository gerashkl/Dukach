import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var authStateListener: AuthStateDidChangeListenerHandle?



    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            print ("try ")
            if user == nil{
                self.showModalAuth()
            }else{
               print ("OnLine")

            }
        }
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        Auth.auth().removeStateDidChangeListener(authStateListener!)

        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    func showModalAuth(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let authViewController = storyboard.instantiateViewController(withIdentifier: String(describing: AuthViewController.self)) as? AuthViewController {
            authViewController.modalPresentationStyle = .fullScreen

            self.window?.rootViewController?.present(authViewController, animated: true)
//            navigationController?.pushViewController(authViewController, animated: true)

        }
            }
    
    
    func showAuth(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let authViewController = storyboard.instantiateViewController(withIdentifier: String(describing: AuthViewController.self)) as? AuthViewController {
            
//            self.window?.rootViewController?.present(authViewController, animated: true)
            window?.rootViewController = authViewController
//            window?.makeKeyAndVisible()
        }

        
    }

}

extension SceneDelegate: AuthDelegate {
    func userDidAuthenticate() {
        //        let mainViewController = ViewController()
        //        window?.rootViewController = mainViewController
        //        window?.makeKeyAndVisible()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let mainViewController = storyboard.instantiateViewController(withIdentifier: String(describing: ViewController.self)) as? ViewController {
            
            //            self.window?.rootViewController?.present(authViewController, animated: true)
            window?.rootViewController = mainViewController
            
        }
        
        
        
    }

    func userDidSignOut() {
        let authViewController = AuthViewController()
        authViewController.delegate = self
        window?.rootViewController = authViewController
    }
}
