//
//  ShareViewController.swift
//  shareFiles
//
//  Created by Prasannakumar Manikandan on 28/02/22.
//

import UIKit
import Social
import MobileCoreServices
import UniformTypeIdentifiers

class ShareViewController: SLComposeServiceViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        placeholder = "Write something here"
        let userStatus = UserDefaults.value(forKey: "userLogInStatus") as? Bool ?? false
        if userStatus {
            let loginAlertController = UIAlertController(title: "Please launch application from the home screen before continuing.", message: nil, preferredStyle: .alert)
            let onOk = UIAlertAction(title: "OK", style: .destructive)
            loginAlertController.addAction(onOk)
            present(loginAlertController, animated: true, completion: nil)
        }
    }

    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
        let content = extensionContext!.inputItems[0] as! NSExtensionItem
        let contentType = UTType.image.identifier
        let urlDataCheck = UTType.url.identifier
        for attachment in content.attachments as! [NSItemProvider] {
            if attachment.hasItemConformingToTypeIdentifier(contentType) {
                attachment.loadItem(forTypeIdentifier: contentType, options: nil) { data, error in
                    if error == nil {
                        let url = data as! NSURL
                        if let imageData = NSData(contentsOf: url as URL) {
                            self.saveDataToUserDefault(suiteName: "group.com.mallow.share", dataKey: "Image", dataValue: imageData)
                            self.extensionContext!.completeRequest(returningItems: nil, completionHandler: nil)
                            self.extensionContext!.cancelRequest(withError:NSError())
                        } else {
                            //Show Alert
                        }
                    }
                }
            } else if attachment.hasItemConformingToTypeIdentifier(urlDataCheck) {
                attachment.loadItem(forTypeIdentifier: contentType, options: nil) { data, error in
                    if error == nil {
                        let url = data as! NSURL
                        if let urlData = NSData(contentsOf: url as URL) {
                            self.saveDataToUserDefault(suiteName: "group.com.mallow.share", dataKey: "Url", dataValue: urlData)
                        } else {
                            
                        }
                    }
                }
            }
            saveDataToUserDefault(suiteName: "group.com.mallow.share", dataKey: "Name", dataValue: contentText as AnyObject)
        }
    }
    
    func showAlertForSave(imageData: NSData) {
        let alertController = UIAlertController(title: "Change Profile Pic", message: "Do you want to change the profile picture", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in }
        let AddAction = UIAlertAction(title: "Save", style: .default) { [self] (UIAlertAction) in
            self.saveDataToUserDefault(suiteName: "group.com.mallow.share", dataKey: "Image", dataValue: imageData)
            self.extensionContext!.completeRequest(returningItems: nil, completionHandler: nil)
            self.extensionContext!.cancelRequest(withError:NSError())
            
        }
        alertController.addAction(AddAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)

    }



    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return [userConfiguration]
    }
    
    lazy var userConfiguration: SLComposeSheetConfigurationItem = {
        let item = SLComposeSheetConfigurationItem()
        item?.title = "What is the Matter"
        return item!
    }()
    
    func saveDataToUserDefault(suiteName: String, dataKey: String, dataValue: AnyObject) {
        if let pref = UserDefaults(suiteName: suiteName) {
            pref.removeObject(forKey: dataKey)
            pref.set(dataValue, forKey: dataKey)
        }
    }

}
