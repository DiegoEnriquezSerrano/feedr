<script>

  import { SERVER_PORT, CLIENT_PORT } from '../javascript/functions.js';

  export let caterer;

  let loadCaterer = (id) => {
    window.location = `/caterers/${id}`;
  }

</script>

<a href="/caterers/{caterer.id}">
  <div class="caterer">
    <div
      class="caterer-cover-img"
      style="background-image: url('http://localhost:{CLIENT_PORT}/uploads/{caterer.caterer_business_cover_image}')"
      alt="{caterer.caterer_business_name} cover image"></div>
    <div class="caterer-specs">
      {caterer.caterer_business_name}
      <div class="details">
        <span>{caterer.caterer_business_address}</span><br>
        <span>{caterer.caterer_business_city}, {caterer.caterer_business_state} {caterer.zip_code}</span>
      </div><!--details-->
    </div><!--caterer-specs-->
  </div><!--caterer-->
</a>

<style>

.caterer {
  padding: 0;
  color: black;
  box-shadow: 0px 1px 5px -1px rgba(25,25,25,0.3);
  border-radius: 5px;
  background-color: #fafafa;
  display: grid;
  grid-auto-flow: column;
  grid-template-columns: 110px 1fr;
  overflow: hidden;
  transition: all 0.2s ease-in-out;
}

.caterer:hover {
  cursor: pointer;
}

.caterer-cover-img {
  width: 110px;
  height: 100px;
  background-size: cover;
  background-position: center;
}

.caterer-specs {
  padding: 10px;
  text-align: left;
  justify-items: left;
  white-space: nowrap;
  word-break: keep-all;
  overflow-x: hidden;
  text-overflow: ellipsis;
}

.details {
  font-size: 0.8rem;
  line-height: 0.9rem;
}

.caterer:hover,
.caterer:active {
  box-shadow: 0px 1px 8px -1px rgba(25,25,25,0.5);
}

@media(min-width: 600px) {
  .caterer {
    grid-template-columns: 260px 1fr;
  }

  .caterer-cover-img {
    width: 260px;
    height: 200px;
  }
}

</style>