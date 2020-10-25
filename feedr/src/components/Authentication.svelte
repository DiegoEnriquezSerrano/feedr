<script>

import { onMount } from 'svelte';
import requests from '../javascript/requests.js';

export let page;

let firstName;
let lastName;
let email;
let password;
let passwordConfirmation;
let catererBusinessName;
let catererBusinessAddress;
let catererBusinessCity;
let catererBusinessState;
let zipCode;
let body = {};

let catererSignup = false;

let toggleCatererSignup = (e) => {
  catererSignup == false ? catererSignup = true : catererSignup = false;
}

let authenticate = (page) => {
  if (page === 'login') {
    body = { email, password }

  } else if (page === 'signup') {
    body = {
      user: {
        first_name: firstName,
        last_name: lastName,
        email,
        password,
        password_confirmation: passwordConfirmation,
        caterer_user: catererSignup,
        caterer_business_name: catererBusinessName ? catererBusinessName.value : null,
        caterer_business_address: catererBusinessAddress ? catererBusinessAddress.value : null,
        caterer_business_city: catererBusinessCity ? catererBusinessCity.value : null,
        caterer_business_state: catererBusinessState ? catererBusinessState.value : null,
        zip_code: zipCode ? zipCode.value : null
      }
    }
  }

  requests.authenticate(page, body);
}

</script>

  <form class="authentication-form" action="http://localhost:4000/{page}" method="POST">
    {#if page === 'signup'}
      <h3><b>Create your account</b></h3>
      <!-- <button class="button secondary" on:click|preventDefault={toggleCatererSignup}>
        {#if catererSignup == false}
          Register as a Caterer
        {:else}
          Register as Customer
        {/if}
      </button> -->
      <div class="fields_pair">
        <div class="field">
          <label for="first_name">First name</label>
          <input type="text" name="first_name" bind:value={firstName}>
        </div>
        <div class="field">
          <label for="last_name">Last name</label>
          <input type="text" name="last_name" bind:value={lastName}>
        </div>
      </div>
    {:else}
      <h3><b>Log in</b></h3>
    {/if}
    <div class="field">
      <label for="email">Email</label>
      <input type="text" name="email" bind:value={email}>
    </div>
    <div class="field">
      <label for="password">Password</label>
      <input type="password" name="password" bind:value={password}>
    </div>
    {#if page === 'signup'}
      <div class="field">
        <label for="password">Password confirmation</label>
        <input type="password" name="password_confirmation" bind:value={passwordConfirmation}>
      </div>
      <input type="hidden" name="caterer_user" bind:value={catererSignup}/>
      {#if catererSignup == true}
        <div class="field">
          <label for="business_name">Business name</label>
          <input type="text" name="business_name" bind:this={catererBusinessName}>
        </div>
        <div class="field">
          <label for="address">Business address</label>
          <input type="text" name="address" bind:this={catererBusinessAddress}>
        </div>
        <div class="fields_trio">
          <div class="field">
            <label for="city">City</label>
            <input type="text" name="city" bind:this={catererBusinessCity}>
          </div>
          <div class="field">
            <label for="state">State</label>
            <input type="text" name="state" bind:this={catererBusinessState}>
          </div>
          <div class="field">
            <label for="zip">Zip Code</label>
            <input type="text" name="zip" bind:this={zipCode}>
          </div>
        </div>
      {/if}
    {/if}
    <button type="submit" class="button primary" on:click|preventDefault={authenticate(page)}>
      {#if page == 'signup'}
        Create account
      {:else}
        Log in
      {/if}
    </button>
  </form>


<style>

.authentication-form {
  display: grid;
  background-color: #ffffff;
  color: #020202;
  align-content: center;
  align-items: center;
  justify-content: stretch;
  max-width: 500px;
  width: calc(100vw - 20px);
  margin-top: 15px;
  border-radius: 5px;
  box-shadow: 0 1px 7px -5px rgb(10,10,10);
  padding: 30px;
  grid-gap: 15px;
}

.field {
  grid-template-columns: 1fr;
  display: grid;
  grid-auto-flow: row;
  grid-gap: 5px;
}

.fields_pair {
  grid-gap: 10px;
  display: grid;
  grid-auto-flow: row;
}

.fields_trio {
  grid-template-columns: 1fr 1fr 1fr;
}

label {
  font-size: 0.9rem;
  font-weight: normal;
  display: block;
  color: #707070;
}

input {
  padding: 5px;
  display: block;
  width: 100%
}

/* .button.secondary {
  justify-self: center;
} */

@media(min-width: 500px) {

  .fields_trio,
  .fields_pair {
    width: 100%;
    grid-gap: 10px;
    grid-auto-flow: column;
  }

}

</style>