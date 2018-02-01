//
//  ContactShelterViewController.swift
//  Love Me Adopt Me
//
//  Created by Jet van den Berg on 12-01-18.
//  Copyright © 2018 Jet van den Berg. All rights reserved.
//
//  This class displays details of a selected shelter animal, including buttons to call and mail the shelter, or view its webpage in Safari. For this class is some code used from tutorials on YouTube and Stackoverflow:
//  Mail: https://www.youtube.com/watch?v=fiFRxD0QQnY
//  Safari: https://www.youtube.com/watch?v=zMWrL2RoXVw
//  Call: https://stackoverflow.com/questions/40078370/how-to-make-phone-call-in-ios-10-using-swift
//

import UIKit
import SafariServices
import MessageUI

class ContactShelterViewController: UIViewController, MFMailComposeViewControllerDelegate {

    // Property
    var LovesList: LovesModel!
    
    // Outlets
    @IBOutlet weak var makeCall: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var makeCallButton: UIButton!
    @IBOutlet weak var sendEmailButton: UIButton!
    @IBOutlet weak var openWebPageButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // Loads view, performs functions
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // Updates labels with given corresponding data from LovesList
    func updateUI() {
        activityIndicator.startAnimating()
        nameLabel.text = (LovesList.animal_name != nil) ? LovesList.animal_name : "nameless :("
        typeLabel.text = (LovesList.animal_type != nil) ? LovesList.animal_type : "Unknown"
        breedLabel.text = (LovesList.animal_breed != nil) ? LovesList.animal_breed : "Unknown"
        ageLabel.text = (LovesList.animal_age != nil) ? LovesList.animal_age : "Unknown"
        genderLabel.text = (LovesList.animal_gender != nil) ? LovesList.animal_gender : "Unknown"
        colorLabel.text = (LovesList.animal_color != nil) ? LovesList.animal_color : "Unknown"
        cityLabel.text = (LovesList.city != nil) ? LovesList.city : "Unknown"
        
        makeCallButton.layer.cornerRadius = 35.0
        sendEmailButton.layer.cornerRadius = 35.0
        openWebPageButton.layer.cornerRadius = 35.0
        
        // Checks if image exists, fill imageView with image
        let animalImage = URL(string: LovesList.image!)
        if let animalIMG = animalImage {
            AnimalController.shared.fetchImage(url: animalIMG)
            { (image) in
                guard let image = image else { return }
                DispatchQueue.main.async {
                    self.imageView.image = image
                    self.activityIndicator.stopAnimating()
                }
            }
            imageView.layer.cornerRadius = 25.0
        }
    }
    
    // Button for making call to shelter
    @IBAction func makeCall(_ sender: Any) {
        let url: URL = URL(string: "tel://+12062967387")!
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    
    // Button for opening webpage of corresponding shelter animal
    @IBAction func openWebPage(_ sender: Any) {
        let svc = SFSafariViewController(url: URL(string: LovesList.link!)!)
        self.present(svc, animated: true, completion: nil)
    }
    
    // Button for sending email to shelter
    @IBAction func sendEmail(_ sender: Any) {
        let mailComposeViewController = configureMailController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            showMailError()
        }
    }
    
    // Configures email, setting correct contact information
    func configureMailController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(["lovemeadoptme.animalshelter@gmail.com"])
        mailComposerVC.setSubject("Adopting a new friend! 🐶 ")
        mailComposerVC.setMessageBody("Hi! \nHow are you doing? \nI was using the app 'Love Me Adopt Me', and fell in love with [...] I would really like to adopt him/her! \n🐶 \n\nHope to hear from you soon!", isHTML: false)
        return mailComposerVC
    }
    
    // Alerts user with error when email could not be send
    func showMailError() {
        let sendMailErrorAlert = UIAlertController(title: "Could not send email", message: "Your device could not send email", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Ok", style: .default, handler: nil)
        sendMailErrorAlert.addAction(dismiss)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    // Dismisses emailComposer when done
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }

}
