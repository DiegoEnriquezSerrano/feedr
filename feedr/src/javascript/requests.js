let authenticate = async (type, body) => {
  let error = '';

  if (type === 'login') {
    error = 'Sorry, we could not find a match for that email/password combination.';
  } else if (type === 'signup') {
    error = 'Sorry, we were unable to sign you up at this time, please try again later.';
  }

  let url = `http://localhost:4000/${type}`;
  let params = {
    method: 'POST',
    credentials: 'include',
    body: JSON.stringify(body),
    headers: { "Content-Type": "application/json" }
  };

  const req = await fetch(url, params)
  if (req.status >= 400) return console.error(error);
  window.location.href = "http://localhost:3000";
}

export default {
  authenticate,
}