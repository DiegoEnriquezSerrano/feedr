function autocomplete(input, usAddress, latInput, lonInput) {
  if (!input) return;
  const dropdown = new google.maps.places.Autocomplete(input);

  dropdown.addListener('place_changed', () => {
    const place = dropdown.getPlace();
    const arr = place.formatted_address.split(',');
    arr.pop();
    arr[2] = " " + arr[2].split(' ').slice(1).join(', ');
    usAddress.value = arr.join(',');
    latInput.value = place.geometry.location.lat();
    lonInput.value = place.geometry.location.lng();
  });
  
  input.addEventListener('keydown', (e) => {
    if (e.keycode === 13) e.preventDefault();
  });
}

export default autocomplete;