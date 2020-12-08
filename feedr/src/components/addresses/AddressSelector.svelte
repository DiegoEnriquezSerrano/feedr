<script>

  import { createEventDispatcher, onMount } from 'svelte';
  import autocomplete from '../../javascript/autocomplete.js';
  import currentAddressStore from '../../stores/userStore.js';
  import AddressSearch from './AddressSearch.svelte';

  export let addresses;

  let addressInput;
  let usAddress;
  let latInput;
  let lonInput;

  let dispatch = createEventDispatcher();

  let newCurrentAddress = (obj) => {
    currentAddressStore.update(address => { return obj.detail });
    dispatch('newCurrentAddress', obj)
  }

  let close = () => {
    dispatch('toggleExpander');
  }

</script>

<div class="modal" on:click|self={close}>
  <div class="container">
    <AddressSearch on:newCurrentAddress={newCurrentAddress} />
    <div class="saved_addresses">
      <div class="saved_addresses_heading">
        <div class="spacer"></div>
        <p>Saved Addresses</p>
        <div class="spacer"></div>
      </div>
      {#each addresses as address}
        <p
          class:current={$currentAddressStore.address == address.address}
          class="address "
          on:click={newCurrentAddress({ detail: address })}>
          {address.name}<br>
          <span>{address.address}</span>
        </p>
      {/each}
    </div><!--saved_addresses-->
  </div><!--container-->
</div><!--modal-->

<style>

.modal {
  position: fixed;
  height: calc(100vh - 3rem);
  width: 100%;
  background: transparent;
  top: 3rem;
  left: 0;
}

.container {
  display: grid;
  width: 100%;
  position: absolute;
  top: 0;
  left: 0;
  background: #fafafa;
  box-shadow: 0 5px 10px -4px;
}

span {
  font-size: 0.72rem;
  color: rgb(56,56,56);
  text-shadow: 1px 1px 1px white;
}

.current {
  background: #eaeaea;
}

p.address {
  padding: 10px;
  margin: 0;
}

p.address:hover {
  cursor: pointer;
}

.saved_addresses_heading {
  display: grid;
  grid-auto-flow: column;
  align-items: center;
  justify-content: center;
  justify-items: center;
  grid-template-columns: 1fr 2fr 1fr;
  margin: 10px;
}

.spacer {
  border: thin solid #888;
  min-width: 100%;
  margin: 10px;
}

</style>