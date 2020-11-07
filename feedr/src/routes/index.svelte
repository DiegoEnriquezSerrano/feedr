<script context="module">

import { SERVER_PORT, CLIENT_PORT} from '../javascript/functions.js';

export async function preload(page) {
  let opts = { method: 'GET', credentials: 'include' }
  const res = await this.fetch(`http://localhost:${SERVER_PORT}/`, opts);
  const user = await res.json();
  return { user }
}

</script>

<script>

import Splash from '../components/Splash.svelte';
import Home from '../components/Home.svelte';
import { onMount } from 'svelte';

export let user;

let caterers = [];

$: user;
$: caterers;

user.error ? user = undefined : user = user.user;

onMount(async () => {

  if (user == undefined) {
    return;
  } else if (user != undefined && !user.caterer_user) {
    let res = await fetch(`http://localhost:${SERVER_PORT}/caterers`, 
                  { method: 'GET', credentials: 'include' })
    caterers = await res.json();
  } else if (user.caterer_user) {
    window.location = '/caterer';
  }

})

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