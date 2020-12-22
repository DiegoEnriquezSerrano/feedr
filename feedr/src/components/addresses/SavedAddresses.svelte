<script>

  import currentAddressStore from '../../stores/userStore.js';
  import EditAddressModal from './EditAddressModal.svelte';
  import requests from '../../javascript/requests.js';

  export let addresses;

  let showModal = false;
  let updateAddress;
  let savedAddresses;

  let openModal = (obj) => {
    obj ? updateAddress = obj : updateAddress = false;
    showModal = true;
  };

  let closeModal = (obj) => {
    addresses = obj.detail || addresses;
    showModal = false;
  };

  let newAddress = (e) => { openModal(false) };

  let editAddress = (e) => {
    let checkedAddress = addresses[Array.from(savedAddresses.childNodes).findIndex(elem => elem.children.address.checked == true)];
    let splitAddress = checkedAddress.address.split(',').map((i) => { return i.trim() });
    openModal({
      streetAddress: splitAddress[0],
      city: splitAddress[1],
      state: splitAddress[2],
      zip: splitAddress[3],
      id: checkedAddress.id,
      name: checkedAddress.name
    });
  };

  let setDefault = async (e) => {
    let checkedAddress = addresses[Array.from(savedAddresses.childNodes).findIndex(elem => elem.children.address.checked == true)];
    let response = await requests.updateDefaultAddress(checkedAddress);
    console.log(response)
  }

  let deleteAddress = async (e) => {
    let checkedAddress = addresses[Array.from(savedAddresses.childNodes).findIndex(elem => elem.children.address.checked == true)];
    let response = await requests.deleteAddress(checkedAddress);
    console.log(response)
  }

</script>

  <section class="saved-addresses">
    <p>
      <button class="primary button" on:click={newAddress}>Add new address</button>
    </p>
    {#if addresses.length > 0}
      <div class="address-actions">
        <span class="table-label">Saved addresses</span>
        <button class="pill primary" on:click={setDefault}>Make Default</button>
        <button class="pill secondary" on:click={editAddress}>Edit</button>
        <button class="pill danger" on:click={deleteAddress}>Delete</button>
      </div>
      <form bind:this={savedAddresses}>
        {#each addresses as address}
          <label for="{address.id}">
            <input type="radio" name="address" id="{address.id}" value="{address.id}" checked={address.default_address == true}>
            <div class:current={$currentAddressStore.address == address.address} class="address ">
              <b class="object_name">{address.name}</b>
              <span class="object_detail">{address.address}</span>
            </div>
          </label>
        {/each}
      </form>
    {/if}
  </section>
  {#if showModal}
    <EditAddressModal address={updateAddress} on:close={closeModal} />
  {/if}

<style>

.saved-addresses {
  display: grid;
  grid-auto-flow: row;
  width: calc(100vw - 20px);
}

.address-actions {
  display: grid;
  grid-auto-flow: column;
  justify-items: end;
  grid-gap: 2px;
}

.address-actions button {
  padding: 5px 10px;
  border-radius: 10px;
  margin-bottom: 5px;
  border: 0;
  box-shadow: 0 0 3px -1px gray;
  font-size: 0.75rem;
}

form {
  border: solid rgb(175,175,175);
  border-width: 0 1px 1px 1px;
  border-radius: 10px;
  background: #fafafa;
  box-shadow: 0px 1px 5px -1px rgba(25,25,25,0.3);
  overflow: hidden;
}

.table-label {
  font-size: 0.71rem;
  align-self: end;
  justify-self: start;
  color: black;
}

label {
  display: grid;
  grid-auto-flow: column;
  grid-template-columns: 1.5rem 1fr;
  border: solid rgb(175,175,175);
  border-width: 1px 0 0 0;
  padding-left: 5px;
}

.address {
  display: grid;
  grid-auto-flow: row;
  padding: 10px 10px 10px 5px;
}

.object_name {
  font-size: 0.9rem;
}

.object_detail {
  font-size: 0.75rem;
  letter-spacing: -0.02rem;
}

input[type="radio"] {
  margin: 0;
}

.saved-addresses p {
  display: grid;
  margin: 25px;
}

.primary.button {
  align-self: center;
  justify-self: center;
  box-shadow: 0 0 3px -1px gray;
}

</style>