import Foundation
import Flutter
import SwiftUI

@available(iOS 13.0, *)
struct SwiftUIView: View {
    @State private var textInput: String = ""
    
    var message: String?
    var onSubmit: (String) -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("SwiftUI View")
                .font(.title)
                .padding()

            Text("Message from Flutter: \(message ?? "No message")")
                .padding()

            TextField("Enter text", text: $textInput)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: {
                onSubmit(textInput)
                // モーダルを閉じる
                if let topController = UIApplication.shared.keyWindow?.rootViewController {
                    topController.dismiss(animated: true, completion: nil)
                }
            }) {
                Text("Submit")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

@available(iOS 13.0, *)
class MessagesImpl: NSObject, IsSwift {
    
    func hostApi(completion: @escaping (Result<Message, Error>) -> Void) {
        // Flutterからメッセージを取得
        if let flutterViewController = UIApplication.shared.windows.first?.rootViewController as? FlutterViewController {
            let flutterApi = IsFlutter(binaryMessenger: flutterViewController.binaryMessenger)
            
            flutterApi.flutterApi { result in
                switch result {
                case .success(let flutterMessage):
                    
                    // submitが押されたタイミングで入力されたデータをFlutterに送信するためのコールバックを設定
                    let hostingController = UIHostingController(rootView: SwiftUIView(message: flutterMessage.message) { text in
                        // 入力されたデータをFlutterに送信
                        let message = Message(message: text)
                        completion(.success(message))
                    })
                    
                    // トップビューコントローラーを取得
                    if let topController = UIApplication.shared.keyWindow?.rootViewController {
                        // SwiftUIのビューをモーダルで表示
                        topController.present(hostingController, animated: true, completion: nil)
                    } else {
                        // トップビューコントローラーが見つからない場合のエラーハンドリング
                        let error = NSError(domain: "topController", code: 1, userInfo: [NSLocalizedDescriptionKey: "トップビューコントローラーが見つかりません"])
                        completion(.failure(error))
                    }
                case .failure(let error):
                    // Flutter API呼び出しが失敗した場合のエラーハンドリング
                    completion(.failure(error))
                }
            }
        }
    }
}
