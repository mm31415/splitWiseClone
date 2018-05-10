import React from "react";
import { Redirect } from "react-router-dom";

export const Dashboard = (props) => {

  if (!props.logged_in) {
    return <Redirect to="/" />;
  }
  return <h1>Hey guy, you're at the dashboard</h1>;
}
