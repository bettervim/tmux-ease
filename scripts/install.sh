
#!/bin/bash

# Set the GitHub repository, executable name, and download URL
repository="bettervim/tmux-ease"
executable_name="tmux-ease"
download_url="https://github.com/$repository/releases/latest/download/$executable_name"

# Set the destination directory in the PATH
destination_directory="/usr/local/bin/"

# Download the executable from the latest release
wget -O "$executable_name" "$download_url"

# Move the executable to the destination directory
sudo mv "$executable_name" "$destination_directory"

# Set appropriate permissions (optional)
sudo chmod +x "$destination_directory/$executable_name"

echo "Successfully installed tmux-ease."
