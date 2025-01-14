//
//  PrivacyView.swift
//  swift-paperless
//
//  Created by Paul Gessinger on 03.09.23.
//

import MarkdownUI
import SwiftUI

struct PrivacyView: View {
    private static var url = URL(string: "https://raw.githubusercontent.com/paulgessinger/swift-paperless/main/privacy.md")!

    @State var text: String? = nil
    var body: some View {
        ScrollView(.vertical) {
            if let text {
                Markdown(text)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            } else {
                ProgressView("Loading")
            }
        }
        .navigationTitle(LocalizedStrings.Settings.Details.privacy)
        .task {
            Task.detached {
                do {
                    let result = try String(contentsOf: PrivacyView.url)
                    await MainActor.run {
                        text = result
                    }
                } catch {
                    await MainActor.run {
                        text = LocalizedStrings.Settings.Details.privacyLoadError(PrivacyView.url.absoluteString)
                    }
                }
            }
        }
    }
}

struct PrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyView()
    }
}
