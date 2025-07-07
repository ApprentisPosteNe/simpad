#!/bin/bash

# Dossier de destination
DOSSIER="/home/pi/simba_maintenance"

# Créer le dossier s'il n'existe pas
mkdir -p "$DOSSIER"

# Créer le fichier index.html avec ton contenu exact
cat <<EOL > "$DOSSIER/index.html"
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Simba – Maintenance en cours</title>
  <style>
    html, body {
      margin: 0;
      padding: 0;
      height: 100%;
      max-height: 100vh;
      font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
      background-color: #f4f4f4;
      display: flex;
      flex-direction: column;
    }

    header {
      padding: 1rem;
    }

    .logo {
      width: 140px;
      height: auto;
    }

    main {
      flex: 1;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      text-align: center;
      padding: 1rem;
    }

    h1 {
      color: #ffcc00;
      font-size: 2rem;
      margin-bottom: 1rem;
    }

    p {
      color: #333;
      font-size: 1.2rem;
      margin: 0.4rem 0;
    }

    footer {
      padding: 0.8rem 1rem;
      text-align: center;
      font-size: 0.9rem;
      color: #555;
      background: #fff;
      border-top: 1px solid #ddd;
    }
  </style>
</head>
<body>

<header>
    <svg class="logo" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 72 72" width="80" height="80" aria-hidden="true">
      <g id="Logo">
        <rect fill="#ffcc00" x="0" y="0" width="72" height="72"></rect> 
        <polygon fill="#ff0000" points="34,32.3 34,19 19.7,19 19.7,29.1 10,29.1 10,42.9 19.7,42.9 19.7,53 34,53 34,39.7 30.6,39.7 30.6,49.8 23.1,49.8 23.1,39.7 13.4,39.7 13.4,32.3 23.1,32.3 23.1,22.2 30.6,22.2 30.6,32.3"></polygon>
        <path d="M53.56234,31.10526c0,2.41272-1.99154,4.29475-4.51723,4.29475H45.2v-8.3h3.84511C51.66802,27.1,53.56234,28.78889,53.56234,31.10526z M50.69666,19H36v34h9.2V42.9h5.49666c6.75131,0,11.9971-5.15137,11.9971-11.8057C62.69376,24.39136,57.35099,19,50.69666,19z"></path>
      </g>
    </svg>
</header>

<main>
  <h1>Simba</h1>
  <p>est en maintenance</p>
  <p>befindet sich in Wartung</p>
  <p>is under maintenance</p>
  <p>è in manutenzione</p>
</main>

<footer>
  Merci de votre compréhension – Vielen Dank für Ihr Verständnis – Thank you for your understanding – Grazie per la comprensione
</footer>

</body>
</html>
EOL

# Lancer le serveur Python si pas déjà lancé
if ! pgrep -f "python3 -m http.server 8000" > /dev/null; then
    cd "$DOSSIER"
    python3 -m http.server 8000 &
    echo "Serveur Simba démarré sur le port 8000"
else
    echo "Le serveur Simba est déjà en cours d'exécution"
fi

# Attendre 2 secondes pour laisser le serveur démarrer
sleep 2

# Ouvrir le navigateur Chromium sur la page
chromium-browser http://localhost:8000

