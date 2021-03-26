<div class="search">
  <form>
    <input name="address" type="text" placeholder="Enter a dropoff location..">
  </form>
  <button class="button primary">Search</button>
</div>

<style>

.search {
  display: grid;
  grid-auto-flow: column;
  grid-template-columns: 1fr minmax(100px, 25%);
  align-content: stretch;
  justify-items: stretch;
}

input[type="text"] {
  display: grid;
  width: inherit;
  height: inherit;
  font: inherit;
  font-size: 1.0rem;
  padding: 5px 10px;
}

form {
  display: grid;
}

button {
  font: inherit;
  font-size: 1.2rem;
  font-weight: normal;
}

@media(min-width: 500px) {
  button {
    font-size: 1.4rem;
  }
}
</style>