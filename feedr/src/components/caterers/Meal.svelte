<script>

export let meal;

</script>

<div class="meal">
  <div class="cover_image" style="background-image: url('http://localhost:3000/uploads/{meal.cover_image}')"></div>
  <h3>{meal.name}</h3>
  <p>{meal.description}</p>
</div>

<style>

h3 {
  margin: 10px;
  line-height: 1.2rem;
  vertical-align: bottom;
  font-weight: bold;
}

p {
  margin: 0;
  padding: 0 10px 10px 10px;
  font-size: 0.9rem;
  color: rgb(35,35,35);
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
}

</style>