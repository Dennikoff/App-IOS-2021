//
//  ViewPreview.swift
//  SnoKE
//
//  Created by Кристина Шляпкина on 01.11.2021.
//

import UIKit
import SwiftUI

struct ViewPreview: UIViewRepresentable {
    let viewBuilder: () -> UIView
    
    init(_ viewBuilder: @escaping () -> UIView) {
        self.viewBuilder = viewBuilder
    }
    
    func makeUIView(context: Context) -> some UIView {
        viewBuilder()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // Not needed
    }
}
