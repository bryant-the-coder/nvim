---@diagnostic disable: undefined-global
local hello = [[
#include <iostream>

int main() {
    std::cout << "$1";
}
]]

return {
  parse({ trig = "hello" }, hello),
}
