import { render } from '@testing-library/react';
import { Welcome } from '../lib/components/Welcome';

it('renders homepage unchanged', () => {
  const { container } = render(<Welcome />);
  expect(container).toMatchSnapshot();
});
