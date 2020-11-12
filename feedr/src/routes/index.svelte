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

  import Splash from '../components/Splash.svelte';
  import Home from '../components/Home.svelte';
  import { onMount } from 'svelte';

  export let user;

  let caterers = [];

  if (user) user = user.user;

  onMount(async () => {
    if (user && !user.caterer_user) {
      let opts = { method: 'GET', credentials: 'include' };
      let res = await fetch(`http://localhost:${SERVER_PORT}/caterers`, opts);
      caterers = await res.json();
    } else if (user && user.caterer_user) {
      window.location = '/caterer';
    };
  });

</script>

<svelte:head>
	<title>Feedr</title>
</svelte:head>

<main>
  {#if user && user.caterer_user == false}
    <Home {user} {caterers} />
  {:else}
    <Splash />
  {/if}
</main>

<style>

main {
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