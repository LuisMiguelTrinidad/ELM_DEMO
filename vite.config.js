import elmPlugin from "vite-plugin-elm";

/** @type {import('vite').UserConfig} */
export default {
  plugins: [elmPlugin()],
  server: {
    port: 3000,
    open: true,
    cors: false,
    headers: {
      "Access-Control-Allow-Origin": "*",
    },
  }, 
};



