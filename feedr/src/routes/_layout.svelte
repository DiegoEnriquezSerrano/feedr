<script context="module">

import { SERVER_PORT, CLIENT_PORT } from '../javascript/functions.js';

export async function preload(page) {
  let user = false;
  const res = await this.fetch(`http://localhost:${SERVER_PORT}/`, { method: 'GET', credentials: 'include' });
  if (res.status == 200) user = await res.json();
  return { user }
}

</script>

<script>

  import { onMount } from 'svelte';
	import Nav from '../components/Nav.svelte';

	export let segment;
	export let user;
  $: user;

  const mapScriptTag = "<script defer src=" + `https://maps.googleapis.com/maps/api/js?key=AIzaSyBpV1bos2tza-fAO-YMHANWI2hymGzy0ko&libraries=places` + ">" + "<" + "/script>";

  onMount(() => {
    user ? localStorage.setItem('feedrUser', JSON.stringify(user)) : localStorage.removeItem('feedrUser');
  });

</script>

<Nav {segment} {user}/>

<slot></slot>

{@html mapScriptTag}