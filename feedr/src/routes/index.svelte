<script>

import { onMount } from 'svelte';

const getCaterers = async () => {
  let url = "http://localhost:4000/caterers";
  let reqParams = { method: 'GET' }
	await fetch(url, reqParams)
	  .then(response => {
			console.log(response)
		})
}

onMount(() => {
	getCaterers();
})

</script>

<svelte:head>
	<title>Sapper project template</title>
</svelte:head>

<main>

  <h1>Please log in to continue!</h1>

</main>

<style>

main {
  width: 100vw;
  height: 100%;
  min-height: 100vh;
  background-image: url('/images/HomePageSplash.jpg');
  background-position: top left;
  margin: 0;
  display: grid;
  background-size: cover;
  background-repeat: no-repeat;
  color: #fdfdfd;
  border-bottom-left-radius: 40%;
  border-bottom-right-radius: 40%;
  align-content: center;
  justify-items: center;
}

h1 {
  color: #000000;
  padding: 20px;
  border-radius: 5px;
  background-color: rgba(235,235,235,0.7);
  box-shadow: 0 0 1px -3px rgba(255,255,255,0.9)
}

</style>