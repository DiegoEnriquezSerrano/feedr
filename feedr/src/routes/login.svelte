<script>

  import Authentication from '../components/Authentication.svelte';

</script>

<svelte:head>
	<title>Feedr | Login</title>
</svelte:head>

<main>
  <Authentication page={'login'} />
</main>

<style>

main {
  position: absolute;
  top: 0;
  margin: 0;
  display: grid;
  align-content: baseline;
  align-items: center;
  justify-items: center;
  width: 100vw;
  height: 100%;
  min-height: 100vh;
  padding-top: 3rem;
  overflow: auto;
  color: #fdfdfd;
}

</style>