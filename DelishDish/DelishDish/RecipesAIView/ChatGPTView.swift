//
//  RecipesAIView.swift
//  DelishDish
//
//  Created by Volkan Yücel on 07.08.24.
//

import SwiftUI

struct RecipesAIView: View {
    
    @StateObject var viewModel = RecipesAIViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.chats, id: \.id) { chat in
                            MessageView(chat: chat)
                                .contextMenu {
                                    Button(action: {
                                        UIPasteboard.general.string = chat.content
                                    }) {
                                        Text("Copy")
                                        Image(systemName: "doc.on.doc")
                                    }
                                }
                        }
                        if viewModel.isLoading {
                            MessageView.progressView
                        }
                    }
                }
                Divider()
                    .padding(.bottom, 10)
                HStack {
                    TextField("Enter a message", text: $viewModel.message)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .autocorrectionDisabled(true)
                        .cornerRadius(25)
                    Button {
                        viewModel.sendMessage()
                    } label: {
                        Image(systemName: "arrow.right.circle.fill")
                            .foregroundColor(.blue)
                            .padding(.horizontal, 5)
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                    }
                }
            }
            .padding()
            .navigationTitle("SwiftUI ChatGPT")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        viewModel.chats.removeAll()
                    } label: {
                        Image(systemName: "trash.fill")
                            .font(.caption)
                        Text("Clear All")
                    }
                }
            }
        }
    }
}

#Preview {
    RecipesAIView()
}
