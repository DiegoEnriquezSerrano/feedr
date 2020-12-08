<script>

  import { createEventDispatcher, onMount } from 'svelte';
  import autocomplete from '../../javascript/autocomplete.js';
  import currentAddressStore from '../../stores/userStore.js';

  export let addresses;

  let addressInput;
  let usAddress;
  let latInput;
  let lonInput;

  let dispatch = createEventDispatcher();

  let newCurrentAddress = (obj) => {
    currentAddressStore.update(address => { return obj });
    dispatch('newCurrentAddress', obj)
  }

  let close = () => {
    dispatch('toggleExpander');
  }

  let clear = () => {
    addressInput.value = null;
  }

  onMount(() => {
    autocomplete(addressInput, usAddress, latInput, lonInput);
  })

</script>
<div class="modal" on:click|self={close}>
  <div class="container">
    <div class="address_search">
      <input type="text" id="address" name="location[address]" bind:this={addressInput}>
      <input type="hidden" id="us_address" name="us_address" value="" bind:this={usAddress}>
      <input type="hidden" id="lat" name="lat" value="" bind:this={latInput}>
      <input type="hidden" id="lon" name="lon" value="" bind:this={lonInput}>
      <span class="marker">
        <svg width="0" height="0" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" style="flex-shrink: 0;">
          <path fill-rule="evenodd" clip-rule="evenodd" d="M10.5257 21.3514L12 20L13.4743 21.3514C13.0955 21.7647 12.5606 22 12 22C11.4394 22 10.9045 21.7647 10.5257 21.3514ZM13.2949 18.4463C12.5464 19.4039 12 20 12 20C12 20 11.4535 19.4039 10.7051 18.4463C9.07919 16.3658 6.5 12.5792 6.5 9.49242C6.5 6.45904 8.96243 4 12 4C15.0376 4 17.5 6.45904 17.5 9.49242C17.5 12.5792 14.9208 16.3658 13.2949 18.4463ZM13.4743 21.3514C13.4743 21.3514 13.4743 21.3514 12 20C10.5257 21.3514 10.5257 21.3514 10.5257 21.3514L10.5227 21.3482L10.5177 21.3427L10.5018 21.3252L10.4474 21.2647C10.4014 21.2133 10.3363 21.1398 10.2548 21.0461C10.0919 20.8589 9.86301 20.5903 9.59004 20.2553C9.04587 19.5873 8.31764 18.6441 7.58566 17.5456C6.85705 16.4522 6.10151 15.1704 5.5227 13.8275C4.95169 12.5026 4.5 10.9984 4.5 9.49242C4.5 5.35187 7.86046 2 12 2C16.1395 2 19.5 5.35187 19.5 9.49242C19.5 10.9984 19.0483 12.5026 18.4773 13.8275C17.8985 15.1704 17.1429 16.4522 16.4143 17.5456C15.6824 18.6441 14.9541 19.5873 14.41 20.2553C14.137 20.5903 13.9081 20.8589 13.7452 21.0461C13.6637 21.1398 13.5986 21.2133 13.5526 21.2647L13.4982 21.3252L13.4823 21.3427L13.4773 21.3482L13.4743 21.3514Z" style="fill: rgb(86,86,86)"></path>
          <path fill-rule="evenodd" clip-rule="evenodd" d="M12 11C12.8284 11 13.5 10.3284 13.5 9.5C13.5 8.67157 12.8284 8 12 8C11.1716 8 10.5 8.67157 10.5 9.5C10.5 10.3284 11.1716 11 12 11ZM12 13C13.933 13 15.5 11.433 15.5 9.5C15.5 7.567 13.933 6 12 6C10.067 6 8.5 7.567 8.5 9.5C8.5 11.433 10.067 13 12 13Z" style="fill: rgb(86,86,86)"></path>
        </svg>
      </span>
      <button class="clear " on:click={clear}>
        <svg class="icon" width="21px" height="20px" viewBox="0 0 21 20" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
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
    </div><!--address_search-->
    <button
      class="button primary"
      on:click={newCurrentAddress({
        address: usAddress.value,
        latitude: Number(latInput.value),
        longitude: Number(lonInput.value)
      })}>
      Search in this area
    </button>
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
          on:click={newCurrentAddress(address)}>
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

.address_search {
  padding: 0;
}

#address {
  min-width: 100%;
  padding: 10px 45px;
  font: inherit;
  outline: 0;
  border: 0;
  line-height: inherit;
}

#address::placeholder {
  font: inherit;
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

p.address:hover,
.clear:hover {
  cursor: pointer;
}

.marker {
  left: 0;
}

.clear {
  right: 0;
  background: transparent;
  border: none;
}

.clear svg {
  padding: 2px;
}

.marker svg {
  height: inherit;
  width: 45px;
  padding: 7px;
}

.clear, .marker {
  position: absolute;
  display: grid;
  height: 37.6px;
  top: 0;
  justify-content: center;
  align-content: center;
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

.button.primary {
  justify-self: center;
  font-size: 0.8rem;
  padding: 10px;
}

</style>