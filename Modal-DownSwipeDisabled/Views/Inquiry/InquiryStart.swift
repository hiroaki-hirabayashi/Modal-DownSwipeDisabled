//
//  InquiryStart.swift
//  Modal-DownSwipeDisabled
//
//  Created by Hiroaki-Hirabayashi on 2022/04/06.
//

import SwiftUI

struct InquiryStartView: View {
    @State var isShowModal = false
    var body: some View {
        Button {
            self.isShowModal = true
        } label: {
            Text("お問い合わせ入力フォームへ")
                .font(.system(size: 18))
                .foregroundColor(Color.black)
        }
        .sheet(isPresented: $isShowModal) {
            InquiryFormView()
                // モーダルの下スワイプを無効
                .interactiveDismiss(canDismissSheet: false)
        }
        
    }
}

struct InquiryStartView_Previews: PreviewProvider {
    static var previews: some View {
        InquiryStartView()
    }
}
