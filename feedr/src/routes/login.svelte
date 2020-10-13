<script>

let email;
let password;

let authenticate = async () => {
  let body = {
    email,
    password
  }
  let url = "http://localhost:4000/login";
  let params = {
    method: 'POST',
    credentials: 'include',
    body: JSON.stringify(body),
    headers: { "Content-Type": "application/json" }
  };

  await fetch(url, params)
  .then(response => {
    console.log(response);
    })
}

</script>

<svelte:head>
	<title>Feedr | Login</title>
</svelte:head>

<main>
  <form class="authentication-form">
    <div class="field">
      <label for="email">Email</label>
      <input type="text" name="email" bind:value={email} required>
    </div>
    <div class="field">
      <label for="password">Password</label>
      <input type="password" name="password" bind:value={password} required>
    </div>
    <button type="submit" class="button primary" on:click|preventDefault={authenticate}>Submit</button>
  </form>
</main>

<style>

main {
  position: absolute;
  top: 0;
  margin: 0;
  display: grid;
  align-items: center;
  justify-items: center;
  width: 100vw;
  height: 100%;
  min-height: 100vh;
  padding-top: 3rem;
  overflow: auto;
  background-image: url('/images/SignUpPageBackground.jpg');
  background-attachment: fixed;
  background-position: top left;
  background-size: cover;
  background-repeat: no-repeat;
  color: #fdfdfd;
}

.authentication-form {
  display: grid;
  background-color: #ffffff;
  color: #020202;
  align-content: center;
  align-items: center;
  justify-content: stretch;
  max-width: 500px;
  width: calc(100vw - 20px);
  border: 2px solid #B6B6B6;
  margin-top: 20px;
  border-radius: 5px;
  box-shadow: 0 1px 5px -2px rgb(10,10,10);
  padding: 20px;
  grid-gap: 10px;
}

.field {
  grid-template-columns: 1fr;
}

label {
  font-size: 1.0rem;
  font-weight: bold;
  font-family: Arial, Helvetica, sans-serif;
  display: block;
}

input {
  padding: 5px;
  display: block;
  width: 100%
}

@media(min-width: 500px) {


}

</style>