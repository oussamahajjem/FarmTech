import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String? = nil
    @State private var isLoggedIn: Bool = false  // Pour vérifier si la connexion a réussi

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .padding()
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.none)

            SecureField("Password", text: $password)
                .padding()

            Button("Sign In") {
                login()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)

            if let errorMessage = errorMessage {
                Text(errorMessage).foregroundColor(.red)
            }

            if isLoggedIn {
                Text("Logged In Successfully!").foregroundColor(.green)
            }
        }
        .padding()
        .navigationTitle("Sign In")
    }

    func login() {
        NetworkService.shared.login(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    // Traitement de la réponse réussie
                    print("Login réussi : \(String(data: data, encoding: .utf8) ?? "")")
                    isLoggedIn = true
                    // Vous pouvez gérer l'authentification ici (e.g., save token)
                case .failure(let error):
                    errorMessage = "Erreur : \(error.localizedDescription)"
                }
            }
        }
    }
}
