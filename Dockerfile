# =============================
# Dockerfile - KNN classifier
# =============================
FROM python:3.11-slim

# Ustawienie katalogu roboczego
WORKDIR /app

# Zainstalowanie podstawowych build tools (dla scikit-learn)
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        gcc \
        g++ \
        libffi-dev \
        libssl-dev \
        && rm -rf /var/lib/apt/lists/*

# Kopiowanie pliku requirements.txt
COPY requirements.txt .

# Instalacja zależności Pythona
RUN pip install --no-cache-dir -r requirements.txt

# Kopiowanie całej aplikacji
COPY . .

# Ustawienie portu dla Flask
EXPOSE 5000

# Domyślna komenda, żeby kontener nie padł
CMD ["sleep", "infinity"]
