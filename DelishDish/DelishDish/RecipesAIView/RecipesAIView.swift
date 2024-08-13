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
                ScrollViewReader { proxy in
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
                                    .id(chat.id)
                            }
                            if viewModel.isLoading {
                                MessageView.progressView
                            }
                        }
                        .onChange(of: viewModel.chats.count) { oldValue, newValue in
                            if oldValue != newValue, let lastChatId = viewModel.chats.last?.id {
                                withAnimation {
                                    proxy.scrollTo(lastChatId, anchor: .bottom)
                                }
                            }
                        }
                    }
                }
                
                Divider()
                    .padding(.bottom, 1)
                
                MessageBar(message: $viewModel.message, sendMessageAction: {
                    viewModel.sendMessage()
                })
            }
            .padding()
            .navigationTitle("RecipesAI Generator")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        viewModel.chats.removeAll()
                    } label: {
                        Image(systemName: "trash.fill")
                            .font(.caption)
                        Text("Clear All")
                            .font(.footnote)
                    }
                }
            }
        }
    }
}

#Preview {
    RecipesAIView()
        .environmentObject(RecipesAIViewModel())
}












