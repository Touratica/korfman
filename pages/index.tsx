import {
  Button,
  Flex,
  Heading,
  Input,
  useColorMode,
  useColorModeValue,
} from "@chakra-ui/react";
import type { NextPage } from "next";
import { ThemeSelector } from "../lib/components/ThemeSelector";

const Home: NextPage = () => {
  const { toggleColorMode } = useColorMode();
  const formBackground = useColorModeValue("gray.100", "gray.700");
  return (
    <Flex height={"100vh"} alignItems="center" justifyContent={"center"}>
      <ThemeSelector />
      <Flex direction={"column"} background={formBackground} p={12} rounded={6}>
        <Heading mb={6}>Log in</Heading>
        <Input
          placeholder="jacare@korfballx.pt"
          variant={"filled"}
          mb={3}
          type="email"
        />
        <Input
          placeholder="********"
          variant={"filled"}
          mb={6}
          type="password"
        />
        <Button colorScheme={"green"}>Log in</Button>
      </Flex>
    </Flex>
  );
};

export default Home;
