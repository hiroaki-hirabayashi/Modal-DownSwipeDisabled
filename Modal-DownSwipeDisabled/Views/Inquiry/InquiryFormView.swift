//
//  InquiryFormView.swift
//  Modal-DownSwipeDisabled
//
//  Created by Hiroaki-Hirabayashi on 2022/04/06.
//

import SwiftUI

/// お問い合わせフォーム画面
struct InquiryFormView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = InquiryViewModel()
    @State var isOver = false
    @State var isShowActionSheet: Bool = false
    var body: some View {
        NavigationView {
            ZStack {
                viewContent()
            }
            .actionSheet(isPresented: $isShowActionSheet) {
                showActionSheet()
            }
            .navigationTitle("お問い合わせ")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(
                        action: {
                            // ✗ボタンを押下でアクションシート表示
                            self.isShowActionSheet = true
                        },
                        label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 16, height: 16)
                        }
                    )
                }
            }
        }
    }
    /// アクションシート表示
    private func showActionSheet() -> ActionSheet {
        ActionSheet(
            title: Text("フォームを閉じると、内容が破棄されます"),
            buttons: [
                .destructive(
                    Text("内容を破棄"),
                    action: {
                        // マイページトップに戻る
                        self.presentationMode.wrappedValue.dismiss()
                    }),
                .cancel(Text("編集を続ける"), action: {}),
            ])
    }
}

extension InquiryFormView {
    @ViewBuilder
    private func viewContent() -> some View {
        ScrollView {
            LazyVStack {
                inputInquiry()
                Spacer()
                    .frame(height: 24)
                Divider()
                    .padding(.horizontal, 16)
                Spacer()
                    .frame(height: 24)
                telephoneGuidance()
            }
            .onTapGesture {
                UIApplication.shared.sendAction(
                    #selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil
                )
            }
        }
        .padding(.bottom, 50)
        .navigationTitle("お問い合わせ")
        .navigationBarTitleDisplayMode(.inline)
    }
    @ViewBuilder
    private func inputInquiry() -> some View {
        VStack(spacing: 10) {
            VStack(alignment: .center) {
                HStack {
                    Text("お問い合わせ内容")
                        .bold()
                        .font(.system(size: 16))
                        .frame(alignment: .leading)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
            }
            .padding(.top, 32)
            
            PlaceHolderTextEditor(
                maxCharacterLength: InquiryViewModel.maxCharacterLength,
                placeholder: "お問い合わせ内容を入力してください",
                text: $viewModel.text,
                isOver: $viewModel.toTextCountValidation
            )
            NavigationLink(destination: InquiryConfirmDetailView(confirmText: $viewModel.text), isActive: $viewModel.confirm) {}
            
            Button {
                self.viewModel.confirm = true
            } label: {
                Text("内容を確認")
                    .bold()
                    .font(.system(size: 18))
                    .frame(maxWidth: .infinity, minHeight: 48)
                    .foregroundColor(viewModel.toTextCountValidation ? Color.black : Color.secondary)
            }
            .background(viewModel.toTextCountValidation ? Color.yellow : Color.white)
            .cornerRadius(200)
            .overlay(
                RoundedRectangle(cornerRadius: 200)
                    .stroke(viewModel.toTextCountValidation ? Color.yellow : Color.secondary, lineWidth: 2)
            )
            .disabled(!viewModel.toTextCountValidation)
        }
        .padding(.horizontal, 16)
    }
    @ViewBuilder
    private func telephoneGuidance() -> some View {
        VStack(spacing: 18) {
            HStack {
                Text("電話でお問い合わせ")
                    .bold()
                    .font(.system(size: 18))
                    .frame(alignment: .leading)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding(.horizontal, 8)
            Text("うまく送信できない場合や、お急ぎの場合は以下のお電話にてお問い合わせください。")
                .font(.system(size: 18))
            VStack(spacing: 10) {
                HStack {
                    Image(systemName: "phone.fill")
                        .resizable()
                        .frame(width: 19, height: 19.2)
                    Text("0120-333-310")
                        .bold()
                        .font(.system(size: 22))
                        .frame(alignment: .center)
                }
                Text("受付時間　9:00~20:00")
                    .font(.system(size: 18))
                    .frame(alignment: .center)
                Text("※年末年始を除く")
                    .font(.system(size: 18))
                    .frame(alignment: .center)
            }
            Button {
                self.viewModel.callToInquiry()
            } label: {
                Text("電話をかける")
                    .bold()
                    .font(.system(size: 18))
            }
            .frame(height: 48)
        }
        .padding(.horizontal, 16)
    }
}

struct InquiryFormView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            InquiryFormView()
        }
    }
}
