<script>

export let response;

</script>

<div class="toast " class:warning={response.status >= 400} class:success={response.status <= 399}>
  {#if response.status <= 399}
    {response.message}
  {/if}
</div>

<style>

.toast {
  display: none;
  width: calc(100vw - 20px);
  min-width: 300px;
  max-width: 500px;
  position: absolute;
  margin: auto;
  top: calc(3rem + 15px);
  padding: 10px;
  font-size: 0.9rem;
  z-index: 450;
  text-align: center;
  border-radius: 5px;
  box-shadow: 0 2px 4px -2px rgb(45,45,45);
}

.warning {
  display: block;
  color: white;
  background-color: rgb(241, 103, 88);
}

.success {
  display: block;
  color: black;
  background-color: rgb(60, 179, 113);
}

</style>