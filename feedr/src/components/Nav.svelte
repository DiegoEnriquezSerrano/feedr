<script>

  import { SERVER_PORT, CLIENT_PORT } from '../javascript/functions.js';

  export let segment;
  export let user;

  let menuOpen = false;

  let toggleMenu = () => { menuOpen == false ? menuOpen = true : menuOpen = false };

  let close = () => { menuOpen = false };

  let logout = async () => {
    let req = await fetch(`http://localhost:${SERVER_PORT}/logout`, { method: 'GET', credentials: 'include' });
    let data = await req.json();
    if (data.message && data.message === "Logout successful") {
      window.location = "/";
    }
  }

  let getSearch = async () => {
    let req = await fetch(`http://localhost:${SERVER_PORT}/search`, { method: 'GET', credentials: 'include' });
    let data = await req.json();
    console.log(data);
  }

</script>

<nav class:home={segment == undefined && !user}>
  <div class="brand">
    <a href="/">Feedr</a>
  </div>
	<button class="expander " on:click={toggleMenu}>
		<svg class="icon" width="21px" height="15px" viewBox="0 0 21 15" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
			<title>Menu</title>
			<g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
				<g transform="translate(-179.000000, -322.000000)">
					<g transform="translate(56.000000, 160.000000)">
						<path d="M124.575,174 C123.7056,174 123,174.672 123,175.5 C123,176.328 123.7056,177 124.575,177 C125.4444,177 126.15,176.328 126.15,175.5 C126.15,174.672 125.4444,174 124.575,174 L124.575,174 Z M128.25,177 L144,177 L144,175 L128.25,175 L128.25,177 Z M124.575,168 C123.7056,168 123,168.672 123,169.5 C123,170.328 123.7056,171 124.575,171 C125.4444,171 126.15,170.328 126.15,169.5 C126.15,168.672 125.4444,168 124.575,168 L124.575,168 Z M128.25,171 L144,171 L144,169 L128.25,169 L128.25,171 Z M124.575,162 C123.7056,162 123,162.672 123,163.5 C123,164.328 123.7056,165 124.575,165 C125.4444,165 126.15,164.328 126.15,163.5 C126.15,162.672 125.4444,162 124.575,162 L124.575,162 Z M128.25,165 L144,165 L144,163 L128.25,163 L128.25,165 Z"></path>
					</g>
				</g>
			</g>
		</svg>
  </button>
  <ul class:open={menuOpen == true}>
    {#if !user}
      <li><a href="/signup" on:click={close}>Sign Up</a></li>
      <li><a href="/login" on:click={close}>Login</a></li>
    {/if}
    <li><a href="/search" on:click|preventDefault={getSearch}>Search</a></li>
    {#if user}
      <li>
        <a href="/order/new" on:click={close}>
          <img class="icon" src="/icons/shopping_bag.svg" alt="Current Order"> Order
        </a>
      </li>
      <li>
        <a href="/logout" on:click|preventDefault={logout}>
          <img class="icon" src="/icons/logout.svg" alt="Logout"> Logout
        </a>
      </li>
    {/if}
  </ul>
</nav>

<style>

nav {
  display: grid;
  color: #ffffff;
  background-color: #e09f3e;
  background-image: linear-gradient(to top, rgb(224, 159, 62), rgba(224,190,140,0.6));
  grid-template-columns: 1fr 1fr;
  align-items: center;
  justify-items: stretch;
  justify-content: space-between;
  text-shadow: 0 0 5px rgb(0,0,0);
  font-size: 1.2rem;
  box-shadow: 0 1px 3px -1px rgb(25,25,25);
  z-index: 100;
  position: fixed;
  top: 0;
  width: 100vw;
  box-sizing: border-box;
  padding: 0 10px;
  height: 3rem;
}

.home {
	background-color: rgba(0,0,0,0.3);
	background-image: none;
	box-shadow: none;
}

ul {
  list-style: none;
  padding: 0;
  margin: 0;
  text-align: right;
  display: none;
}

ul.open {
  display: grid;
  width: 100%;
  position: absolute;
  background-color: inherit;
  top: 3rem
}

li {
  margin: 0;
  display: grid;
  align-content: center;
}

nav a {
  text-transform: none;
  text-decoration: none;
  color: #ffffff
}

button svg g {
  fill: #ffffff
}

.expander {
  display: inline-block;
  padding: 5px;
  background-color: transparent;
  border-width: 0;
  justify-self: end;
}

.icon {
  height: 100%;
  max-height: calc(3em - 30px);
}

.expander .icon {
  max-height: 100%;
}

li a {
  vertical-align: middle;
  display: grid;
  grid-auto-flow: column;
  justify-items: end;
  justify-content: end;
  align-items: center;
  height: 1.75rem;
  padding: 2px;
  text-shadow: none;
  grid-gap: 5px;
}

@media(min-width: 500px) {
  .expander {
    display: none;
  }

  nav > ul {
    display: grid;
    grid-auto-flow: column;
  }

  nav {
    grid-template-columns: 1fr 1fr;
    font-size: 1.4rem;
    height: 3.4rem;
  }
}

</style>