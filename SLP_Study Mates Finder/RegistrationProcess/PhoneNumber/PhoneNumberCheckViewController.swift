//
//  PhoneNumberCheckViewController.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/10.
//

import UIKit
import Alamofire
import Firebase
import FirebaseAuth
import RxCocoa
import RxSwift
import Toast

class PhoneNumberCheckViewController: BaseViewController {
    var mainView = PhoneNumberCheckView()
    let border = CALayer()
    let viewModel = PhoneNumberCheckViewModel()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.phoneNumberTextField.delegate = self
        phoneNumberAddTargetCollection()
        receiveTextButtonColorChange()
    }
    
    func phoneNumberAddTargetCollection() {
        mainView.phoneNumberTextField.addTarget(self, action: #selector(phoneNumberTextFieldEditingDidBegin), for: .editingDidBegin)
        mainView.phoneNumberTextField.addTarget(self, action: #selector(phoneNumberTextFieldEditingDidEnd), for: .editingDidEnd)
        mainView.receiveTextButton.addTarget(self, action: #selector(receiveTextButtonClicked), for: .touchUpInside)
    }
    
    func phoneNumberValidation(number: String) -> Bool {
        let regex = "^01([0-9])-?([0-9]{3,4})-?([0-9]{4})$"
        return NSPredicate(format: "SELF MATCHES %@", regex)
            .evaluate(with: number)
    }
    
    func receiveTextButtonColorChange() {
        mainView.phoneNumberTextField.rx.text
            .map { $0!.count >= 10}
            .withUnretained(self)
            .bind { (vc, value) in
                value ? self.mainView.receiveTextButton.green() : self.mainView.receiveTextButton.gray6()
            }
    }
    
    func requestVerificationCode(phoneNumber: String) {
        Auth.auth().languageCode = "kr";
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
                if let error = error {
                    print(error)
                    return
                }
                print("verify phone")
                print(verificationID!)
                
                var verificationCode = self.mainView.phoneNumberTextField.text
                UserDefaults.standard.set(verificationCode, forKey: "verificationNumber")
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                
                let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID!, verificationCode: verificationCode!)
                
                Auth.auth().signIn(with: credential) { authResult, error in
                    if let error = error as NSError? {
                        guard let errorCode = AuthErrorCode.Code(rawValue: error.code) else { return }
                        switch errorCode {
                        case .sessionExpired, .invalidVerificationCode:
                            self.view.makeToast("전화 번호 인증 실패", duration: 1, position: .top)
                            return
                        default:
                            self.view.makeToast("에러가 발생했습니다. 잠시 후 다시 시도해주세요.", duration: 1, position: .top)
                            return
                        }
                    }
                    
                    //MARK: - ID 토큰 발급
                    authResult?.user.getIDToken { token, error in
                        if let error = error {
                            self.view.makeToast("에러: \(error.localizedDescription)", duration: 1, position: .top)
                            return
                        }
                        guard let token = token else { return }
                        //MARK: - 로그인 API 요청
                        
                        APIService.login { value, statusCode, error in
                            guard let statusCode = statusCode else { return }
                            switch statusCode {
                            case 200:
                                //MARK: - 로그인 성공 시 닉네임 값 받아오기
                                print("로그인 성공")
                                return
                            case 401: self.refreshToken()
                                return
                            case 406:
                                print("미가입 유저로 회원가입 화면으로 이동합니다.")
                                return
                            default: print("잠시 후 다시 시도해주세요.")
                                return
                            }
                        }
                    }
                }
            }
            //.disposed(by: disposeBag)
    }
    
    func refreshToken() {
        let currentUser = Auth.auth().currentUser
        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
            if let error = error {
                print("error : ", error)// Handle error
                return;
            }
            
            print("idToken : ", idToken)// Send token to your backend via HTTPS
            // ...
        }
    }
    
    func certificationCodeCheck() {
        //서버에 인증번호일치확인 통신요청(post)
        //인증번호 일치하면 사용자정보확인(get)
    }
    
    @objc func phoneNumberTextFieldEditingDidBegin() {
        border.black()
        mainView.phoneNumberTextField.layer.addSublayer((border))
    }
    
    @objc func phoneNumberTextFieldEditingDidEnd() {
        border.gray3()
        mainView.phoneNumberTextField.layer.addSublayer((border))
    }
    
    @objc func receiveTextButtonClicked() {
        let phoneNumberValidation = phoneNumberValidation(number: mainView.phoneNumberTextField.text!)
        if phoneNumberValidation == true {
            self.view.makeToast("전화 번호 인증 시작", duration: 1, position: .top)
            let phoneNumberWithNoHyphen = mainView.phoneNumberTextField.text?.replacingOccurrences(of: "-", with: "")
            requestVerificationCode(phoneNumber: "+82 \(String(describing: phoneNumberWithNoHyphen!))")
            print(phoneNumberWithNoHyphen!)
            certificationCodeCheck()
            //+@. 인증요청 후 통신요청 후 1~2초 있다가 화면전환
            let vc = CertificationNumberCheckViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.view.makeToast("잘못된 전화번호 형식입니다.", duration: 1, position: .top)
        }
    }
    
    override func viewDidLayoutSubviews() {
        border.frame = CGRect(x: 0, y: mainView.phoneNumberTextField.frame.size.height-1, width: mainView.phoneNumberTextField.frame.width, height: 1)
        border.gray3()
        mainView.phoneNumberTextField.layer.addSublayer((border))
    }
}

extension PhoneNumberCheckViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = mainView.phoneNumberTextField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        if text.count <= 11 { //Q. 왜 10이 아니라 11부터?
            mainView.phoneNumberTextField.text = phoneNumberFormatter(mask: "XXX-XXX-XXXX", phoneNumber: newString)
        } else {
            mainView.phoneNumberTextField.text = phoneNumberFormatter(mask: "XXX-XXXX-XXXX", phoneNumber: newString)
        }
        return false
    }
    
    func phoneNumberFormatter(mask: String, phoneNumber: String) -> String {
        let number = phoneNumber.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result: String = ""
        var index = number.startIndex
        
        for character in mask where index < number.endIndex {
            if character == "X" {
                result.append(number[index])
                index = number.index(after: index)
            } else {
                result.append(character)
            }
        }
        return result
    }
}
