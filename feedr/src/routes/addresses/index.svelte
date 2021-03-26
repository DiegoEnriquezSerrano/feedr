<script context="module">

import { SERVER_PORT, CLIENT_PORT } from '../../javascript/functions.js';

export async function preload(page) {
  let user = false;
  const res = await this.fetch(`http://localhost:${SERVER_PORT}/`, { method: 'GET', credentials: 'include' });
  if (res.status == 200) user = await res.json();
  return { user };
};

</script>

<script>

  import SavedAddresses from '../../components/addresses/SavedAddresses.svelte';

  export let user;

  let addresses = [];

  if (user) {
    user = user.user;
    addresses = user.customer_addresses;
  }

</script>

<svelte:head>
	<title>Feedr | Saved addresses</title>
</svelte:head>

<main>
  <SavedAddresses {addresses} />
</main>

<style>

main {
  width: 100vw;
  height: 100%;
  min-height: 100vh;
  margin: 0;
  display: grid;
  align-content: start;
  justify-items: center;
  grid-auto-flow: row;
  padding-top: 3rem;
}

</style>