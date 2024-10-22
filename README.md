<a name="readme-top"></a>

<h1 align="center">Project created with <a href="https://github.com/data-miner00/elm-vite-template">this template</a></h1>

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="/">
    <img src="public/assets/elm-vite-tailwind.png" />
  </a>

  <h3 align="center">Elm Vite Template</h3>

  <p align="center">
    Minimalistic Elm Template powered by Vite!
    <br />
    <a href="https://elm-vite-template.vercel.app"><strong>View Demo »</strong></a>
    <br />
    <br />
    <a href="https://github.com/data-miner00/elm-vite-template">Explore the docs</a>
    ·
    <a href="https://github.com/data-miner00/elm-vite-template/issues">Report Bug</a>
    ·
    <a href="https://github.com/data-miner00/elm-vite-template/issues">Request Feature</a>
  </p>
</div>

<!-- ABOUT THE PROJECT -->

<h2>About The Project</h2>

A simple webApp using Elm where you can load a csv and retrieve a interactive table and some graphs.
<br>
<h2>Demo</h2>
<a>https://elm-demo-1.onrender.com/<a>
The page might take up to 30-45 minute to load (It's a free hosting site and it will shut off when there is no activity)
<br>
<h2>Format</h2>
<code>Id,Balance,Amount,Currency,Type,Status,Modified,Trade Id,Instrument Symbol,Instrument Name,Commission,Account type</code>
<br>
<code>"75311057400111","16172.09","4.66","EURd","TRADE","PROCESSED","2024-10-12 20:50:31","0015421d-0055-311e-0000-4e28000a8aa4_0015421d-0055-311e-0000-000081309791","ETH/USD","Ethereum / USD","",""</code>

<h2>Built with</h2>
The language, packages and technologies used in this project
<ul>
  <li>Elm</li>
  <li>terezka/elm-charts</li>
  <li>BrianHicks/elm-csv</li>
  <li>Vite</li>
  <li>TailwindCss</li>
</ul>


<!-- GETTING STARTED -->

<h2>Getting Started</p2>

<h3>Prerequisites<h3>

The list of tools that is used when development.

- npm
  ```sh
  npm install npm@latest -g
  ```
- [Git](https://git-scm.com/downloads)
- [Elm](https://elm-lang.org/)

<h2>Installation</h2>

To use this template for personal use or contribution, simply perform the following.

1. Clone the repo
   ```sh
   git clone https://github.com/LuisMiguelTrinidad/ELM_DEMO.git
   ```
2. Install Node dependencies
   ```sh
   npm i
   ```
3. Optionally update the dependencies
   ```sh
   npm up --latest
   ```
<h2>Commands</h2>
This are all useful commands

1. Run formatter to format code
   ```sh
   npm run format
   ```
2. Review Elm code quality
   ```sh
   npm run review
   ```
3. Start dev server
   ```sh
   npm run dev
   ```
4. Compile for production (I have enabled cors by default)
   ```sh
   npm run build
   ```
5. Preview production build (You must build before)
   ```sh
   npm run preview 
   ```
6. Start standalone Elm reactor
    ```sh
    npm run elm:dev
    ```
7. Build standalone Elm code
    ```sh
    npm run elm:build
    ```
8. Start interactive Elm shell
    ```sh
    npm run repl
    ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<h2>License</h2>

Distributed under the Apache 2.0 License. See `LICENSE` for more information.


