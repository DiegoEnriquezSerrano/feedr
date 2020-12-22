import { SERVER_PORT, CLIENT_PORT } from './functions.js'

let authenticate = async (type, body) => {
  let error = '';
  let url = `http://localhost:${SERVER_PORT}/${type}`;
  let params = {
    method: 'POST',
    credentials: 'include',
    body: JSON.stringify(body),
    headers: { "Content-Type": "application/json" }
  };

  if (type === 'login') {
    error = 'Sorry, we could not find a match for that email/password combination.';
  } else if (type === 'signup') {
    error = 'Sorry, we were unable to sign you up at this time, please try again later.';
  };

  const req = await fetch(url, params)
  if (req.status >= 400) return console.error(error);
  window.location.href = `http://localhost:${CLIENT_PORT}`;
};

let submitOrder = async () => {
  let url = `http://localhost:${SERVER_PORT}/new_order`;
  let params = {
    method: 'POST',
    credentials: 'include',
    headers: { "Content-Type": "application/json" }
  };

  const req = await fetch(url, params);
  if (req.status === 201) {
    window.location.href = `http://localhost:${CLIENT_PORT}`;
  };
};

let getCaterers = async (currentAddress) => {
  let urlParams = "";
  if (currentAddress != {}) urlParams = `?lat=${currentAddress.latitude}&lon=${currentAddress.longitude}`;
  let url = `http://localhost:${SERVER_PORT}/caterers${urlParams}`;
  let opts = { method: 'GET', credentials: 'include' };
  let res = await fetch(url, opts);
  return await res.json();
};

let editAddress = async (body) => {
  let url = `http://localhost:${SERVER_PORT}/customer_addresses`;
  let params = {
    method: 'POST',
    credentials: 'include',
    body: JSON.stringify(body),
    headers: { "Content-Type": "application/json" }
  };
  if (body.addressId != null) {
    url += `/${body.addressId}`;
    params.method = 'PUT';
  };
  return await fetch(url, params);
};

export default {
  authenticate,
  submitOrder,
  getCaterers,
  editAddress
}