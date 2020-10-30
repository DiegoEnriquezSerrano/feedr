<script context="module">

export async function preload(page) {
  let opts = { method: 'GET', credentials: 'include' }
  const res = await this.fetch('http://localhost:4000/new_order', opts);
  const new_order = await res.json();
  return { new_order }
}

</script>

<script>

  import OrderMeal from '../../components/order/OrderMeal.svelte'

  export let new_order
  console.log(new_order)
</script>

<main>
  {#each new_order as order_meal}
    <OrderMeal {order_meal} />
  {/each}
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
</style>