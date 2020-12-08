<script>

  import currentAddressStore from '../../stores/userStore.js';
  export let addresses;

</script>

  <section class="saved-addresses">
    {#each addresses as address}
      <p
        class:current={$currentAddressStore.address == address.address}
        class="address ">
        {address.name}<br>
        <span>{address.address}</span>
      </p>
    {/each}
  </section>