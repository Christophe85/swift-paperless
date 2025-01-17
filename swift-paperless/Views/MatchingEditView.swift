//
//  MatchingEditView.swift
//  swift-paperless
//
//  Created by Paul Gessinger on 23.04.23.
//

import Foundation
import SwiftUI

struct MatchEditView<Element>: View where Element: MatchingModel {
    @Binding var element: Element

    @State private var showTextField = false

    var body: some View {
        Group {
            Section {
                Picker("Matching algorithm", selection: $element.matchingAlgorithm) {
                    ForEach(MatchingAlgorithm.allCases, id: \.self) { alg in
                        Text(alg.title).tag(alg)
                    }
                }
            } header: {
                Text("Matching")
            } footer: {
                Text(element.matchingAlgorithm.label)
                    .lineLimit(3, reservesSpace: true)
            }

            if showTextField {
                TextField(String(localized: "Matching pattern", comment: "Matching algorithm"), text: $element.match)
                    .clearable($element.match)

                Toggle(String(localized: "Case insensitive", comment: "Matching algorithm"), isOn: $element.isInsensitive)
            }
        }
        .onChange(of: element.matchingAlgorithm) { value in
            withAnimation {
                switch value {
                case .auto, .none:
                    showTextField = false
                default:
                    showTextField = true
                }
            }
        }
    }
}
