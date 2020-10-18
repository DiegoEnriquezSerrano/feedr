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
        first_name,
        last_name,
        email,
        password,
        password_confirmation: passwordConfirmation.value,
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

  <form class="authentication-form">
    {#if page === 'signup'}
      <button class="primary" on:click|preventDefault={toggleCatererSignup}>
        {#if catererSignup == false}
          Register as a Caterer
        {:else}
          Register as Customer
        {/if}
      </button>
      <div class="fields_pair">
        <div class="field">
          <label for="first_name">First name</label>
          <input type="text" name="first_name" bind:value={firstName} required>
        </div>
        <div class="field">
          <label for="last_name">Last name</label>
          <input type="text" name="last_name" bind:value={lastName} required>
        </div>
      </div>
    {/if}
    <div class="field">
      <label for="email">Email</label>
      <input type="text" name="email" bind:value={email} required>
    </div>
    <div class="field">
      <label for="password">Password</label>
      <input type="password" name="password" bind:value={password} required>
    </div>
    {#if page === 'signup'}
      <div class="field">
        <label for="password">Password confirmation</label>
        <input type="password" name="password_confirmation" bind:this={passwordConfirmation} required>
      </div>
      <input type="hidden" name="caterer_user" bind:value={catererSignup}/>
      {#if catererSignup == true}
        <div class="field">
          <label for="business_name">Business name</label>
          <input type="text" name="business_name" bind:this={catererBusinessName} required>
        </div>
        <div class="field">
          <label for="address">Business address</label>
          <input type="text" name="address" bind:this={catererBusinessAddress} required>
        </div>
        <div class="fields_trio">
          <div class="field">
            <label for="city">City</label>
            <input type="text" name="city" bind:this={catererBusinessCity} required>
          </div>
          <div class="field">
            <label for="state">State</label>
            <input type="text" name="state" bind:this={catererBusinessState} required>
          </div>
          <div class="field">
            <label for="zip">Zip Code</label>
            <input type="text" name="zip" bind:this={zipCode} required>
          </div>
        </div>
      {/if}
    {/if}
    <button type="submit" class="button primary" on:click|preventDefault={authenticate(page)}>Submit</button>
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
  border: 2px solid #B6B6B6;
  margin-top: 20px;
  border-radius: 5px;
  box-shadow: 0 1px 5px -2px rgb(10,10,10);
  padding: 20px;
  grid-gap: 10px;
}

.field {
  grid-template-columns: 1fr;
}

.fields_pair {
  grid-template-columns: 1fr 1fr;
}

.fields_trio {
  grid-template-columns: 1fr 1fr 1fr;
}

label {
  font-size: 1.0rem;
  font-weight: bold;
  font-family: Arial, Helvetica, sans-serif;
  display: block;
}

input {
  padding: 5px;
  display: block;
  width: 100%
}

@media(min-width: 500px) {

  .fields_trio,
  .fields_pair {
    display: grid;
    width: 100%;
    grid-gap: 10px;
    grid-auto-flow: column;
  }

}

</style>