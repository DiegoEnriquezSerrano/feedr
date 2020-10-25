<section class="hero">
  <div class="element">
    <div>
      <h1>Welcome!</h1>
      <p>Let's find some chefs in your area!</p>
    </div>
    <div class="inline-search">
      <input type="text" placeholder="What is your address?">
      <button class="button primary">Search</button>
    </div>
  </div>
</section>

<style>

.hero {
  display: grid;
  width: 100%;
  height: 85vh;
  background-image: url('/images/HomePageSplash.jpg');
  border-bottom-left-radius: 350px;
  border-bottom-right-radius: 350px;
  background-position: top left;
  background-size: cover;
  background-repeat: no-repeat;
  align-content: center;
  grid-template-areas:
   '.'
   'e'
   '.';
}

.element {
  background-color: rgba(0,0,0,0.75);
  padding: 20px;
  max-width: 1200px;
  grid-area: e;
  margin: 20px;
}

@media(min-width: 500px) {
  .hero {
    grid-template-areas:
      '. . .'
      '. e .'
      '. . .';
    border-bottom-left-radius: 50%;
    border-bottom-right-radius: 50%;
  }

  .element {
    padding: 50px;
  }
}

</style>