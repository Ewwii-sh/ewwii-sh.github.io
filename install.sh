#!/usr/bin/env sh
set -e

INSTALLER_VERSION="1.0.0"

# --- Colors ---
RED=$(printf '\033[31m')
GREEN=$(printf '\033[32m')
YELLOW=$(printf '\033[33m')
BLUE=$(printf '\033[34m')
BOLD=$(printf '\033[1m')
RESET=$(printf '\033[0m')

# --- Banner ---
echo "${BLUE}${BOLD}"
echo "====================================="
echo "   ewwii/eiipm Installer (v$INSTALLER_VERSION)"
echo "====================================="
echo "${RESET}"

# --- SUDO Warning ---
if [ "$EUID" -eq 0 ]; then
    echo -e "${RED}Please run this script as a normal user, not as root.${RESET}"
    echo
    echo -e "${YELLOW}We will ask for sudo privileges only when necessary.${RESET}"
    exit 1
fi

# --- Ask OS ---
echo "${YELLOW}Which OS are you installing on?${RESET}"
echo "  [1] Linux"
echo "  [2] macOS"
echo "  [3] Other"
printf "Enter choice [1/3]: "
read choice

if [[ "$choice" == "2" || "$choice" == "3" ]]; then
    echo -e "${RED}Sorry! This installer currently supports Linux only.${RESET}"
    echo
    echo -e "${YELLOW}Need help setting it up on your system?${RESET}"
    echo -e "- ${YELLOW}Visit: ${BLUE}https://ewwii-sh.github.io/articles/en/getting_started${RESET}"
    exit 1
fi

# --- Continue for Linux ---
echo "${GREEN}Great! Proceeding with Linux installation...${RESET}"

EIIPM_REPO="Ewwii-sh/eiipm"
EIIPM_LATEST_URL="https://github.com/$EIIPM_REPO/releases/latest"

EWWII_REPO="Ewwii-sh/ewwii"
EWWII_LATEST_URL="https://github.com/$EWWII_REPO/releases/latest"

TMP_DIR=$(mktemp -d)
cd "$TMP_DIR"

echo "${YELLOW}Which tool(s) do you want to install?${RESET}"
echo "  [1] eiipm"
echo "  [2] ewwii"
echo "  [3] Both"
printf "Enter choice [1/3]: "
read tool_choice

# --- Install eiipm ---
if [ "$tool_choice" = "1" ] || [ "$tool_choice" = "3" ]; then
    EIIPM_DOWNLOAD_URL=$(curl -sL -o /dev/null -w '%{url_effective}' "$EIIPM_LATEST_URL" | sed 's/tag/download/')
    BIN_NAME="eiipm"

    echo "${BLUE}Downloading latest $BIN_NAME release...${RESET}"
    curl -sL "$EIIPM_DOWNLOAD_URL/$BIN_NAME" -o "$BIN_NAME"

    echo "${BLUE}Granting $BIN_NAME executable permission...${RESET}"
    chmod +x "$BIN_NAME"

    echo "${BLUE}Installing $BIN_NAME to /usr/local/bin (requires sudo)...${RESET}"
    sudo mv "$BIN_NAME" /usr/local/bin/
fi

# --- Install ewwii ---
if [ "$tool_choice" = "2" ] || [ "$tool_choice" = "3" ]; then
    EWWII_DOWNLOAD_URL=$(curl -sL -o /dev/null -w '%{url_effective}' "$EWWII_LATEST_URL" | sed 's/tag/download/')
    BIN_NAME="ewwii"

    echo "${BLUE}Downloading latest $BIN_NAME release...${RESET}"
    curl -sL "$EWWII_DOWNLOAD_URL/$BIN_NAME" -o "$BIN_NAME"

    echo "${BLUE}Granting $BIN_NAME executable permission...${RESET}"
    chmod +x "$BIN_NAME"

    echo "${BLUE}Installing $BIN_NAME to /usr/local/bin (requires sudo)...${RESET}"
    sudo mv "$BIN_NAME" /usr/local/bin/
fi

# --- Finish ---
echo ""
echo "${GREEN}${BOLD}⭐✨ Installation complete! ✨⭐${RESET}"
echo ""

if [ "$tool_choice" = "1" ]; then
    echo "Run '${BOLD}eiipm${RESET}' to get started."
elif [ "$tool_choice" = "2" ]; then
    echo "Run '${BOLD}ewwii${RESET}' to get started."
else
    echo "Run '${BOLD}eiipm${RESET}' or '${BOLD}ewwii${RESET}' to get started."
fi