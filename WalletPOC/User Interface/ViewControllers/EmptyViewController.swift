//
//  EmptyViewController.swift
//  WalletPOC
//
//  Created by Noemi Kalman on 09.09.2022.
//

import Foundation
import UIKit

class EmptyViewController: BaseViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let vc = FaceIDViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.didAuthorize = {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                self.navigationController?.pushViewController(PaymentViewController(viewModel: PaymentViewModelImpl()), animated: true)
            }
        }
        present(vc, animated: true)
    }
}
