<script>

  import { createEventDispatcher, onMount } from 'svelte';
  import requests from '../../javascript/requests.js';
  import { SERVER_PORT, CLIENT_PORT } from '../../javascript/functions.js';

  export let address;

  console.log(address);

  let body = {};
  let streetAddress = address.streetAddress || null;
  let city = address.city || null;
  let state = address.state || null;
  let zip = address.zip || null;
  let name = address.name || null;
  let addressId = address.id || null;

  let dispatch = createEventDispatcher();

  let submit = async (e) => {
    body = {
      address: `${streetAddress}, ${city}, ${state}, ${zip}`,
      name,
      addressId
    };
    let response = await requests.editAddress(body);
    if (response.status == 200) {
      let addresses = await response.json()
      dispatch('close', addresses);
    };
  }

  let close = (e) => {
    dispatch('close', null)
  }

</script>

<div class="modal" on:click|self={close}>
  <form>
    <button on:click|preventDefault={close} class="close">
      <svg class="icon" width="15px" height="15px" viewBox="0 0 21 20" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
        <title>Clear</title>
        <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
          <g transform="translate(-419.000000, -240.000000)" fill="#59617d">
            <g transform="translate(56.000000, 160.000000)">
              <polygon points="375.0183 90 384 98.554 382.48065 100 373.5 91.446 364.5183 100 363 98.554 371.98065 90 363 81.446 364.5183 80 373.5 88.554 382.48065 80 384 81.446"></polygon>
            </g>
          </g>
        </g>
      </svg>
    </button>
    <label for="street_address">
      <span>Street Address</span>
      <input type="text" name="street_address" id="street_address" bind:value={streetAddress}>
    </label>
    <label for="city">
      <span>City</span>
      <input type="text" name="city" id="city" bind:value={city}>
    </label>
    <label for="state">
      <span>State</span>
      <input type="text" name="state" id="state" bind:value={state}>
    </label>
    <label for="zip">
      <span>Zip code</span>
      <input type="text" name="zip" id="zip" bind:value={zip}>
    </label>
    <label for="nickname">
      <span>Nickname</span>
      <input type="text" name="name" id="nickname" bind:value={name}>
    </label>
    <input type="hidden" name="id" bind:value={addressId}>
    <button class="button primary" on:click|preventDefault={submit}>
      {#if address}
        Update address
      {:else}
        Save address
      {/if}
    </button>
  </form>
</div>

<style>

.modal {
  position: fixed;
  top: 3rem;
  display: grid;
  width: 100vw;
  height: calc(100vh - 3rem);
  background: rgba(0,0,0,0.3);
  justify-content: center;
  align-content: start;
}

form {
  display: grid;
  background-color: #ffffff;
  color: #020202;
  align-items: start;
  justify-content: stretch;
  max-width: 500px;
  width: calc(100vw - 20px);
  margin-top: 15px;
  border-radius: 5px;
  box-shadow: 0 1px 7px -5px rgb(10,10,10);
  padding: 30px;
  grid-gap: 15px;
}

.close {
  justify-self: end;
  min-width: 15px;
  min-height: 15px;
  margin: -15px 0;
  padding: 5px;
  border: 0;
  background: transparent;
}

.close:hover {
  cursor: pointer;
}

label {
  display: grid;
  grid-gap: 5px;
}

label span {
  color: #707070
}

</style>