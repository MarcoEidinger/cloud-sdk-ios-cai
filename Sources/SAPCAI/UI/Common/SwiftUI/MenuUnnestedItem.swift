import SwiftUI

struct MenuUnnestedItem: View {
    @EnvironmentObject private var themeManager: ThemeManager
    
    let menuAction: MenuAction
    let iconName: String
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            VStack(alignment: .leading, spacing: 6) {
                Text(menuAction.menuTitle)
                    .lineLimit(1)
                    .font(.headline)
                    .foregroundColor(themeManager.color(for: .primary1))
                Text(menuAction.value!)
                    .lineLimit(1)
                    .font(.subheadline)
                    .foregroundColor(themeManager.color(for: .primary2))
            }
            .padding([.top, .bottom], 10)
            
            Spacer()
            Image(systemName: iconName)
                .resizable()
                .frame(width: 28, height: 28)
                .foregroundColor(.blue)
                .padding([.top, .bottom], 20)
        }
    }
}

struct MenuListItemView_Previews: PreviewProvider {
    static var previews: some View {
        MenuUnnestedItem(menuAction: CAIChannelMenuDataAction("Google", "Link", "https://www.google.com", nil), iconName: "link").environmentObject(ThemeManager.shared)
    }
}
