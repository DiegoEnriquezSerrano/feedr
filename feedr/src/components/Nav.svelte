<script>
	export let segment;
</script>

<nav class:home={segment == undefined}>
  <div class="brand">
    <a href="/home">Feedr</a>
  </div>
  <ul>
    <li><a href="/signup">Sign Up</a></li>
    <li><a href="/sign_in">Login</a></li>
    <li>Search</li>
  </ul>
</nav>

<style>

nav {
  display: grid;
  color: #ffffff;
  background-color: #e09f3e;
  background-image: linear-gradient(to top, rgb(224, 159, 62), rgba(224,190,140,0.6));
  grid-template-columns: 150px 1fr;
  align-items: center;
  justify-items: stretch;
  text-shadow: 0 0 5px rgb(0,0,0);
  font-size: 1.2rem;
  box-shadow: 0 1px 3px -1px rgb(25,25,25);
  z-index: 100;
  position: fixed;
  top: 0;
  width: 100vw;
}

.home {
	background-color: transparent;
	background-image: none;
	box-shadow: none;
}

.brand {
  padding: 15px;
}

ul {
  list-style: none;
  padding: 0;
  margin: 0;
  text-align: right;
}

li {
  display: inline-block;
  padding: 15px;
  margin: 0;
}

nav a {
  text-transform: none;
  text-decoration: none;
  color: #ffffff
}

</style>