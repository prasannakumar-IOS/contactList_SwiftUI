//
//  ActivityController.swift
//  ContactList
//
//  Created by Prasannakumar Manikandan on 24/02/22.
//

import UIKit
import SwiftUI

struct ActivityController: UIViewControllerRepresentable {

    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityController>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        controller.excludedActivityTypes = [UIActivity.ActivityType.copyToPasteboard]
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityController>) {}

}
