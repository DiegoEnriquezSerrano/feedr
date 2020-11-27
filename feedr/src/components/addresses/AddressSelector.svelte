<script>

  import { createEventDispatcher } from 'svelte';

  export let addresses;
  export let currentAddress;

  let dispatch = createEventDispatcher();

  let newCurrentAddress = (obj) => {
    dispatch('newCurrentAddress', obj)
  }

</script>

<div class="container">
  {#each addresses as address}
    <p
      class:current={currentAddress.address == address.address}
      class="address "
      on:click={newCurrentAddress(address)}>
      {address.name}<br>
      <span>{address.address}</span>
    </p>
  {/each}
</div>

<style>

.container {
  display: grid;
  width: calc(100vw - 40px);
  position: absolute;
  top: 25%;
  left: 5%;
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

</style>