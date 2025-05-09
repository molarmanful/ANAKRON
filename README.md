<div align="center">

![anakron](img/header.png)

</div>

## Table of Contents

- [Table of Contents](#table-of-contents)
- [Overview](#overview)
- [Gallery](#gallery)
- [Installation](#installation)
  - [Nix Flakes](#nix-flakes)
- [Contributing](#contributing)
- [Licensing](#licensing)

## Overview

**ANAKRON** is an 8x12 bold monospace bitmap font suitable for programming.
Blending the thick strokes of the (C/E/V)GA era fonts with the thin strokes of
more modern pixel fonts, ANAKRON is designed to feel compact like an old-school
8x8 without compromising on Unicode support or usability.

## Gallery

<details>
<summary><strong>Glyphs</strong></summary>
<div align="center">

![ANAKRON glyphs](./img/chars.png)

</div>
</details>

<details>
<summary><strong>Glyphs Map</strong></summary>
<div align="center">

![ANAKRON glyphs map](./img/map.png)

</div>
</details>

<details open>
<summary><strong>Samples</strong></summary>
<div align="center">

![ANAKRON samples](./img/sample.png)

</div>
</details>

## Installation

Download from [Releases](https://github.com/molarmanful/ANAKRON/releases).
Included are bitmap formats - BDF, OTB, PCF, PSF (for Linux consoles), DFONT
(for Mac users) - as well as TTF and WOFF2. 2x/3x versions are available for
HiDPI screens. Note that PCF doesn't contain glyphs past U+FFFF.

For the crispiest viewing experience, try to use the bitmap formats when
possible. If bitmap fonts are not supported on your platform (e.g. Windows,
VSCode), then use the TTF at font sizes that are multiples of 12px.

> **Quick Tip**: If you need font size in pt, use the following conversion:
>
> `pt = px * 72 / dpi`
>
> e.g. 12px on a 96dpi screen is `12px * 72 / 96dpi = 9pt`.

### Nixpkgs

Thanks to [@ejiektpobehuk](https://github.com/ejiektpobehuk), ANAKRON is
available on Nixpkgs as `anakron`.

### Nix Flakes

ANAKRON releases are also pushed to
[FlakeHub](https://flakehub.com/flake/molarmanful/ANAKRON). `ANAKRON` (aliased
to `default`) is the base package, while `ANAKRON-nerd` includes Nerd Fonts
patches.

## Contributing

Issues, feature/glyph requests, and pull requests are all welcome!

## Licensing

Made with ♥ by [the ANAKRON Project Authors](AUTHORS). Released under the
OFL-1.1 License.
