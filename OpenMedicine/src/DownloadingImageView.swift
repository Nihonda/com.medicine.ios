//
//  DownloadingImageView.swift
//  OpenMedicine
//
//  Created by Nurlan Nihonda on 12/11/21.
//

import SwiftUI

struct DownloadingImageView: View {
    
    @StateObject var loader: ImageLoadingViewModel
    
    init(url: String, key: String) {
        _loader = StateObject(wrappedValue: ImageLoadingViewModel(url: url, key: key))
    }
    
    var body: some View {
        ZStack {
            if loader.isLoading {
                ProgressView()
            } else if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    
            }
        }
    }
}

struct DownloadingImageView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImageView(url: "https://storage.googleapis.com/openmedicine-323603.appspot.com/images/1890104300111.jpg", key: "1")
            .frame(width: Screen.width * 0.25, height: 100)
            .previewLayout(.sizeThatFits)
    }
}
