<script context="module">

import { SERVER_PORT, CLIENT_PORT } from '../javascript/functions.js';

export async function preload(page) {
  let user = false;
  const res = await this.fetch(`http://localhost:${SERVER_PORT}/`, { method: 'GET', credentials: 'include' });
  if (res.status == 200) user = await res.json();
  return { user };
};

</script>

<script>

  import currentAddressStore from '../stores/userStore.js';
  import Splash from '../components/Splash.svelte';
  import Home from '../components/Home.svelte';
  import Address from '../components/Address.svelte';
  import { onMount } from 'svelte';

  export let user;

  let caterers = [];
  let addresses = [];

  if (user) {
    user = user.user;
    addresses = user.customer_addresses;
    $currentAddressStore = user.customer_addresses.find(ca => ca.default_address == true);
  }

  let updateCurrentAddress = async (obj) => {
    let urlParams = "";
    if ($currentAddressStore != {}) urlParams = `?lat=${$currentAddressStore.latitude}&lon=${$currentAddressStore.longitude}`;
    let url = `http://localhost:${SERVER_PORT}/caterers${urlParams}`;
    let opts = { method: 'GET', credentials: 'include' };
    let res = await fetch(url, opts);
    caterers = await res.json();
  }

  onMount(async () => {
    if (user && !user.caterer_user) {
      let urlParams = "";
      if ($currentAddressStore != {}) urlParams = `?lat=${$currentAddressStore.latitude}&lon=${$currentAddressStore.longitude}`;
      let url = `http://localhost:${SERVER_PORT}/caterers${urlParams}`;
      let opts = { method: 'GET', credentials: 'include' };
      let res = await fetch(url, opts);
      caterers = await res.json();
    } else if (user && user.caterer_user) {
      window.location = '/caterer';
    };
  });

</script>

<svelte:head>
	<title>Feedr</title>
</svelte:head>

{#if user && user.caterer_user == false}
  <Address {addresses} on:updateCurrentAddress={updateCurrentAddress} />
{/if}
<main>
  {#if user && user.caterer_user == false}
    <Home {caterers} />
  {:else}
    <Splash />
  {/if}
</main>

<style>

main {
  padding-top: 5.3rem;
  width: 100vw;
  height: 100%;
  min-height: 100vh;
  margin: 0;
  display: grid;
  color: #fdfdfd;
  align-content: start;
  justify-items: center;
  grid-auto-flow: row;
}

</style>