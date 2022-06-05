#version 450

uniform Hello {
  vec4 color;
} hello;

out vec4 frag_color;

void main() {
  frag_color = hello.color;
}
