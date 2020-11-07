function port(location) {
  let currentPort;
  typeof process !== 'undefined' ? currentPort = process.env.PORT : currentPort = window.location.port;

  if (location === "SERVER") {
    return Number(currentPort) + 1000;
  } else if (location === "CLIENT") {
    return currentPort;
  } else {
    throw "This is not a valid location";
  }
}

export let SERVER_PORT = port('SERVER');
export let CLIENT_PORT = port('CLIENT');