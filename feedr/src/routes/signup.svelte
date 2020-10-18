<script>

import Authentication from '../components/Authentication.svelte';

</script>

<svelte:head>
	<title>Feedr | Signup</title>
</svelte:head>

<main>
  <Authentication page={'signup'} />
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

</style>