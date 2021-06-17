import SDWebImageSwiftUI
import SwiftUI

/// Renders an image from a MediaItem data model
///
/// Size of the container for the rendering is computed
/// inside this view following these rules:
///  - Min Width: 44
///  - Min Height: 44
///  - Max Width: regular size class: 480, compact size class: geometry width * 0.75
///  - Max Height: regular size class: 400, compact size class: 240
struct ImageUIView: View {
    private let geometry: GeometryProxy
    
    private let media: MediaItem?

    @ObservedObject private var imageManager: ImageManager
    
    @Environment(\.horizontalSizeClass) private var hSizeClass

    @Environment(\.verticalSizeClass) private var vSizeClass
    
    private let fallback: Image
    
    /// Constructor
    /// - Parameters:
    ///   - geometry: GeometryProxy in which the image will be rendered. Only the width is used.
    ///   - media: MediaItem
    ///   - fallback: Fallback image used if media.sourceUrl is nil.
    init(geometry: GeometryProxy,
         media: MediaItem?,
         fallback: Image = Image(systemName: "icloud.slash"))
    {
        self.media = media
        self.geometry = geometry
        self.fallback = fallback

        self.imageManager = ImageManager(url: media?.sourceUrl)
        self.imageManager.load()
    }
    
    // :nodoc:
    var body: some View {
        Group {
            if let sourceUrl = media?.sourceUrl {
                if let image = imageManager.image {
                    WebImage(url: sourceUrl)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: targetSize(image).width, height: targetSize(image).height)
                        .preference(key: ImageSizeInfoPrefKey.self,
                                    value: CGSize(width: image.cgImage!.width,
                                                  height: image.cgImage!.height))
                } else {
                    WebImage(url: sourceUrl)
                }
            } else {
                fallback
            }
        }
    }

    func targetSize(_ image: UIImage) -> CGSize {
        SizeConverter<Text>.applySizeConstraints(from: CGSize(width: CGFloat(image.cgImage!.width), height: CGFloat(image.cgImage!.height)),
                                                 to: BoundingBox(minWidth: 44, minHeight: 44, maxWidth: self.hSizeClass == .regular ? 480 : self.geometry.size.width * 0.75, maxHeight: self.vSizeClass == .regular ? 400 : 240))
    }
}

struct ImageSizeInfoPrefKey: PreferenceKey {
    typealias Value = CGSize

    static var defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct ImageUIView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            ImageUIView(geometry: geometry, media: nil)
        }
    }
}
