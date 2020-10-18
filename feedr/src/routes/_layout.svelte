<script context="module">

export async function preload(page) {
  let opts = { method: 'GET', credentials: 'include' }
  const res = await this.fetch('http://localhost:4000/', opts);
  const user = await res.json();

  return { user }
}

</script>

<script>

	import Nav from '../components/Nav.svelte';

	export let segment;
	export let user;
	$: user;

</script>

<Nav {segment} {user}/>

<slot></slot>