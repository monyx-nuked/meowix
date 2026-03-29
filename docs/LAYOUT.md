# LAYOUT

```bash
meowix
├── .editorconfig             | EditorConfig
├── .envrc                    | Direnv Configuration
├── .gitattributes            | Git Attributes
├── .gitignore                | Files to ignore in git
├── .gitmessage               | Template git message
├── .vscode                   | Workspace settings
│   ├── extensions.json       | Extensions
│   ├── mcp.json              | MCPs
│   └── settings.json         | Workspace-specific settings
├── AGENTS.md                 | README File for AI Agents
├── docs                      | Documentation assets
│   ├── HOSTS.md              | List of hosts and thier state
│   ├── LAYOUT.md             | Layout of this project
│   └── README.md             | Description of the folder
├── flake.lock                | Flake Lockfile
├── flake.nix                 | Nix Flake
├── GEMINI.md -> AGENTS.md    | GEMINI.md symlinked to AGENTS.md
├── modules                   | Flake Modules
│   ├── *.nix                 | Root-level/Uncategorized modules
│   ├── flake-parts           | Flake-parts specific modules
│   │   ├── devshell.nix      | DevShells
│   │   ├── hosts.nix         | Hosts generator
│   │   ├── lib.nix           | Libraries for flake
│   │   ├── meta.nix          | Metadata declarations
│   │   ├── modules.nix       | Modules to import from flake-parts
│   │   └── nixpkgs.nix       | Nixpkgs-specific settings (such as `systems` to generate)
│   ├── hosts/*.nix           | Hosts modules
│   └── */*.nix               | Any other system configuration categorized
├── notes                     | Obsidian vault
│   └── README.md             | Description of the folder
├── README.md                 | README of this project
└── TODO.md                   | TODO List (likely unmaintained)
```
