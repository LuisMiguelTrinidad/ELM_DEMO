import { Elm } from "./Main.elm";

Elm.Main.init({
  node: document.getElementById("root"),
  flags: "Initial message",
});

if (import.meta.hot) {
  import.meta.hot.accept();
}
