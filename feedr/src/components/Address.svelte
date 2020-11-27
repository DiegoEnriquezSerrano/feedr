<script>
  
  import DropoffAddress from './addresses/DropoffAddress.svelte';
  import AddressSelector from './addresses/AddressSelector.svelte';
  import { createEventDispatcher } from 'svelte';

  export let currentAddress;
  export let addresses;

  let selectorExpander = false;
  let customerAddresses = addresses;

  $: customerAddresses;
  $: currentAddress;

  let dispatch = createEventDispatcher();
  
  let toggleExpander = () => {
    selectorExpander == false ? selectorExpander = true : selectorExpander = false;
  }

  let updateCurrentAddress = (obj) => {
    dispatch('updateCurrentAddress', obj.detail);
  }

</script>

<div class="current_address">
  <DropoffAddress {currentAddress} on:toggleExpander={toggleExpander} />
  {#if selectorExpander}
    <AddressSelector addresses={customerAddresses} {currentAddress} on:newCurrentAddress={updateCurrentAddress} />
  {/if}
</div>

<style>

.current_address {
  display: grid;
  width: 100vw;
  padding: 0;
  box-shadow: 0 1px 5px -1px rgba(25,25,25,0.3);
  margin-top: 3rem;
  background: #fafafa;
  position: fixed;
  font-size: 0.8rem;
}

</style>