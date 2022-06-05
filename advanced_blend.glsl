// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

uniform BlendInfo {
  float color_factor;
  vec4 color;  // This color input is expected to be unpremultiplied.
} blend_info;

uniform texture2D texture_sampler_dst;
uniform sampler texture_sampler_dst_smplr;
uniform texture2D texture_sampler_src;
uniform sampler texture_sampler_src_smplr;

in vec2 v_dst_texture_coords;
in vec2 v_src_texture_coords;

out vec4 frag_color;

vec4 Unpremultiply(vec4 color) {
  if (color.a == 0) {
    return vec4(0);
  }
  return vec4(color.rgb / color.a, color.a);
}

void main() {
  vec4 dst = Unpremultiply(
      texture(sampler2D(texture_sampler_dst, texture_sampler_dst_smplr), v_dst_texture_coords));
  vec4 src = blend_info.color_factor > 0
                 ? blend_info.color
                 : Unpremultiply(
      texture(sampler2D(texture_sampler_src, texture_sampler_src_smplr), v_src_texture_coords));

  vec3 blended = Blend(dst.rgb, src.rgb);

  frag_color = vec4(blended * src.a, src.a);
}
