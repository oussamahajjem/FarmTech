import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "leaf.circle") // Remplacez par votre logo
                .font(.system(size: 80))
                .padding()
            
            Text("WELCOME")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 4)
            
            Text("FarmTech.")
                .font(.title3)
                .foregroundColor(.gray)
            
            Spacer()
            
            NavigationLink(destination: SignInView()) {
                Text("Sign In With Email")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 8)
            
            NavigationLink(destination: SignUpView()) {
                Text("Don’t have an account? Sign Up")
                    .foregroundColor(.blue)
            }
            .padding(.bottom, 20)
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.7), Color("Background")]), startPoint: .top, endPoint: .bottom)
        )
        .ignoresSafeArea()
    }
}
