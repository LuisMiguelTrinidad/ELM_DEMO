/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./index.html", "./src/**/*.{elm,css}"],
  theme: {
    extend: {
      backgroundImage: {
        "svgImage": "url('/public/assets/ffflux.svg')",
      }
    },
  },
  plugins: [],
};
