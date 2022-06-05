//
//  ViewController.swift
//  
//  
//  Created by ji-no on R 4/05/27
//  
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var toView: UIView!
    
    var tutorialView: TutorialView = TutorialView(frame: .zero)
    let headerHeight: CGFloat = 120
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @IBAction func onTappedStart(_ sender: Any) {
        tutorialView.start(to: toView.frame)
    }

    @IBAction func onTappedClear(_ sender: Any) {
        tutorialView.clear()
    }

}

extension ViewController {

    private func setUp() {
        tutorialView.headerHeight = headerHeight
        view.addSubview(tutorialView)
        tutorialView.translatesAutoresizingMaskIntoConstraints = false
        tutorialView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tutorialView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tutorialView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tutorialView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }

}
