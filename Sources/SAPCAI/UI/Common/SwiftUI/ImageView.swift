import SDWebImageSwiftUI
import SwiftUI

/// Renders an image from a MediaItem data model
struct ImageView: View {
    var imageUrl: URL

    @State private var isAnimated = true
    
    var body: some View {
        VStack(spacing: 0) {
            if imageUrl.absoluteString.range(of: "sap-icon") != nil {
                IconImageView(iconUrl: imageUrl.absoluteString, iconSize: CGSize(width: 50, height: 50))
            } else {
                WebImage(url: imageUrl, options: [.progressiveLoad, .delayPlaceholder], isAnimating: $isAnimated)
                    .placeholder(Image(systemName: "photo"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
            }
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(imageUrl: URL(string: "sap-icon://accept")!)
    }
}
