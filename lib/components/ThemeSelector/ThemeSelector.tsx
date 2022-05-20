import { Box, IconButton, useColorMode } from "@chakra-ui/react";
import { Moon, Sun } from "../../icons";

const ThemeSelector = () => {
  const { colorMode, toggleColorMode } = useColorMode();
  return (
    <IconButton
      size={"md"}
      aria-label="Toggle color mode"
      icon={colorMode === "light" ? <Moon /> : <Sun />}
      onClick={toggleColorMode}
    />
  );
};

export default ThemeSelector;
