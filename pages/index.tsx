import { NextPage } from 'next';
import { Welcome } from '../lib/components/Welcome';
import { ColorSchemeToggle } from '../lib/components/ColorSchemeToggle';

const Home: NextPage = () => (
  <>
    <Welcome />
    <ColorSchemeToggle />
  </>
);

export default Home;
