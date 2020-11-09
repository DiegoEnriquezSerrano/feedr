<script context="module">

import { SERVER_PORT, CLIENT_PORT } from '../../javascript/functions.js';

export async function preload(page, session) {
  const { id } = page.params;
  const catererRes = await this.fetch(`http://localhost:${SERVER_PORT}/caterers/${id}`);
  const caterer = await catererRes.json();
  const currentOrderRes = await this.fetch(`http://localhost:${SERVER_PORT}/current_order`, { credentials: 'include' });
  const currentOrder = await currentOrderRes.json();
  return { caterer, currentOrder };
}

</script>

<script>

  import Meal from '../../components/caterers/Meal.svelte';

  export let caterer;
  export let currentOrder;

  let mealsInBag;
  let meals = caterer.meals.map(m => {
    if (mealsInBag = currentOrder.order_meals.find(e => e.meal_id == m.id)) {
      m.in_current_order = mealsInBag.total_servings;
    } else { m.in_current_order = 0 }
    return m;
  });

</script>

<svelte:head>
	<title>Feedr | {caterer.caterer_business_name}</title>
</svelte:head>

<main>
  {#if !caterer.error}
    <section
      class="hero"
      style="background-image: url('http://localhost:{CLIENT_PORT}/uploads/{caterer.caterer_business_cover_image}')">
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
  display: grid;
  justify-items: center;
}

.hero {
  height: 200px;
  background-size: cover;
  background-position: center;
  width: 100vw;
}

.meals {
  max-width: 800px;
}

</style>