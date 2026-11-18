#!/bin/bash
# Creates an ES-DE entry for every Faugus shortcut
APPS="$HOME/.local/share/applications"
DEST="/mnt/emmas/Games/ROMs/windows"

mkdir -p "$DEST"

for f in "$APPS"/*.desktop; do
  # Only pick up shortcuts that launch through Faugus
  grep -qi "faugus" "$f" || continue
  # Skip Faugus Launcher's own entry
  [[ "$(basename "$f")" == *faugus-launcher* ]] && continue

  name=$(grep -m1 '^Name=' "$f" | cut -d= -f2-)
  [ -z "$name" ] && continue

  script="$DEST/$name.sh"
  printf '#!/bin/bash\ngtk-launch "%s"\n' "$(basename "$f")" > "$script"
  chmod +x "$script"
done
