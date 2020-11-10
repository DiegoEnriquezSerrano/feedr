<script>

  import { onMount } from 'svelte';
  import { SERVER_PORT } from '../javascript/functions.js';

  export let meal;

  let mealQuantity;
  let mealId;

  $: mealQuantity;

  meal.in_current_order > 0 ? mealQuantity = meal.in_current_order : mealQuantity = null;

  let increment = () => {
    if (mealQuantity < meal.servings_minimum) mealQuantity = meal.servings_minimum
    else if (mealQuantity < 9999) mealQuantity = mealQuantity + 1
    else mealQuantity = 9999;
  };

  let decrement = () => {
    mealQuantity > meal.servings_minimum ? mealQuantity = Number(mealQuantity) - 1 : mealQuantity = meal.servings_minimum;
  };

  let addMealToOrder = async () => {
    const req = await fetch(`http://localhost:${SERVER_PORT}/order_meals`, {
      method: 'POST',
      credentials: 'include',
      body: JSON.stringify({ meal_id: mealId.value, total_servings: mealQuantity }),
      headers: { "Content-Type": "application/json" }
    });
  };

</script>

<div class="meal_actions">
  <input type="hidden" value="{meal.id}" bind:this={mealId}>
  <div class="order-widget">
    <div class="dialer">
      <button on:click={increment}>+</button>
      <button on:click={decrement}>–</button>
    </div>
    <input
      type="number"
      placeholder="{meal.servings_minimum}"
      min="{meal.servings_minimum}"
      size="4" max="9999"
      bind:value={mealQuantity}>
    <span>
      ${(mealQuantity*Number(meal.price_minimum/meal.servings_minimum)).toFixed(2)}
    </span>
  </div>
  <button class="button primary" on:click={addMealToOrder}>
    {#if mealQuantity == meal.in_current_order && meal.in_current_order !== 0}
      Current order
    {:else if meal.in_current_order < meal.servings_minimum}
      Add to order
    {:else if mealQuantity !== meal.in_current_order}
      Update order
    {/if}
  </button>
  <button class="button delete">  
  </button>
</div>

<style>

.meal_actions {
  padding: 10px;
  text-align: center;
  width: 100%;
  grid-area: ma;
  display: grid;
  grid-auto-flow: column;
  grid-gap: 3px;
  grid-template-columns: 4fr 2fr 1fr;
}

.order-widget {
  display: grid;
  grid-auto-flow: column;
  align-items: center;
  grid-template-columns: 2.0rem minmax(2.5rem,2.5rem) 1fr;
  border: solid thin lightgray;
  background: rgb(235,235,235);
  align-items: stretch;
  border-radius: 3px;
}

.dialer {
  display: grid;
  grid-auto-flow: row;
  align-content: space-evenly;
}

.dialer button {
  border: solid thin lightgray;
  background: white;
  font-weight: bold;
  border-radius: 3px;
  overflow: hidden;
  background-image: linear-gradient(to top, rgb(240,240,240), rgb(255,255,255));
}

input[type="number"] {
  display: inline-block;
  appearance: textfield;
  width: 100%;
  height: 100%;
  font-family: inherit;
  font-size: 0.8rem;
  border-radius: 2px;
  border: 1px solid rgb(235,235,235);
  box-shadow: inset 1px 1px 2px -1px rgb(5,5,5);
  text-align: right;
  border-top-width: 5px;
  border-bottom-width: 5px;
}

.order-widget > span {
  font-size: 0.8rem;
  min-width: 70px;
  display: grid;
  align-content: center;
}

.button.primary {
  font-size: 0.8rem;
  display: grid;
  align-content: center;
}

.button.delete {
  background-color: #f16758;
  background-image: url('/icons/trash_can.svg');
  background-size: 55%;
  background-position: center;
  background-repeat: no-repeat;
  min-width: 40px;
}

@media(min-width: 375px) {
  .meal_actions {
    grid-template-columns: 4fr 3fr 1fr;
  }
}
</style>