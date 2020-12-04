function autocomplete(input) {
  if (!input) return;
  const dropdown = new google.maps.places.Autocomplete(input);

  dropdown.addListener('place_changed', () => {
    const place = dropdown.getPlace();
  });
  
  input.addEventListener('keydown', (e) => {
    if (e.keycode === 13) e.preventDefault();
  });
}

export default autocomplete;