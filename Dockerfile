# =============================
# Dockerfile - KNN classifier
# =============================
FROM python:3.11-slim

# Ustawienie katalogu roboczego
WORKDIR /app

# Kopiowanie plików requirements
COPY requirements.txt .

# Instalacja zależności
RUN pip install --no-cache-dir -r requirements.txt

# Kopiowanie całej aplikacji
COPY . .

# Ustawienie domyślnego komendy
CMD ["python", "knn_service.py"]
