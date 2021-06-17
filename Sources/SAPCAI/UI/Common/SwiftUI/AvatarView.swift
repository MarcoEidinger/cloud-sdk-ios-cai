import SDWebImageSwiftUI
import SwiftUI

struct AvatarView: View {
    var imageUrl: String

    @State private var isAnimated = true
    
    var body: some View {
        WebImage(url: URL(string: imageUrl)!, options: [.progressiveLoad, .delayPlaceholder], isAnimating: $isAnimated)
            .resizable() // Make image resizable
            .aspectRatio(contentMode: .fill) // Fill the frame
            .clipped() // Clip overlaping parts
            .frame(width: 32, height: 32, alignment: .center)
    }
}

#if DEBUG
    struct AvatarView_Previews: PreviewProvider {
        static var previews: some View {
            AvatarView(imageUrl: "https://odesk-prod-portraits.s3.amazonaws.com/Companies:3813315:CompanyLogoURL?AWSAccessKeyId=AKIAIKIUKM3HBSWUGCNQ&Expires=2147483647&Signature=LWzh%2FJ1lzx172eTlTNk2aq1ZvJs%3D")
        }
    }
#endif
