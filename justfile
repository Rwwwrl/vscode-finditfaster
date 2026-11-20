# Package the extension as a VSIX and install it in VS Code.
install-vsix:
    npm ci --include=dev
    npm run vscode:package -- --out find-it-faster.vsix
    code --install-extension find-it-faster.vsix --force

# Package the extension as a VSIX and install it in Cursor.
install-cursor:
    npm ci --include=dev
    npm run vscode:package -- --out find-it-faster.vsix
    cursor --install-extension find-it-faster.vsix --force

# Package the extension as a VSIX and install it in Devin IDE (Windsurf).
install-windsurf:
    npm ci --include=dev
    npm run vscode:package -- --out find-it-faster.vsix
    devin-desktop --install-extension find-it-faster.vsix --force
