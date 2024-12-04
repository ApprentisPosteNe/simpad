from flask import Flask, render_template, redirect, url_for, jsonify, request
import nfc
import jwt
import time
import base64
SECRET_KEY = '069332689e9ea429cbe681fbe05b3c403490a38208a0d15cbe967069d18490b7'
ALGORITHM = 'HS256'

app= Flask(__name__)

def read_nfc():
    # Initialize the NFC reader
    clf = nfc.ContactlessFrontend('usb')

    if not clf:
        raise RuntimeError("NFC reader not found. Please connect the device.")

    print("Waiting for NFC badge...")

    # Variable to store the UID
    card_uid = None

    def on_connect(tag):
        nonlocal card_uid  # Access the variable defined outside this function
        print("Badge detected!")
        card_uid = tag.identifier.hex().upper()  # Convert UID to a readable hex string
        print(f"Card UID: {card_uid}")
        return False  # Disconnect immediately after reading the tag

    # Wait for a tag to be presented
    while True:
        try:
            clf.connect(rdwr={'on-connect': on_connect})
            if card_uid:
                clf.close()
                print(f"Returning UID: {card_uid}")
                return card_uid
        except Exception as e:
            print(f"Error while reading NFC badge: {e}")
            clf.close()
            break
def get_signing_key():
    # Decode the Base64-encoded secret key
    key_bytes = base64.b64decode(SECRET_KEY)
    return key_bytes
        
@app.route('/')
def index():
    return render_template('Simba.html')

@app.route('/waiting', methods=['GET'])
def wait_for_nfc():
    cardUID = read_nfc()
    if cardUID:
        # Create the JWT token with the NFC data
        token = jwt.encode({"card_uid": cardUID}, get_signing_key(), algorithm=ALGORITHM)
        print(cardUID)
        print(token)
        
        # Return the redirection URL as a JSON response
        redirect_url = f"https://app-test-simba.azurewebsites.net/simba/external/api/v1/pad-dashboard/login?token={token}"
        return jsonify({"redirect_url": redirect_url})
    
    return jsonify({"error": "No NFC data received"}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)