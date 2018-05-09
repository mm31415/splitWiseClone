import React from 'react';
import ReactDOM from 'react-dom';
import { configureStore } from "./store/store.js";
import { Root } from "./root"
import { signup, login, logout } from "./actions/session_actions";

document.addEventListener("DOMContentLoaded", () => {
  let store;
  if (window.currentUser) {
    const preloadedState = {
      entities: {
        users: { [window.currentUser.id]: window.currentUser }
      },
      session: { id: window.currentUser.id }
    };
    store = configureStore(preloadedState);
    delete window.currentUser;
  } else {
    store = configureStore();
  }

  //testing only
  // window.store = store;
  window.getState = store.getState;
  window.dispatch = store.dispatch;

  //// testing only


  const root = document.getElementById("root");
  ReactDOM.render(<Root store={store} />, root);
});

window.signup = signup;
window.login = login;
window.logout = logout;
