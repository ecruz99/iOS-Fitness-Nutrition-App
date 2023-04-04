import Foundation
import SwiftUI


struct MyTDECalculator: View {
    let user: User
    
    var body: some View {
        HStack(alignment: .center) {
            TDEBox(
                headline: "BMR",
                result: String(format: "%.2f", user.BMR))
            Text("•").font(.title3).bold()
            TDEBox(
                headline: "Active Cal",
                result: "healthkit")
            Text("=").font(.title3).bold()
            TDEBox(
                headline: "TDE",
                result: "TDE here")
        }
    }
    
    struct TDEBox: View {
        let headline: String
        let result: String
        
        var body: some View {
            VStack(alignment: .center) {
                Text(headline).font(.title3).bold()
                Text(result)
            }.padding(8).border(.black)
        }
    }
}
