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

# Kopiowanie całej aplikacji (w tym knn_service.py)
COPY . .

# Ustawienie portu dla Flask
EXPOSE 5000

# Domyślny CMD uruchamia serwis
CMD ["python", "knn_service.py"]
