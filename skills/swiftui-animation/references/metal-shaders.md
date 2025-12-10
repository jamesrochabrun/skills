# Metal Shaders and SwiftUI Integration

Metal is Apple's low-level graphics and compute shader framework for GPU-accelerated rendering and effects. It can be combined with SwiftUI in two primary ways:

1. **SwiftUI shader effects** - Built-in modifiers for per-view GPU processing (iOS 17+)
2. **Custom Metal rendering** - Embedding MTKView for fully custom pipelines

Both approaches work cross-platform (iOS, macOS, visionOS) with similar APIs.

## SwiftUI Shader Effects (iOS 17+)

Modern SwiftUI introduces view modifiers that apply custom Metal fragment shaders directly to views:

- `.colorEffect()` - Modify pixel colors only
- `.distortionEffect()` - Displace pixel positions (warping, ripples)
- `.layerEffect()` - Full composite effects with original layer access

### Creating a Metal Shader

#### 1. Add a Metal File

Create a `.metal` file in your project:

```metal
// Shaders.metal
#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

// Color effect - modify colors only
[[stitchable]] half4 pixelate(
    float2 position,
    SwiftUI::Layer layer,
    float size
) {
    float2 pixelatedPosition = floor(position / size) * size;
    return layer.sample(pixelatedPosition);
}

// Distortion effect - displace pixels
[[stitchable]] float2 wave(
    float2 position,
    float time,
    float amplitude,
    float frequency
) {
    float2 offset = float2(
        sin(position.y * frequency + time) * amplitude,
        cos(position.x * frequency + time) * amplitude
    );
    return position + offset;
}

// Color manipulation
[[stitchable]] half4 colorShift(
    float2 position,
    half4 color,
    float hueShift
) {
    // Convert RGB to HSV, shift hue, convert back
    float3 rgb = float3(color.rgb);
    // ... HSV conversion logic ...
    return half4(rgb.r, rgb.g, rgb.b, color.a);
}
```

#### 2. Apply in SwiftUI

```swift
import SwiftUI

struct ShaderDemoView: View {
    @State private var time: Float = 0
    let timer = Timer.publish(every: 1/60, on: .main, in: .common).autoconnect()

    var body: some View {
        Image("photo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .layerEffect(
                ShaderLibrary.pixelate(.float(10)),
                maxSampleOffset: .zero
            )
    }
}

struct WaveEffectView: View {
    @State private var time: Float = 0

    var body: some View {
        Text("Wavy Text")
            .font(.largeTitle)
            .distortionEffect(
                ShaderLibrary.wave(
                    .float(time),
                    .float(5),    // amplitude
                    .float(0.1)   // frequency
                ),
                maxSampleOffset: CGSize(width: 10, height: 10)
            )
            .onReceive(Timer.publish(every: 1/60, on: .main, in: .common).autoconnect()) { _ in
                time += 0.05
            }
    }
}
```

### Shader Types Explained

#### colorEffect

Changes pixel colors without moving them. The shader receives the current color and position.

```swift
.colorEffect(ShaderLibrary.invertColors())
```

```metal
[[stitchable]] half4 invertColors(float2 position, half4 color) {
    return half4(1.0 - color.rgb, color.a);
}
```

#### distortionEffect

Displaces pixels to new positions. Returns the source position to sample from.

```swift
.distortionEffect(
    ShaderLibrary.ripple(.float(time), .float2(center)),
    maxSampleOffset: CGSize(width: 100, height: 100)
)
```

```metal
[[stitchable]] float2 ripple(
    float2 position,
    float time,
    float2 center
) {
    float distance = length(position - center);
    float wave = sin(distance * 0.1 - time * 5) * 10;
    float2 direction = normalize(position - center);
    return position + direction * wave;
}
```

**Important:** Set `maxSampleOffset` to the maximum distance pixels can move.

#### layerEffect

Full access to the rendered layer, enabling complex composite effects.

```swift
.layerEffect(
    ShaderLibrary.blur(.float(radius)),
    maxSampleOffset: CGSize(width: radius, height: radius)
)
```

```metal
[[stitchable]] half4 blur(
    float2 position,
    SwiftUI::Layer layer,
    float radius
) {
    half4 color = half4(0);
    float samples = 0;

    for (float x = -radius; x <= radius; x += 1) {
        for (float y = -radius; y <= radius; y += 1) {
            color += layer.sample(position + float2(x, y));
            samples += 1;
        }
    }

    return color / samples;
}
```

### Animated Shader Example

```swift
struct AnimatedShaderView: View {
    @State private var phase: CGFloat = 0

    var body: some View {
        TimelineView(.animation) { timeline in
            let time = timeline.date.timeIntervalSinceReferenceDate

            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .distortionEffect(
                    ShaderLibrary.wave(
                        .float(Float(time)),
                        .float(8),
                        .float(0.05)
                    ),
                    maxSampleOffset: CGSize(width: 20, height: 20)
                )
        }
    }
}
```

### Common Shader Effects

#### Chromatic Aberration

```metal
[[stitchable]] half4 chromaticAberration(
    float2 position,
    SwiftUI::Layer layer,
    float amount
) {
    half4 r = layer.sample(position + float2(amount, 0));
    half4 g = layer.sample(position);
    half4 b = layer.sample(position - float2(amount, 0));
    return half4(r.r, g.g, b.b, g.a);
}
```

#### Vignette

```metal
[[stitchable]] half4 vignette(
    float2 position,
    half4 color,
    float2 size,
    float intensity
) {
    float2 uv = position / size;
    float2 center = float2(0.5, 0.5);
    float dist = distance(uv, center);
    float vignette = 1.0 - smoothstep(0.3, 0.7, dist * intensity);
    return half4(color.rgb * vignette, color.a);
}
```

#### Noise/Grain

```metal
[[stitchable]] half4 filmGrain(
    float2 position,
    half4 color,
    float time,
    float intensity
) {
    float noise = fract(sin(dot(position + time, float2(12.9898, 78.233))) * 43758.5453);
    half3 grain = half3(noise * intensity);
    return half4(color.rgb + grain, color.a);
}
```

## Embedding Metal with UIViewRepresentable

For full control over Metal rendering (3D content, custom vertex shaders, multi-pass rendering), embed an MTKView in SwiftUI.

### Basic Setup

```swift
import SwiftUI
import MetalKit

struct MetalView: UIViewRepresentable {
    func makeCoordinator() -> Renderer {
        Renderer()
    }

    func makeUIView(context: Context) -> MTKView {
        let mtkView = MTKView()
        mtkView.device = MTLCreateSystemDefaultDevice()
        mtkView.delegate = context.coordinator
        mtkView.preferredFramesPerSecond = 60
        mtkView.enableSetNeedsDisplay = false
        mtkView.isPaused = false
        mtkView.clearColor = MTLClearColor(red: 0, green: 0, blue: 0, alpha: 1)
        context.coordinator.setup(mtkView: mtkView)
        return mtkView
    }

    func updateUIView(_ uiView: MTKView, context: Context) {}
}

class Renderer: NSObject, MTKViewDelegate {
    var device: MTLDevice!
    var commandQueue: MTLCommandQueue!
    var pipelineState: MTLRenderPipelineState!

    func setup(mtkView: MTKView) {
        device = mtkView.device
        commandQueue = device.makeCommandQueue()

        // Create pipeline
        let library = device.makeDefaultLibrary()!
        let vertexFunction = library.makeFunction(name: "vertexShader")
        let fragmentFunction = library.makeFunction(name: "fragmentShader")

        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.vertexFunction = vertexFunction
        pipelineDescriptor.fragmentFunction = fragmentFunction
        pipelineDescriptor.colorAttachments[0].pixelFormat = mtkView.colorPixelFormat

        pipelineState = try! device.makeRenderPipelineState(descriptor: pipelineDescriptor)
    }

    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {}

    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable,
              let renderPassDescriptor = view.currentRenderPassDescriptor,
              let commandBuffer = commandQueue.makeCommandBuffer(),
              let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        else { return }

        renderEncoder.setRenderPipelineState(pipelineState)
        // Add draw calls here
        renderEncoder.endEncoding()

        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}
```

### macOS Version (NSViewRepresentable)

```swift
import SwiftUI
import MetalKit

struct MetalView: NSViewRepresentable {
    func makeCoordinator() -> Renderer {
        Renderer()
    }

    func makeNSView(context: Context) -> MTKView {
        let mtkView = MTKView()
        mtkView.device = MTLCreateSystemDefaultDevice()
        mtkView.delegate = context.coordinator
        mtkView.preferredFramesPerSecond = 60
        mtkView.enableSetNeedsDisplay = false
        mtkView.isPaused = false
        context.coordinator.setup(mtkView: mtkView)
        return mtkView
    }

    func updateNSView(_ nsView: MTKView, context: Context) {}
}
```

### Cross-Platform Version

```swift
import SwiftUI
import MetalKit

#if os(iOS) || os(tvOS)
typealias ViewRepresentable = UIViewRepresentable
typealias ViewType = UIView
#elseif os(macOS)
typealias ViewRepresentable = NSViewRepresentable
typealias ViewType = NSView
#endif

struct MetalView: ViewRepresentable {
    func makeCoordinator() -> Renderer {
        Renderer()
    }

    #if os(iOS) || os(tvOS)
    func makeUIView(context: Context) -> MTKView {
        createMTKView(context: context)
    }
    func updateUIView(_ uiView: MTKView, context: Context) {}
    #elseif os(macOS)
    func makeNSView(context: Context) -> MTKView {
        createMTKView(context: context)
    }
    func updateNSView(_ nsView: MTKView, context: Context) {}
    #endif

    private func createMTKView(context: Context) -> MTKView {
        let mtkView = MTKView()
        mtkView.device = MTLCreateSystemDefaultDevice()
        mtkView.delegate = context.coordinator
        mtkView.preferredFramesPerSecond = 60
        context.coordinator.setup(mtkView: mtkView)
        return mtkView
    }
}
```

### Passing Data to Metal View

```swift
struct MetalView: UIViewRepresentable {
    @Binding var parameter: Float

    func makeCoordinator() -> Renderer {
        Renderer()
    }

    func makeUIView(context: Context) -> MTKView {
        // ... setup
    }

    func updateUIView(_ uiView: MTKView, context: Context) {
        context.coordinator.parameter = parameter
    }
}

class Renderer: NSObject, MTKViewDelegate {
    var parameter: Float = 0

    func draw(in view: MTKView) {
        // Use self.parameter in rendering
    }
}
```

### Animated Metal Content with SwiftUI State

```swift
struct AnimatedMetalView: View {
    @State private var time: Float = 0

    var body: some View {
        TimelineView(.animation) { timeline in
            let elapsed = timeline.date.timeIntervalSinceReferenceDate
            MetalView(time: Float(elapsed))
        }
    }
}
```

## Choosing the Right Approach

### Use SwiftUI Shader Effects When:

- Applying effects to existing SwiftUI views
- Creating shader-driven transitions
- Adding image processing (blur, color shifts, distortions)
- Building particle-like effects on views
- Simpler implementation is preferred

### Use MTKView Embedding When:

- Rendering custom 3D content
- Performing custom drawing with vertex shaders
- Managing multi-phase GPU rendering
- Using compute kernels
- Building games or interactive 3D scenes
- Needing advanced Metal features (multiple render passes, custom blending)

## Performance Considerations

1. **Shader complexity** - Keep shaders efficient; GPU time matters
2. **maxSampleOffset** - Set accurately; larger values = more GPU work
3. **Frame rate** - Use `TimelineView(.animation)` for smooth updates
4. **Memory** - Large textures consume GPU memory
5. **Profiling** - Use Xcode's GPU profiler for optimization

## Sources

- EnDavid Blog - SwiftUI and Metal (Feb 2024)
- Apple Developer Forums - MetalKit in SwiftUI
- WWDC23 - Create custom visual effects with SwiftUI
- Apple Developer Documentation - Metal Shading Language
- Hacking with Swift - Metal shaders in SwiftUI
