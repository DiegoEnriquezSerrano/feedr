<script context="module">

import { SERVER_PORT, CLIENT_PORT } from '../../javascript/functions.js';

export async function preload(page) {
  let opts = { method: 'GET', credentials: 'include' }
  const res = await this.fetch(`http://localhost:${SERVER_PORT}/new_order`, opts);
  const new_order = await res.json();
  return { new_order }
}

</script>

<script>

  import OrderMeal from '../../components/order/OrderMeal.svelte';
  import requests from '../../javascript/requests.js'; 

  export let new_order;

</script>

<svelte:head>
	<title>Feedr | New Order</title>
</svelte:head>

<main>
  <section class="new-order">
    {#each new_order.order_meals as order_meal}
      <OrderMeal {order_meal} />
    {/each}
    {#if new_order.order_meals.length >= 1}
      <div class="new-order-details">
        Subtotal: ${Number(new_order.subtotal).toFixed(2)}
      </div>
    {:else}
      <div class="empty-order-message">
        <h3>Your current order is empty!</h3>
        <p></p>
      </div>
    {/if}
    <button class="button primary" on:click={requests.submitOrder} disabled={new_order.order_meals.length < 1}>
      Submit
    </button>
  </section>
</main>

<style>

main {
  width: 100vw;
  height: 100%;
  min-height: 100vh;
  margin: 0;
  display: grid;
  color: #fdfdfd;
  align-content: start;
  justify-items: center;
  grid-auto-flow: row;
  padding-top: 3.3em;
}

.new-order {
  color: black;
  box-shadow: 0px 1px 5px -1px rgba(25,25,25,0.3);
  border-radius: 5px;
  background-color: #fafafa;
  padding: 10px 5px;
  overflow: hidden;
  display: grid;
  grid-gap: 15px;
}

.new-order-details {
  text-align: center;
}

.button[disabled] {
  opacity: 0.5;
}

@media(min-width: 600px) {
  .new-order {
    margin-top: 20px;
    padding: 40px;
  }
}

</style>