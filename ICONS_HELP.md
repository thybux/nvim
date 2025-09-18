# 🎨 Guide des Icônes nvim-tree

## ⚡ Test Rapide

Dans Neovim, utilisez : `<leader>ti` ou `:TestTreeIcons`

## 🔧 Si Vous Ne Voyez Pas les Icônes

### 1. Installez JetBrains Mono Nerd Font
```bash
brew install font-jetbrains-mono-nerd-font
```

### 2. Configurez Votre Terminal

#### Warp (votre terminal)
1. Ouvrez Warp
2. Menu **Warp** → **Settings** (⌘,)
3. Section **Appearance**
4. Changez **Font** pour "JetBrains Mono Nerd Font"
5. **Redémarrez Warp**

#### iTerm2
1. **iTerm2** → **Preferences** (⌘,)
2. **Profiles** → **Text**
3. **Font** → **Change Font**
4. Sélectionnez "JetBrains Mono Nerd Font"

#### Terminal.app
1. **Terminal** → **Preferences**
2. **Profiles** → Votre profil
3. **Text**
4. **Font** → **Change**
5. Sélectionnez "JetBrains Mono Nerd Font"

### 3. Vérifiez l'Installation

Tapez dans le terminal :
```
echo "📁 🔍 📄 ⚙️"
```

Si vous voyez les emojis, c'est bon !

## 🎯 Types d'Icônes Configurées

- **📁/📂** Dossiers (ouverts/fermés)
- **📄** Fichiers par défaut  
- **󰄥** JavaScript (.js)
- **󰠦** TypeScript (.ts)
- **󰢒** JSON (.json)
- **󰆓** Lua (.lua)
- **󰖖** Markdown (.md)
- **󰇢** HTML (.html)
- **󰆛** CSS (.css)

## ⚡ Keymaps nvim-tree

- `<leader>e` - Toggle nvim-tree
- `<leader>E` - Trouve le fichier actuel
- `<leader>ti` - Test des icônes

## 🔧 Dans nvim-tree

- **Tab** - Ouvrir/fermer dossier
- **Enter** - Ouvrir fichier
- **a** - Nouveau fichier
- **A** - Nouveau dossier
- **d** - Supprimer
- **r** - Renommer
- **q** - Fermer nvim-tree