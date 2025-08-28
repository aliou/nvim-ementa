# AGENTS.md

## Working in the nvim-ementa Project

This project is a Neovim plugin that assembles small, opinionated, and useful Lua snippets into a unified "menu" (ementa in Portuguese). The following guidelines ensure consistency, maintainability, and modern best practices:

### 1. Language and API Usage
- **Write everything in Lua.** Do not use Vimscript for any part of the plugin.
- **Use modern Neovim APIs (v0.11+).** Prefer `vim.api`, `vim.ui`, and other up-to-date interfaces. Avoid deprecated or legacy APIs.

### 2. Snippet Philosophy
- **Opinionated by default.** Snippets should work out-of-the-box with sensible defaults. Avoid exposing setup/configuration unless explicitly requested.
- **Minimal setup functions.** Only add setup/configuration functions if explicitly asked. If you must add one:
  - Choose sensible, practical defaults.
  - Document all options in both the README and the `doc/` directory.

### 3. Documentation
- **README:** Update the README with any new features, setup options, or usage instructions.
- **doc Directory:** For any setup function or configurable snippet, add a corresponding help file in the `doc/` directory, following Neovim's documentation conventions.

### 4. Code Style & Structure
- **Modular Lua files:** Organize snippets and features in logical modules under `lua/ementa/`.
- **No Vimscript:** All plugin logic, configuration, and commands must be written in Lua.
- **Use idiomatic Lua:** Prefer local functions, tables, and modern Lua patterns.

### 5. Menu Integration
- **Unified menu:** All snippets should be accessible via a central menu, using modern Neovim UI APIs where possible.
- **Consistent UX:** Ensure all snippets follow a consistent user experience and interface style.

### 6. Contribution Checklist
- [ ] Write new features/snippets in Lua only
- [ ] Use Neovim 0.11+ APIs
- [ ] Avoid setup/config unless explicitly requested
- [ ] Document any setup/config in README and doc/
- [ ] Integrate snippet into the main menu
- [ ] Test for sensible defaults and usability

---

For questions or suggestions, open an issue or pull request. Thank you for contributing to nvim-ementa!
