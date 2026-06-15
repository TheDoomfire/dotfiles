#!/bin/bash

# --- CONFIGURATION ---
# JELLYFIN_URL="http://jellyfin:8096" # Inside Docker
JELLYFIN_URL="http://localhost:8096"
# TODO: Find somewhere safe to store this:
API_KEY="" # Generate in Dashboard -> API Keys

# Creates a new Jellyfin user with default settings I have set for them.
newjellyfinuser() {
    # --- INPUT ---
    read -p "Enter new username: " NEW_USER
    read -s -p "Enter new password: " NEW_PASS
    echo ""

    # Create the User:
    echo "Creating user: $NEW_USER..."
    CREATE_RES=$(curl -s -X POST "$JELLYFIN_URL/Users/New" \
        -H "Authorization: MediaBrowser Token=\"$API_KEY\"" \
        -H "Content-Type: application/json" \
        -d "{\"Name\": \"$NEW_USER\", \"Password\": \"$NEW_PASS\"}")

    USER_ID=$(echo "$CREATE_RES" | grep -o '"Id":"[^"]*' | grep -o '[^"]*$')

    if [ -z "$USER_ID" ]; then
        echo "❌ Failed to create user. Check your API key or if user already exists."
        exit 1
    fi

    echo "✓ User created with ID: $USER_ID"

    # Apply Custom Subtitle Defaults (English + Always Play)
    echo "Applying subtitle defaults..."
    curl -s -X POST "$JELLYFIN_URL/Users/$USER_ID/Configuration" \
        -H "Authorization: MediaBrowser Token=\"$API_KEY\"" \
        -H "Content-Type: application/json" \
        -d '{
            "SubtitleLanguagePreference": "eng",
            "SubtitleMode": 1,
            "DisplayMissingEpisodes": false,
            "HidePlayedInLatest": false,
            "RememberAudioSelection": true,
            "RememberSubtitleSelection": true,
            "EnableLocalPassword": true
        }'

    echo "🎉 Done! User $NEW_USER is ready with forced English subtitles."

    # unset JELLYFIN_URL
    # unset API_KEY

}
