<script>

  import { SERVER_PORT, CLIENT_PORT } from '../../javascript/functions.js';

  export let order_meal;

</script>

<div class="order-meal">
  <div class="cover-image" style="background-image: url('http://localhost:{CLIENT_PORT}/uploads/{order_meal.meal.cover_image}');">
  </div>
  <div class="order-meal-details">
    <a class="order-meal-name" href="/meal/{order_meal.meal.id}">{order_meal.meal.name}</a>
    <ul>
      <li>Servings: {order_meal.total_servings}</li>
      <li>Serving price: ${Number(order_meal.unit_price).toFixed(2)}</li>
      <li>Subtotal: ${Number(order_meal.subtotal).toFixed(2)}</li>
    </ul>
  </div>
</div>

<style>

.order-meal {
  display: grid;
  grid-auto-flow: column;
  grid-template-columns: minmax(30%, 300px) 60%;
  color: black;
  grid-gap: 5px;
}

.order-meal-details {
  padding: 5px;
  font-size: 0.9rem;
}

.order-meal-name {
  font-size: 1.1rem;
  font-weight: bold;
  text-decoration: none;
}

ul {
  list-style: none;
  padding: 0;
  margin: 5px 0;
}

li {
  color: rgb(75,75,75);
}

.cover-image {
  background-position: center;
  background-size: cover;
}

</style>