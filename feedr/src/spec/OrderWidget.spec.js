import '@testing-library/jest-dom/extend-expect'
import { render, fireEvent } from '@testing-library/svelte'
import OrderWidget from '../components/OrderWidget.svelte'

const user = { caterer_user: false, first_name: "diego", id: 2 }
const meal = {
  cover_image: "carnitas.png",
  first_name: "diego",
  id: 1,
  in_current_order: 0,
  name: "Sunday Morning Jackfruit Carnitas",
  price_minimum: "40.0",
  servings_minimum: 5,
  ingredients: "Jackfruit, Vegetable Shortening, Coconut Milk...",
  description: "Noting quite like getting the whole family..."
}

localStorage.setItem('feedrUser', JSON.stringify(user));

test('show add to order if meal is not in current order', async () => {
  const { getByText } = render(OrderWidget, { meal: meal });
  const increment = getByText('+')
  const decrement = getByText('–')
  const orderWidget = document.querySelector(".order-widget")

  let input = orderWidget.querySelector('input')

  expect(getByText('Add to order')).toBeInTheDocument()
  await fireEvent.click(increment)
  expect(Number(input.value)).toBeGreaterThanOrEqual(meal.servings_minimum)
})