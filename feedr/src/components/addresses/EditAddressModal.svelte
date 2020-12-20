<script>

  import { createEventDispatcher, onMount } from 'svelte';

  export let address;

  let addressInput;
  let usAddress;
  let latInput;
  let lonInput;

  console.log(address);

</script>

<div class="modal">
  <form>
    <label for="street_address">
      <input type="text" name="street_address" id="street_address">
    </label>
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
}

</style>