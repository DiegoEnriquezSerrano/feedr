function port(location) {
  let port;
  typeof process !== 'undefined' ? port = process.env.PORT : port = window.location.port;

  if (location === "SERVER") {
    return Number(port) + 1000;
  } else if (location === "CLIENT") {
    return port;
  } else {
    throw "This is not a valid location";
  }
}

export let SERVER_PORT = port('SERVER');
export let CLIENT_PORT = port('CLIENT');