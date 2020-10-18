async function authenticate(type, body) {
  let error = '';

  if (type === 'login') {
    error = 'Unauthorized user';
  } else if (type === 'signup') {
    error = 'Unprocessable entity';
  }

  let url = `http://localhost:4000/${type}`;
  let params = {
    method: 'POST',
    credentials: 'include',
    body: JSON.stringify(body),
    headers: { "Content-Type": "application/json" }
  };

  const req = await fetch(url, params)
  if (req.status >= 400) return;
  window.location.href = "http://localhost:3000";
}

export default {
  authenticate,
}