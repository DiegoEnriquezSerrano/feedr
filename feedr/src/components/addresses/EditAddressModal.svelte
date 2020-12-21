<script>

  import { createEventDispatcher, onMount } from 'svelte';

  export let address;

  console.log(address);

  let streetAddress = address.streetAddress || null;
  let city = address.city || null;
  let state = address.state || null;
  let zip = address.zip || null;
  let addressId = address.id || null;

</script>

<div class="modal">
  <form>
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
    <input type="hidden" name="id" bind:value={addressId}>
    <button type="submit" class="button primary">
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

label {
  display: grid;
  grid-gap: 5px;
}

label span {
  color: #707070
}

</style>