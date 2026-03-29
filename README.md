meowix
------
>
> This is a project that I am trying to **build from scratch**[^1], \
> And **do not take** from other NixOS configurations

This is a NixOS configuration that is used for 3 hosts that are all on one computer but different operating systems. \
I am treating myself as completely new to NixOS and I will learn making a configuration for myself because \
Arch Linux tends to break and I need to re-install it everytime \
I know there are various tools to install such distro but configuring it will be a mess ( and boring ) \
While on NixOS it is easy by just adding a configuration.

#### Map of planned hosts to build

| Name         | Type        | Use case                           |
| :----------- | :---------- | :--------------------------------- |
| Meowscarada  | NixOS-WSL   | Development and Environment        |
| Lucario      | NixOS       | Gaming, daily drive, Development   |
| Necrozma     | nix-darwin  | Development and Environment, Apps  |

> More can be seen [hosts](./docs/HOSTS.md)

#### Note taking

I will use Obsidian for note taking and it is inside [notes](./notes/README.md) directory \
I will mostly take notes of strange words, topics, systems, etc.
By doing this it will help me get into my project faster \
Rather than forgetting what does the code's functions, variables, workarounds do
And to make documentation for this project

### Rules for this project

#### AI

- AI Usage for generating/rewriting content is **prohibited**
- Using AI to fix bugs or grammar/code issues is fine
- Using AI for problem solving suggestions are fine (such as how to implement host generation)
- AI usage should be strict and advanced (like having skills or specific markdown file)

#### Commit messages

For commit messages, use conventional commits \
For consistency and readability across versions

> The commit message should be structured as it follows:
>
> ```bash
> <type>[optional scope]: <description>
> [optional body]
> [optional footer(s)] 
> ```

#### Formatting

Always format each file if applicable
> If applicable is things that are binary files or text, etc

#### Notes

Take notes using Obsidian and take notes about things that \
I do not understand like specific words, (derivations, store path, etc)
Code's functions such as resolve, resolveHm, resolveDarwin (lib.mapAttrs', etc)
> So just a small wiki for myself that I collected from resources

#### Layout

Use layout structure that is written in [LAYOUT](./docs/LAYOUT.md)

- The file has tree-structure captured of this project and it's description,
    It maps the project structure so it will be understandable what each parts of the project do

---------------

#### References

- Host names - [Pokédex](https://www.pokemon.com/us/pokedex)
- Markdown - [Markdown Guide](https://markdownguide.org)
- Learning Resources - [awesome-nix](https://github.com/nix-community/awesome-nix#learning)
- Conventional Commits - [conventionalcommits.org](https://www.conventionalcommits.org)

[^1]: Except learning resources such as in the the [references](#references)
