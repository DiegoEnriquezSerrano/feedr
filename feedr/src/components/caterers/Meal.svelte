<script>

  import { onMount } from 'svelte';
  import { SERVER_PORT, CLIENT_PORT } from '../../javascript/functions.js';

  export let meal;

  let mealQuantity;
  let mealId;
  let inBag;

  $: mealQuantity;

  let addMealToOrder = async () => {

    let url = `http://localhost:${SERVER_PORT}/order_meals`;
    let body = {
      meal_id: mealId.value,
      total_servings: mealQuantity
    };
    let params = {
      method: 'POST',
      credentials: 'include',
      body: JSON.stringify(body),
      headers: { "Content-Type": "application/json" }
    };
    const req = await fetch(url, params);
  }

  onMount(() => {
    meal.in_current_order > 0 ? mealQuantity = meal.in_current_order : mealQuantity = null;
  });

</script>

<div class="meal">
  <div class="cover_image" style="background-image: url('http://localhost:{CLIENT_PORT}/uploads/{meal.cover_image}')"></div>
  <h3>{meal.name}</h3>
  <p>{meal.description}</p>
  <div class="meal_actions">
    <input type="hidden" value="{meal.id}" bind:this={mealId}>
    <input
      type="number"
      placeholder="Order minimum: {meal.servings_minimum}"
      min={meal.servings_minimum}
      bind:value={mealQuantity}>
    <button class="button primary" on:click={addMealToOrder}>
      {#if mealQuantity == meal.in_current_order && meal.in_current_order !== 0}
        Current order
      {:else if meal.in_current_order < meal.servings_minimum}
        Add to order
      {:else if mealQuantity !== meal.in_current_order}
        Update order
      {/if}
    </button>
  </div>
</div>

<style>

h3 {
  margin: 10px;
  line-height: 1.2rem;
  vertical-align: bottom;
  font-weight: bold;
  grid-area: mn;
}

p {
  margin: 0;
  padding: 0 10px 10px 10px;
  font-size: 0.9rem;
  color: rgb(35,35,35);
  grid-area: md;
}

.meal {
  display: block;
  margin: 10px;
  box-shadow: 0 1px 4px -2px rgb(10,10,10);
  border-radius: 5px;
  padding: 0;
  background-color: white;
  overflow: hidden;
}

.cover_image {
  height: 130px;
  background-size: cover;
  background-position: center;
  grid-area: ci;
}

.meal_actions {
  padding: 10px;
  text-align: center;
  width: 100%;
  grid-area: ma;
}

.button.primary {
  font-size: 0.8rem;
}

@media(min-width: 600px) {
  .meal  {
    display: grid;
    grid-template-areas: 
      'ci  mn  mn'
      'ci  md  md'
      'ci  ma  ma';
    grid-template-columns: 33% 33% 33%;
  }

  .cover_image {
    height: 100%;
  }
}

</style>