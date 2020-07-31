//
//  ErrorViewController.swift
//  weather-app
//
//  Created by Luiza Collado Garofalo on 25/07/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import Lottie
import UIKit

class ErrorViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var errorTitle: UILabel!
    @IBOutlet weak var errorDescription: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    // MARK: - Properties
    private var errorAnimation = AnimationView()
    private var error: CustomError!
    private var viewModel: ErrorViewModel!
    
    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(viewModel: ErrorViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        addAnimation()
        setup()
    }
    
    // MARK: - Private Methods
    private func addAnimation() {
        let animation = Animation.named("network-error")
        errorAnimation.animation = animation
        errorAnimation.contentMode = .scaleAspectFit
        errorAnimation.frame = animationView.bounds
        errorAnimation.loopMode = .repeat(2)
        errorAnimation.play()
        animationView.addSubview(errorAnimation)
    }
    
    private func setup() {
        errorTitle.text = viewModel.error.title
        errorDescription.text = viewModel.error.description
        actionButton.isHidden = !viewModel.error.shouldShowButton
    }
    
    // MARK: - Actions
    @IBAction func tryAgain(_ sender: UIButton) {
        viewModel.tryAgain()
    }
}
