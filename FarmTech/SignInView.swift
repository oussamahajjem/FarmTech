import SwiftUI

struct SignInView: View {
    @StateObject private var authService = AuthService(networkService: NetworkService.shared)
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String? = nil
    @State private var isLoggedIn = false
    @State private var isSigningUp = false

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.7), Color.white]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        Image(systemName: "leaf.circle")
                            .font(.system(size: 80))
                            .foregroundColor(.green)
                            .padding(.top, 50)
                        
                        Text("Sign In")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        VStack(spacing: 15) {
                            TextField("Email", text: $email)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal)
                            
                            SecureField("Password", text: $password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal)
                        }
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        
                        Button(action: login) {
                            Text("Sign In")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        
                        NavigationLink(destination: ForgotPasswordView()) {
                            Text("Forgot Password?")
                                .foregroundColor(.green)
                        }
                        
                        if let errorMessage = errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .padding(.top)
                        }
                        
                        Spacer()
                        
                        NavigationLink(destination: HomeView(), isActive: $isLoggedIn) {
                            EmptyView()
                        }
                        
                        Button(action: { isSigningUp = true }) {
                            Text("Don't have an account? Sign Up")
                                .foregroundColor(.green)
                                .padding()
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(10)
                        }
                        .padding(.bottom, 20)
                        
                        NavigationLink(destination: SignUpView(), isActive: $isSigningUp) {
                            EmptyView()
                        }
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)
        }
    }

    func login() {
        authService.login(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let authResponse):
                    print("Login successful: \(authResponse.userId)")
                    print("Access Token: \(authResponse.accessToken)")
                    errorMessage = nil
                    isLoggedIn = true
                case .failure(let error):
                    errorMessage = "Error: \(error.localizedDescription)"
                    isLoggedIn = false
                }
            }
        }
    }
}

