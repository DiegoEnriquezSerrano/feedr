<script>

  import Caterer from './Caterer.svelte';

  export let caterers;
  
</script>

<section class="caterers">
  {#each caterers as caterer}
    <Caterer {caterer} />
  {/each}
</section>

<style>

:global(nav) {
  background-color: #e09f3e;
  background-image: linear-gradient(to top, rgb(224, 159, 62), rgba(224,190,140,0.6));
}

.caterers {
  display: grid;
  width: 100%;
  grid-auto-flow: row;
  grid-gap: 10px;
  padding: 10px;
  max-width: 1000px;
}

</style>