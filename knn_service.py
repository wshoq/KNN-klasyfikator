import pandas as pd
import numpy as np
from sklearn.neighbors import KNeighborsClassifier
from flask import Flask, request, jsonify

app = Flask(__name__)

# --- Wczytanie CSV z mountowanego folderu ---
try:
    df = pd.read_csv("/app/datasets/dataset.csv")
except FileNotFoundError:
    print("Brak pliku dataset.csv w /app/datasets")
    df = pd.DataFrame(columns=["klasa", "Embedding"])

# --- Przygotowanie danych do KNN ---
if not df.empty:
    X = np.vstack(df["Embedding"].apply(lambda x: np.array(eval(x))))
    y = df["klasa"].values
    knn = KNeighborsClassifier(n_neighbors=5, metric="cosine")
    knn.fit(X, y)
    print(f"Trenuję KNN na {len(df)} przykładach...")
else:
    knn = None
    print("Brak danych treningowych. KNN nie zostanie wytrenowany.")

# --- Endpoint predykcji ---
@app.route("/predict", methods=["POST"])
def predict():
    global knn
    if knn is None:
        return jsonify({"error": "KNN nie został wytrenowany"}), 400
    data = request.get_json()
    embedding = np.array(data["embedding"])
    pred = knn.predict([embedding])[0]
    return jsonify({"category": pred})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
