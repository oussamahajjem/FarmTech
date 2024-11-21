import SwiftUI

struct ForgotPasswordView: View {
    @StateObject private var authService = AuthService(networkService: NetworkService.shared)
    @State private var email: String = ""
    @State private var message: String? = nil
    @State private var isLoading: Bool = false

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .padding()
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)

            Button("Reset Password") {
                resetPassword()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .disabled(isLoading)

            if isLoading {
                ProgressView()
                    .padding()
            }

            if let message = message {
                Text(message)
                    .foregroundColor(.green)
                    .padding(.top)
            }
        }
        .padding()
        .navigationTitle("Forgot Password")
    }

    func resetPassword() {
        guard !email.isEmpty else {
            message = "Please enter your email address"
            return
        }

        isLoading = true
        message = nil

        authService.forgotPassword(email: email) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let message):
                    self.message = message
                case .failure(let error):
                    self.message = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
}

