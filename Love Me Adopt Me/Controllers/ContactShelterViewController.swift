//
//  ContactShelterViewController.swift
//  Love Me Adopt Me
//
//  Created by Jet van den Berg on 12-01-18.
//  Copyright © 2018 Jet van den Berg. All rights reserved.
//
// Mail: https://www.youtube.com/watch?v=fiFRxD0QQnY
// Safari: https://www.youtube.com/watch?v=zMWrL2RoXVw
// Call: https://stackoverflow.com/questions/40078370/how-to-make-phone-call-in-ios-10-using-swift

import UIKit
import SafariServices
import MessageUI

class ContactShelterViewController: UIViewController, MFMailComposeViewControllerDelegate {

    var myLovesList: LovesModel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var sendEmailButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        

        // Do any additional setup after loading the view.
    }
    
    func updateUI() {
//        if shelterAnimal.animal_name != nil {
//            nameLabel.text = shelterAnimal.animal_name
//        } else {
//            nameLabel.text = "nameless :("
//        }
        
        sendEmailButton.layer.cornerRadius = 25.0
        
//        let animalImage = shelterAnimal.image
//        if let animalIMG = animalImage {
//
//            AnimalController.shared.fetchImage(url: animalIMG)
//            { (image) in
//                guard let image = image else { return }
//                DispatchQueue.main.async {
//                    self.imageView.image = image
//                }
//            }
            imageView.layer.cornerRadius = 25.0
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func makeCall(_ sender: Any) {
        let url: URL = URL(string: "tel://0123456789")!
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    
    
    @IBAction func openWebPage(_ sender: Any) {
        let svc = SFSafariViewController(url: URL(string: "https://petharbor.com/pet.asp?uaid=KING.A543490")!)
        self.present(svc, animated: true, completion: nil)
    }
    
    @IBAction func sendEmail(_ sender: Any) {
        let mailComposeViewController = configureMailController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            showMailError()
        }
    }
    
    func configureMailController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(["jet.vd.berg@gmail.com"])
        mailComposerVC.setSubject("Hellooooo 🐶 ")
        mailComposerVC.setMessageBody("How are you doing? 🐶 ", isHTML: false)
        
        return mailComposerVC
    }
    
    func showMailError() {
        let sendMailErrorAlert = UIAlertController(title: "Could not send email", message: "Your device could not send email", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Ok", style: .default, handler: nil)
        sendMailErrorAlert.addAction(dismiss)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
