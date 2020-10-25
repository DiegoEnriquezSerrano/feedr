<script context="module">

	export async function preload(page, session) {
		const { id } = page.params;
		const res = await this.fetch(`http://localhost:4000/caterers/${id}`);
		const caterer = await res.json();
		return { caterer };
  }

</script>

<script>

  import Meal from '../../components/caterers/Meal.svelte';
  import { onMount } from 'svelte';

  export let caterer;

  let meals = [];

  $: meals;

  onMount(async () => {
    if (caterer.error) {
      return;
    } else {
      const req = await fetch(`http://localhost:4000/meals?caterer=${caterer.id}`);
      meals = await req.json();
    }
  });

</script>

<svelte:head>
	<title>Feedr | {caterer.caterer_business_name}</title>
</svelte:head>

<main>
  {#if !caterer.error}
    <section
      class="hero"
      style="background-image: url('http://localhost:3000/uploads/{caterer.caterer_business_cover_image}')">
    </section>

    <section class="meals">
      {#each meals as meal}
        <Meal {meal} />
      {/each}
    </section>
  {/if}
</main>

<style>

main {
  padding-top: 3em;
}

.hero {
  height: 200px;
  background-size: cover;
  background-position: center;
}

.meals {
  max-width: 800px;
}

</style>