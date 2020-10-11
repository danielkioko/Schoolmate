//
//  ViewController.swift
//  Schoolmate
//
//  Created by Daniel Nzioka on 9/20/20.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class LoginVC: UIViewController, GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
          if let error = error {
            debugPrint(error.localizedDescription)
          }
          guard let authentication = user?.authentication else { return }
          let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                            accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (result, error) in
            if let err = error {
                debugPrint(err.localizedDescription)
            }
            Auth.auth().addStateDidChangeListener { (auth, user) in
                userID = user?.uid
                userName = user?.displayName
                let vc = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "NameVC") as! NameVC
                vc.modalPresentationStyle = .fullScreen
                vc.modalTransitionStyle = .crossDissolve
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    @IBOutlet var layerView: UIView!
    @IBOutlet var signInBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (Auth.auth().currentUser != nil) {
            let vc = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "NameVC") as! NameVC
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
        }
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }
    
    @IBAction func signIn(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
}

class NameVC: UIViewController {
    
    @IBOutlet var layerView: UIView!
    @IBOutlet var nameFieldView: UIView!
    @IBOutlet var nameField: UITextField!
    @IBOutlet var nextBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        nameField.text = userName
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "PreparationTimeVC") as! PreparationTimeVC
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
    
}

class PreparationTimeVC: UIViewController {
    
    @IBOutlet var layerView: UIView!
    @IBOutlet var preparationTimeFieldView: UIView!
    @IBOutlet var preparationTimeField: UITextField!
    @IBOutlet var nextBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "EndDayVC") as! EndDayVC
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
    
}

class EndDayVC: UIViewController {
    
    @IBOutlet var layerView: UIView!
    @IBOutlet var preparationTimeFieldView: UIView!
    @IBOutlet var preparationTimeField: UITextField!
    @IBOutlet var nextBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        let vc  = MainPage()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        present(vc, animated: true, completion: nil)
    }
    
}

