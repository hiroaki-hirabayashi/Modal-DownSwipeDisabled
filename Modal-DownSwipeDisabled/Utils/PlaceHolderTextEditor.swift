//
//  PlaceHolderTextEditor.swift
//  Modal-DownSwipeDisabled
//
//  Created by Hiroaki-Hirabayashi on 2022/04/06.
//

import SwiftUI

struct PlaceHolderTextEditor: View {
    var maxCharacterLength: Int
    var placeholder: String
    @Binding var text: String
    @Binding var isOver: Bool
    @State var isChangeCountMessageColor = true
    // 初回表示用
    @State var countMessage: String = String.localizedStringWithFormat("残り%d文字", InquiryViewModel.maxCharacterLength)
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .topLeading) {
                if text.isEmpty {
                    Text(placeholder)
                        .font(.system(size: 18))
                        .foregroundColor(Color.secondary)
                        .padding(.top, 8)
                        .padding(.leading, 8)
                }
                TextEditor(text: $text)
                    .autocapitalization(.none)
                    .frame(maxWidth: .infinity, minHeight: 186, maxHeight: 372)
                    .onChange(
                        of: text,
                        perform: { newValue in
                            checkTextCount(inputText: newValue)
                        })
            }
            .background(Color.white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isChangeCountMessageColor ? Color.secondary : Color.red, lineWidth: 1)
            )
            .onAppear {
                UITextView.appearance().backgroundColor = .clear
            }
            .onDisappear {
                UITextView.appearance().backgroundColor = nil
            }
            HStack(spacing: 0) {
                Spacer()
                Text(countMessage)
                    .font(.system(size: 14))
                    .foregroundColor(isChangeCountMessageColor ? Color.black : Color.red)
            }
        }
    }
    
    /// 問い合わせ内容文字数チェック
    /// - Returns: 制限超えたか？: true, false,  残り文字数Message
    func checkTextCount(inputText: String) {
        isOver = false
        
        // 入力文字が0 → ボタン非活性 / 残り文字色 黒
        if text.isEmpty {
            isOver = false
            countMessage = String.localizedStringWithFormat("%d文字", maxCharacterLength - text.count)
            // 入力文字が3,000文字以上 → ボタン非活性 / 残り文字色 赤
        } else if maxCharacterLength < text.count {
            isOver = false
            isChangeCountMessageColor = false
            // 3桁毎にカンマ区切り
            countMessage = String.localizedStringWithFormat("%d文字", maxCharacterLength - text.count)
            // 入力文字が3,000文字以内 → ボタン活性 / 残り文字色 黒
        } else {
            isOver = true
            isChangeCountMessageColor = true
            // 3桁毎にカンマ区切り
            countMessage = String.localizedStringWithFormat("残り%d文字", maxCharacterLength - text.count)
        }
    }
}

struct PlaceHolderTextEditor_Previews: PreviewProvider {
    static var previews: some View {
        PlaceHolderTextEditor(
            maxCharacterLength: 100, placeholder: "お問い合わせ内容を入力してください", text: .constant(""),
            isOver: .constant(false)
        )
            .previewLayout(.fixed(width: 380, height: 300))
    }
}


