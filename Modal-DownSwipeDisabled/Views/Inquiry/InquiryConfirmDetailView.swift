//
//  InquiryConfirmDetailView.swift
//  Modal-DownSwipeDisabled
//
//  Created by Hiroaki-Hirabayashi on 2022/04/06.
//

import SwiftUI

/// お問い合わせ確認画面
struct InquiryConfirmDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = InquiryViewModel()
    @Binding var confirmText: String
    @State private var isSend = false
    var body: some View {
        ZStack {
            viewContent()
        }
    }
}

extension InquiryConfirmDetailView {
    @ViewBuilder
    private func viewContent() -> some View {
        ScrollView {
            VStack(spacing: 10) {
                VStack(alignment: .leading, spacing: 24) {
                    Text("以下のお問い合わせ内容でよろしければ「送信」ボタンを押してください。")
                        .font(.system(size: 18))
                        .frame(alignment: .leading)
                    Text("お問い合わせ内容")
                        .bold()
                        .font(.system(size: 16))
                        .frame(alignment: .leading)
                }
                .multilineTextAlignment(.leading)
                .padding(.top, 28)
                Text(confirmText)
                    .frame(
                        maxWidth: .infinity,
                        minHeight: 186,
                        maxHeight: .infinity,
                        alignment: .topLeading
                    )
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.top, 10)
                    .padding(.leading, 5)
                    .background(Color.secondary)
                    .cornerRadius(8)
                
                //                NavigationLink(destination: InquiryCompletedView(), isActive: $isSend) {}
                Spacer()
                Divider()
            }
            .padding(.horizontal, 16)
            .navigationTitle("お問い合わせ")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(
                        action: {
                            self.presentationMode.wrappedValue.dismiss()
                        },
                        label: {
                            Image(systemName: "xmark")
                                .resizable()
                            .frame(width: 16, height: 16)                        }
                    )
                }
                ToolbarItemGroup(placement: .bottomBar) {
                    // bottomBarButton
                    bottomBarItemGroup()
                }
            }
            .background(Color.white)
        }
    }
    
    @ViewBuilder
    private func bottomBarItemGroup() -> some View {
        // DividerとbottomBarItemGroupの線を重ねるため、-8を指定
        // StateButtonが表示されなかったので、とりあえず通常のUIコンポーネントを使用
        VStack(spacing: -8) {
            Divider()
            Spacer()
                .frame(height: 15)
            HStack(spacing: 17) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("戻る")
                        .font(.system(size: 18).bold())
                        .foregroundColor(Color.black)
                        .frame(minWidth: 163, maxWidth: .infinity, minHeight: 48)
                        .background(Color.white)
                        .cornerRadius(200)
                        .overlay(
                            RoundedRectangle(cornerRadius: 200)
                                .stroke(Color.yellow, lineWidth: 2)
                        )
                }
                Button(action: {
                    // お問い合わせ送信
//                    viewModel.sendInquiry { error in
//                        if error == nil {
//                            self.isSend = true
//                        } else {
//                            // エラー処理
//                        }
//                    }
                    // TODO: - 送信したら入力内容をクリアする 送信完了画面から戻ってこれない仕様だったら不要かも
                    self.confirmText = ""
                }) {
                    Text("送信")
                        .font(.system(size: 18).bold())
                        .foregroundColor(Color.black)
                        .frame(minWidth: 163, maxWidth: .infinity, minHeight: 48)
                        .background(Color.yellow)
                        .cornerRadius(200)
                }
            }
        }
    }
    
}

struct ConfirmInquiryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        InquiryConfirmDetailView(confirmText: .constant(""))
    }
}


//ToolbarItemGroup(placement: .bottomBar) {
//    HStack(spacing: 17) {
//        Button(action: {
//            self.presentationMode.wrappedValue.dismiss()
//        }) {
//            Text("戻る")
//                .bold()
//                .font(.system(size: 18))
//                .foregroundColor(Color.black)
//                .frame(minWidth: 163, maxWidth: .infinity, minHeight: 48)
//                .background(Color.white)
//                .cornerRadius(200)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 200)
//                        .stroke(Color.yellow, lineWidth: 2)
//                )
//        }
//        Button(action: {
//            // お問い合わせ送信
//            self.viewModel.sendInquiry()
//            self.isSend = true
//            // TODO: - 送信したら入力内容をクリアする 送信完了画面から戻ってこれない遷移だったら不要かも
//            self.confirmText = ""
//        }) {
//            Text("送信")
//                .bold()
//                .font(.system(size: 18))
//                .foregroundColor(Color.black)
//                .frame(minWidth: 163, maxWidth: .infinity, minHeight: 48)
//                .background(Color.yellow)
//                .cornerRadius(200)
//        }
//    }
//    .padding(.horizontal, 16)
//}
