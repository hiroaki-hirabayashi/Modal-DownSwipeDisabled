//
//  ModalHostingController.swift
//  Modal-DownSwipeDisabled
//
//  Created by Hiroaki-Hirabayashi on 2022/04/06.
//

import SwiftUI

/// モーダルを制御する
class ModalHostingController<Content: View>: UIHostingController<Content>, UIAdaptivePresentationControllerDelegate {
    var canDismissSheet = true
    var onDismissalAttempt: (() -> ())?
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        
        parent?.presentationController?.delegate = self
    }
    
    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        canDismissSheet
    }
    
    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        onDismissalAttempt?()
    }
}

struct ModalView<T: View>: UIViewControllerRepresentable {
    let view: T
    let canDismissSheet: Bool
    let onDismissalAttempt: (() -> ())?
    
    func makeUIViewController(context: Context) -> ModalHostingController<T> {
        let controller = ModalHostingController(rootView: view)
        
        controller.canDismissSheet = canDismissSheet
        controller.onDismissalAttempt = onDismissalAttempt
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: ModalHostingController<T>, context: Context) {
        uiViewController.rootView = view
        
        uiViewController.canDismissSheet = canDismissSheet
        uiViewController.onDismissalAttempt = onDismissalAttempt
    }
}

extension View {
    /// モーダルの下スワイプを無効
    func interactiveDismiss(canDismissSheet: Bool, onDismissalAttempt: (() -> ())? = nil) -> some View {
        ModalView(
            view: self,
            canDismissSheet: canDismissSheet,
            onDismissalAttempt: onDismissalAttempt
        )
            .edgesIgnoringSafeArea(.all)
    }
}
