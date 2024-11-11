// Calcula el coeficiente binomial de n en k

#include <bits/stdc++.h>

using namespace std;

int coeficienteBinomial(int n, int k) {
    if (k == 0 || k == n) {
        return 1;
    }
    return coeficienteBinomial(n - 1, k - 1) + coeficienteBinomial(n - 1, k);
}

int main() {
    ios::sync_with_stdio(0); cin.tie(0); cout.tie(0);

    int n, k;
    cout << "Introduce n: ";
    cin >> n;
    cout << "Introduce k: ";
    cin >> k;

    cout << "El coeficiente binomial es: " << coeficienteBinomial(n, k) << endl;

    return 0;
}