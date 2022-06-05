WGSL_FRAG_FILES:= blend.frag.wgsl                      \
									advanced_blend_exclusion.frag.wgsl   \
									glyph_atlas.frag.wgsl                \
									advanced_blend_colordodge.frag.wgsl  \
									ink_sparkle.frag.wgsl                \
									simple.frag.wgsl                     \
									solid_stroke.frag.wgsl               \
									advanced_blend_multiply.frag.wgsl    \
									advanced_blend_softlight.frag.wgsl   \
									vertices.frag.wgsl                   \
									border_mask_blur.frag.wgsl           \
									advanced_blend_lighten.frag.wgsl     \
									solid_fill.frag.wgsl                 \
									impeller.frag.wgsl                   \
									advanced_blend_overlay.frag.wgsl     \
									advanced_blend_difference.frag.wgsl  \
									advanced_blend_hardlight.frag.wgsl   \
									gaussian_blur.frag.wgsl              \
									texture_fill.frag.wgsl               \
									advanced_blend_colorburn.frag.wgsl   \
									gradient_fill.frag.wgsl              \
									advanced_blend_screen.frag.wgsl      \
									advanced_blend_darken.frag.wgsl      \

WGSL_VERT_FILES:= solid_fill.vert.wgsl				\
									vertices.vert.wgsl					\
									border_mask_blur.vert.wgsl	\
									gradient_fill.vert.wgsl		  \
									texture_fill.vert.wgsl			\
									gaussian_blur.vert.wgsl		  \
									advanced_blend.vert.wgsl		\
									solid_stroke.vert.wgsl			\
									blend.vert.wgsl						  \
									glyph_atlas.vert.wgsl			 \

.PRECIOUS: %.frag.spvasm %.vert.spvasm

main: vertex_shaders fragment_shaders

vertex_shaders: $(WGSL_VERT_FILES)
fragment_shaders: $(WGSL_FRAG_FILES)

%.vert.wgsl: %.vert.spvasm
	/Users/buzzy/VersionControlled/dawn/out/Debug/tint -o $@ $<

%.frag.wgsl: %.frag.spvasm
	/Users/buzzy/VersionControlled/dawn/out/Debug/tint -o $@ $<

%.vert.spvasm: %.vert
	glslc --target-env=vulkan1.0	\
				-std=460core						\
				-fauto-bind-uniforms		\
				-fauto-map-locations		\
				-O0											\
				-S -o $@ $<

%.frag.spvasm: %.frag
	glslc --target-env=vulkan1.0	\
				-std=460core						\
				-fauto-bind-uniforms		\
				-fauto-map-locations		\
				-O0											\
				-S -o $@ $<

clean:
	rm -f *.spvasm *.wgsl
