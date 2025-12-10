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

### How Shaders Work in SwiftUI

Shaders are small programs that run on your device's GPU. SwiftUI uses shaders internally to implement many visual effects like Mesh Gradients. When you apply a shader effect to a view using modifiers like `.layerEffect()`, SwiftUI calls your shader function for every single pixel of your view.

```swift
// Instantiate a shader from ShaderLibrary
let shader = ShaderLibrary.ripple(
    .float(time),
    .float2(origin),
    .color(.pink)
)

// Apply to a view
myView.layerEffect(shader, maxSampleOffset: CGSize(width: 100, height: 100))
```

### Metal Shading Language Basics

Shaders are written in Metal Shading Language (not Swift). The shader function name matches the invocation on `ShaderLibrary`.

```metal
// Shaders.metal
#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

[[stitchable]] half4 myEffect(
    float2 position,      // Current pixel's location
    SwiftUI::Layer layer, // View's content (for sampling)
    half4 color           // SwiftUI Color converted to half4
) {
    // position: the pixel being processed
    // layer.sample(pos): get color at position (must stay within maxSampleOffset)
    // color: passed-in color parameter

    return layer.sample(position);
}
```

### Metal Vector Types

Metal uses vector types extensively:

- `float2` - Two-component 32-bit float (2D points, dimensions)
- `half4` - Four-component 16-bit float (RGBA colors)
- `float3` - Three-component 32-bit float (RGB, 3D positions)
- `float4` - Four-component 32-bit float

SwiftUI automatically converts types like `Color` to Metal representations (`half4`).

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

Full access to the rendered layer, enabling complex composite effects. This is the most powerful effect type and effectively a superset of the other two.

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

## Complete Ripple Effect Example (WWDC 2024)

This example from WWDC 2024 shows a touch-responsive ripple effect that spreads from the touch location.

### Metal Shader

```metal
[[stitchable]] half4 ripple(
    float2 position,
    SwiftUI::Layer layer,
    float2 origin,
    float time,
    float amplitude,
    float frequency,
    float decay,
    float speed
) {
    // Calculate distance from touch origin
    float distance = length(position - origin);

    // Calculate ripple displacement
    float rippleAmount = amplitude * sin(frequency * distance - speed * time);
    rippleAmount *= exp(-decay * distance); // Decay with distance

    // Calculate new sample position
    float2 direction = normalize(position - origin);
    float2 newPosition = position + direction * rippleAmount;

    // Sample the layer at the distorted position
    half4 color = layer.sample(newPosition);

    // Optional: adjust brightness based on distortion strength
    float brightness = 1.0 + rippleAmount * 0.02;
    color.rgb *= brightness;

    return color;
}
```

### SwiftUI ViewModifier

```swift
struct RippleModifier: ViewModifier {
    var origin: CGPoint
    var elapsedTime: TimeInterval
    var amplitude: Double = 12
    var frequency: Double = 15
    var decay: Double = 8
    var speed: Double = 1200

    func body(content: Content) -> some View {
        content.layerEffect(
            ShaderLibrary.ripple(
                .float2(origin),
                .float(elapsedTime),
                .float(amplitude),
                .float(frequency),
                .float(decay),
                .float(speed)
            ),
            maxSampleOffset: CGSize(width: 100, height: 100)
        )
    }
}
```

### Animated Ripple Effect

```swift
struct RippleEffect: ViewModifier {
    var origin: CGPoint
    var trigger: Bool
    var duration: TimeInterval = 1.5

    func body(content: Content) -> some View {
        content.keyframeAnimator(
            initialValue: 0.0,
            trigger: trigger
        ) { view, elapsedTime in
            view.modifier(RippleModifier(
                origin: origin,
                elapsedTime: elapsedTime
            ))
        } keyframes: { _ in
            LinearKeyframe(duration, duration: duration)
        }
    }
}

extension View {
    func rippleEffect(at origin: CGPoint, trigger: Bool) -> some View {
        modifier(RippleEffect(origin: origin, trigger: trigger))
    }
}

// Usage
struct RippleDemo: View {
    @State private var tapLocation: CGPoint = .zero
    @State private var trigger = false

    var body: some View {
        Image("photo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .rippleEffect(at: tapLocation, trigger: trigger)
            .onTapGesture { location in
                tapLocation = location
                trigger.toggle()
            }
    }
}
```

### Debug UI for Shader Parameters

Building great shader effects requires experimentation. Create debug UI to iterate quickly:

```swift
struct ShaderDebugView: View {
    @State private var amplitude: Double = 12
    @State private var frequency: Double = 15
    @State private var decay: Double = 8
    @State private var speed: Double = 1200
    @State private var time: Double = 0

    var body: some View {
        VStack {
            // Preview with scrubber
            Image("photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .modifier(RippleModifier(
                    origin: CGPoint(x: 150, y: 150),
                    elapsedTime: time,
                    amplitude: amplitude,
                    frequency: frequency,
                    decay: decay,
                    speed: speed
                ))

            // Time scrubber
            Slider(value: $time, in: 0...2)
            Text("Time: \(time, specifier: "%.2f")")

            // Parameter controls
            Group {
                Slider(value: $amplitude, in: 0...50)
                Text("Amplitude: \(amplitude, specifier: "%.1f")")

                Slider(value: $frequency, in: 0...50)
                Text("Frequency: \(frequency, specifier: "%.1f")")

                Slider(value: $decay, in: 0...20)
                Text("Decay: \(decay, specifier: "%.1f")")

                Slider(value: $speed, in: 0...3000)
                Text("Speed: \(speed, specifier: "%.0f")")
            }
        }
        .padding()
    }
}
```

## Scroll Effects with visualEffect

The `visualEffect` modifier provides access to view geometry for position-based effects:

```swift
struct GroceryListView: View {
    let items: [GroceryItem]

    var body: some View {
        ScrollView {
            ForEach(items) { item in
                ItemRow(item: item)
                    .visualEffect { content, proxy in
                        let frame = proxy.frame(in: .scrollView)
                        let yPosition = frame.minY

                        return content
                            .hueRotation(.degrees(yPosition / 3))
                            .offset(y: yPosition < 100 ? (100 - yPosition) * 0.3 : 0)
                            .scaleEffect(yPosition < 100 ? 0.9 + (yPosition / 1000) : 1)
                            .blur(radius: yPosition < 50 ? (50 - yPosition) / 10 : 0)
                            .opacity(yPosition < 50 ? yPosition / 50 : 1)
                    }
            }
        }
    }
}
```

## Mesh Gradients (iOS 18+)

Mesh gradients create beautiful color fills from a grid of control points:

```swift
struct MeshGradientView: View {
    var body: some View {
        MeshGradient(
            width: 3,
            height: 3,
            points: [
                // Row 0
                SIMD2(0.0, 0.0), SIMD2(0.5, 0.0), SIMD2(1.0, 0.0),
                // Row 1
                SIMD2(0.0, 0.5), SIMD2(0.5, 0.5), SIMD2(1.0, 0.5),
                // Row 2
                SIMD2(0.0, 1.0), SIMD2(0.5, 1.0), SIMD2(1.0, 1.0)
            ],
            colors: [
                .red, .orange, .yellow,
                .green, .blue, .purple,
                .pink, .mint, .cyan
            ]
        )
        .ignoresSafeArea()
    }
}
```

### Animated Mesh Gradient

```swift
struct AnimatedMeshGradient: View {
    @State private var centerPoint = SIMD2<Float>(0.5, 0.5)

    var body: some View {
        TimelineView(.animation) { timeline in
            let time = timeline.date.timeIntervalSinceReferenceDate

            MeshGradient(
                width: 3,
                height: 3,
                points: [
                    SIMD2(0.0, 0.0), SIMD2(0.5, 0.0), SIMD2(1.0, 0.0),
                    SIMD2(0.0, 0.5),
                    SIMD2(
                        0.5 + Float(sin(time)) * 0.2,
                        0.5 + Float(cos(time)) * 0.2
                    ),
                    SIMD2(1.0, 0.5),
                    SIMD2(0.0, 1.0), SIMD2(0.5, 1.0), SIMD2(1.0, 1.0)
                ],
                colors: [
                    .red, .orange, .yellow,
                    .green, .blue, .purple,
                    .pink, .mint, .cyan
                ]
            )
        }
    }
}
```

## TextRenderer (iOS 18+)

TextRenderer allows customizing how SwiftUI Text is drawn, enabling per-glyph animations.

### Basic TextRenderer

```swift
struct AnimatedTextRenderer: TextRenderer {
    var elapsedTime: TimeInterval
    var elementDuration: TimeInterval = 0.1
    var totalDuration: TimeInterval = 0.9

    var animatableData: Double {
        get { elapsedTime }
        set { elapsedTime = newValue }
    }

    func draw(layout: Text.Layout, in context: inout GraphicsContext) {
        let count = layout.flattenedRunSlices.count
        let delay = elementDelay(count: count)

        for (index, slice) in layout.flattenedRunSlices.enumerated() {
            let timeOffset = Double(index) * delay
            let elementTime = max(0, min(elementDuration, elapsedTime - timeOffset))
            let progress = elementTime / elementDuration

            var copy = context

            // Animate opacity
            copy.opacity = progress

            // Animate blur (from blurry to sharp)
            let blurRadius = (1 - progress) * slice.typographicBounds.height / 3
            copy.addFilter(.blur(radius: blurRadius))

            // Animate vertical position
            let yOffset = (1 - progress) * -slice.typographicBounds.descent
            copy.translateBy(x: 0, y: yOffset)

            copy.draw(slice, options: .disablesSubpixelQuantization)
        }
    }

    private func elementDelay(count: Int) -> Double {
        (totalDuration - elementDuration) / Double(max(1, count - 1))
    }
}
```

### Using TextRenderer with Transitions

```swift
struct TextAppearTransition: Transition {
    func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .transaction { transaction in
                if !transaction.animation?.isSpring ?? false {
                    transaction.animation = .linear(duration: 0.9)
                }
            }
            .textRenderer(AnimatedTextRenderer(
                elapsedTime: phase.isIdentity ? 0.9 : 0
            ))
    }
}

extension AnyTransition {
    static var textAppear: AnyTransition {
        .modifier(
            active: TextAppearTransition(),
            identity: TextAppearTransition()
        )
    }
}

// Usage
struct TextTransitionDemo: View {
    @State private var showText = false

    var body: some View {
        VStack {
            if showText {
                Text("Visual Effects")
                    .font(.largeTitle)
                    .transition(.textAppear)
            }

            Button("Toggle") {
                withAnimation {
                    showText.toggle()
                }
            }
        }
    }
}
```

### TextAttribute for Selective Animation

Mark specific text ranges for special treatment:

```swift
struct EmphasisAttribute: TextAttribute {}

extension Text {
    func emphasis() -> Text {
        self.customAttribute(EmphasisAttribute())
    }
}

// Usage
Text("Welcome to ") + Text("Visual Effects").emphasis() + Text("!")
```

Then in your TextRenderer, check for the attribute:

```swift
func draw(layout: Text.Layout, in context: inout GraphicsContext) {
    for run in layout.flattenedRuns {
        let hasEmphasis = run[EmphasisAttribute.self] != nil

        if hasEmphasis {
            // Animate per-glyph
            for slice in run {
                // ... glyph animation
            }
        } else {
            // Simple fade
            context.opacity = progress
            context.draw(run)
        }
    }
}
```

## Animated Shader Example

```swift
struct AnimatedShaderView: View {
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

## Common Shader Effects

### Chromatic Aberration

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

### Vignette

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

### Noise/Grain

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

### Gradient Map

```metal
[[stitchable]] half4 gradientMap(
    float2 position,
    SwiftUI::Layer layer,
    half4 shadowColor,
    half4 highlightColor
) {
    half4 original = layer.sample(position);
    float luminance = dot(original.rgb, half3(0.299, 0.587, 0.114));
    half3 mapped = mix(shadowColor.rgb, highlightColor.rgb, luminance);
    return half4(mapped, original.a);
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
        renderEncoder.endEncoding()

        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}
```

### Cross-Platform Version

```swift
import SwiftUI
import MetalKit

#if os(iOS) || os(tvOS)
typealias ViewRepresentable = UIViewRepresentable
#elseif os(macOS)
typealias ViewRepresentable = NSViewRepresentable
#endif

struct MetalView: ViewRepresentable {
    func makeCoordinator() -> Renderer { Renderer() }

    #if os(iOS) || os(tvOS)
    func makeUIView(context: Context) -> MTKView { createMTKView(context: context) }
    func updateUIView(_ uiView: MTKView, context: Context) {}
    #elseif os(macOS)
    func makeNSView(context: Context) -> MTKView { createMTKView(context: context) }
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
6. **Debug UI** - Build parameter scrubbers for rapid iteration

## Best Practices

1. **Experiment boldly** - Turn parameters up to explore boundaries
2. **Live with effects** - Test over time to ensure they're pleasant, not distracting
3. **Context matters** - Effects should fit naturally within the larger app
4. **Build debug tools** - Scrubbers and visualizers accelerate development
5. **Consider accessibility** - Ensure effects don't impair usability

## Sources

- WWDC 2024 - Create custom visual effects with SwiftUI
- WWDC 2023 - Create custom visual effects with SwiftUI
- Apple Developer Documentation - Metal Shading Language
- Apple Developer Documentation - TextRenderer
- Apple Developer Forums - MetalKit in SwiftUI
