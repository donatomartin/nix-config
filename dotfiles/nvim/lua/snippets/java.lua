local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local events = require("luasnip.util.events")

local snippets = {}

-- ╭────────────────────────────────────────────────────────╮
-- │ HELPER FUNCTIONS
-- ╰────────────────────────────────────────────────────────╯

local function get_class_name()
  return vim.fn.expand("%:t:r")
end

local function get_package_name()
  local dir = vim.fn.expand("%:p:h")

  local pkg = dir:match(".*/src/main/java/(.*)")
      or dir:match(".*/src/test/java/(.*)")

  if not pkg then
    return "package ;"
  end

  return "package " .. pkg:gsub("/", ".") .. ";"
end

local function addSnippet(snippet)
  table.insert(snippets, snippet)
end

-- ╭────────────────────────────────────────────────────────╮
-- │ SNIPPETS
-- ╰────────────────────────────────────────────────────────╯

-- Package statement

addSnippet(s("pkg", {
  f(get_package_name),
}))

-- Create Mapper

local mapper_template = [[
{}

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingConstants.ComponentModel;

@Mapper(componentModel = ComponentModel.SPRING)
public interface {} {{

	{} map({} source);

	{}
}}
]]

addSnippet(s(
  "spmapper",
  fmt(
    mapper_template,
    {
      f(get_package_name),
      f(get_class_name),
      i(1, "Type1"),
      i(2, "Type2"),
      i(0),
    }
  )
))

-- MapStruct Mapping

local mapping_template = [[
@Mapping(target = "{}", source = "{}")
]]

addSnippet(s(
  "spmapping",
  fmt(
    mapping_template,
    {
      i(1, "target"),
      i(2, "source"),
    }
  )
))

-- Create DTO

local dto_template = [[
{}

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.FieldNameConstants;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@FieldNameConstants
@ToString
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
public class {} {{

	@EqualsAndHashCode.Include
	private Long id;

  {}

}}
]]

addSnippet(s(
  "spdto",
  fmt(
    dto_template,
    {
      f(get_package_name),
      f(get_class_name),
      i(0),
    }
  )
))

-- Create test class

local test_class_template = [[
{}
import org.junit.jupiter.api.Test;

class {} {{

	{}

}}
]]

addSnippet(s(
  "tclass",
  fmt(
    test_class_template,
    {
      f(get_package_name),
      f(get_class_name),
      i(0),
    }
  )
))

-- Create test function

local test_function_template = [[
@Test
void test{}() {{
	{}

}}
]]

addSnippet(s(
  "tfun",
  fmt(
    test_function_template,
    {
      i(1, "MethodNameCondition"),
      i(0),
    }
  )
))

-- Mockito when(...).thenReturn(...)

local when_template = [[
when({})
	.thenReturn({});
{}
]]

addSnippet(s(
  "when",
  fmt(
    when_template,
    {
      i(1, "condition"),
      i(2, "mockedReturn"),
      i(0),
    }
  )
))

return snippets
