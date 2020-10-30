<script>

export let order_meal;

</script>

<div class="order-meal">
  <h1>{order_meal.meal.name}</h1>
  <ul>
    <li>Servings: {order_meal.total_servings}</li>
    <li>Price per serving: ${order_meal.unit_price}</li>
    <li>Subtotal: ${order_meal.subtotal}</li>
  </ul>
</div>

<style>

.order-meal {
  display: block;
  color: black;
}

li {
  color: black;
}

</style>