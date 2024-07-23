# Variables

download() {
  # Create the local directory if it doesn't exist
  REMOTE_URL="$1"
  LOCAL_DIR="$2"
  mkdir -p "$LOCAL_DIR"

  # Fetch the directory listing
  wget -q -O - "$REMOTE_URL" | grep -oP '(?<=href=")[^"]*' | while read -r file; do
      # Skip if it's a directory
      if [[ "$file" == */ ]]; then
          continue
      fi

      # Download each file individually with a timeout of 5 seconds
      wget -T 5 -t 1 -P "$LOCAL_DIR" "$REMOTE_URL$file" 2>/dev/null

      # Check if the command was successful
      if [ $? -eq 0 ]; then
          echo "Downloaded $file successfully."
      else
          echo "Failed to download $file, but continuing."
      fi
  done

  echo "Download $REMOTE_URL completed."
}

download http://205.174.165.80/CICDataset/CIC-EvasivePDF2022/Dataset/extract/Malicious/f20/ f20
