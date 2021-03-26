import '@testing-library/jest-dom/extend-expect'
import { render, fireEvent } from '@testing-library/svelte'

import Nav from '../components/Nav.svelte'

test('show logout link when user is logged in', () => {
  const { getByText } = render(Nav, { 
    user: {
      caterer_user: false,
      first_name: "diego",
      id: 2
    },
  });

  expect(getByText('Order')).toBeInTheDocument();
  expect(getByText('Logout')).toBeInTheDocument();
})

test('show logout link when user is logged in', () => {
  const { getByText } = render(Nav, { });

  expect(getByText('Sign Up')).toBeInTheDocument();
  expect(getByText('Login')).toBeInTheDocument();
})