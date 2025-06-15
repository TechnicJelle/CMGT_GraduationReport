// The student must describe in the report the problem definition and the assignment, the applied methods,
// and the project approach process. This includes the literature used, how the result was achieved (using
// common steps in the professional field), a justification of the choices made, the conclusions drawn, and the
// recommendations related to the assignment. A reflection on the graduation period is also part of the
// report.

// Limits: +/- 10 000 words | +/- 25 pages  (+/- 10%)
//  Excluding preface, abstract, references, appendices.

#let show_tips_from_manual = false

#import "@preview/cheq:0.2.2": checklist
#show: checklist

#import "lib/00-setup.typ": style
#show: style

#import "lib/01-front.typ": front_page
#show: front_page

= Abstract

#if show_tips_from_manual [
_The abstract is situated at the beginning of your report. However, you can only write it at the very end as it
is meant to explain to any reader who will not read the entire report what information is in the report.
Here, the reader will find your main question, the key topics you investigated, a basic overview of the
iterations you made, and your conclusions and recommendations. You can use the guidelines from Scribbr:
How to Write an Abstract_
]

\/\/TODO


#pagebreak()
#import "lib/02-toc.typ": toc
#show: toc

= Glossary

Explanation of some (technical) terms, for people who don't know them yet.
These aren't explained in-text, to not disrupt the flow of the text for people who do actually understand the terms.
#v(1em)
- *Architecture:* Way a program is structured, and how the different parts of it interact with each other.
- *CPU:* Central Processing Unit. The main processor of a computer, which is responsible for executing most of the instructions.
- *Acceleration Device:* Hardware device that is specialized in a specific (type of) operation, to make that type of work faster than a general purpose device would be able to do.
- *GPU:* Graphics Processing Unit. An Acceleration Device that specializes in graphics calculations, but can also be used for more general purpose computing.
- *API:* Application Programming Interface. The "rules"/"contract" that a certain programming system offers; usually a set of functions that are able to be called by the programmer.
- *Graphics API:* API that is specifically designed for rendering graphics.
- *Compute API:* API that is specifically designed for general purpose computing. Often using an Acceleration Device, like a GPU.
- *GPU API:* An API that is specifically designed for interfacing with a GPU. Often a combination of a Graphics API and a Compute API. Many older GPU APIs did not have Compute support.
- *Low-level:* Offers a lot of control, at the cost of complexity. Is "closer" to the hardware, and thus can be very performant if used correctly, because it requires less translation to how the hardware actually works.
- *High-level:* Offers little control, but is often simpler #footnote[but *not* necessarily _easier_] to use. Is "further away" from the hardware, and thus can be less performant, due to less optimization potential.
- *Driver:* Software that allows the operating system to communicate with hardware devices, like a GPU.
- *Performance (Performant):* How fast a program is able to do its work, and how much resources it uses to do so.
- *Flexible:* How easy it is to change a program to do something else, or to add new features to it.
- *Parallel:* The process of doing multiple things at the same time, in parallel.
- *Retro:* Something that is old and outdated. Usually not used anymore, outside of specific communities.
- *Multi-threading:* Specific way to run things in parallel, by using multiple threads on the CPU.
- *Boilerplate:* Code that is needed to set up something, but does not actually do anything on its own.
- *Abstraction:* Process of making something more general, by removing some details that are not relevant for the current context.
- *Thin Abstraction:* An abstraction that is very close to the original API, and does not hide much of the original API's functionality.
- *Wrapper:* Library that wraps around another library or API, to make it easier to use, to add some extra functionality, to inject extra debugging information or to add additional safety checks.
- *Initialization:* Process of setting up something. In the context of this report, usually means setting up the GPU API, so that it is ready to be used.
- *Synchronization:* Process where multiple threads or devices wait for each other to finish their work, before continuing.
- *Barrier:* Synchronization point in the GPU pipeline, where the GPU waits for previous operations to finish before continuing. It doesn't necessarily have to block all operations of all types; you can also specify which types of operations to wait for. This allows multiple operations of the same time to happen without issues.
- *Verbose:* Programming style that is very explicit and detailed, that requires a lot of code to do something.
- *Obtuse:* Programming style that is very difficult to understand, or that requires a lot of effort to understand.
- *Compile-time:* Moment when the code is compiled, before it is run. This only needs to happen once, ever.
- *Startup-time:* Moment when the program is started, after it has been compiled. This happens every time the program is run.
- *Run-time:* Moment(s) when the program is actually running, after it has been started. This can happen multiple times, during the program's execution.
- *Black box:* System or library or API you can use, but not see how it works internally.
- *Proprietary:* Software or hardware that is owned by a specific company, and is not open source or open hardware. Often requires a license to use. Usually a black box with no transparency for internal workings.
- *Cross-platform:* Being able to run on multiple different platforms.
- *NDA:* Non-Disclosure Agreement. A legal contract that prevents the parties involved from disclosing certain information to third parties. Often used to protect proprietary software and hardware.
- *(Game) Console:* Specialized computer that is designed to run games, and usually has a custom, proprietary GPU API that you have to sign an NDA to get access to.
- *Operating System:* Software that manages the hardware and software resources of a computer, and provides services for computer programs. Examples are Windows, macOS, Linux, Android, and iOS.
- *Paradigm:* Style/way of doing things.
- *Render-graph:* Way of organizing that puts things in a graph structure, where each node represents a rendering operation, and the edges represent dependencies between them.
- *Scene-graph:* Way of organizing that puts things in a tree structure.
- *Ray tracing:* Method of rendering that simulates light bounces in a very realistic way. It is very computationally expensive, but can produce very realistic images. Many modern GPUs have dedicated hardware support for it, which makes it much faster.


#pagebreak()
= Introduction

#if show_tips_from_manual [
_Your report starts, of course, with the Introduction, which should include:_
- [x] _A general description of the company assignment_
- [x] _The (preliminary) problem_
- [ ] _The (end-)user_
- [ ] _The indicators of success of the client_
- [ ] _The parties and/or individuals involved in the development of your project_
	- [ ] _and their interests regarding your solution_

_A company outline, covering aspects such as:_
- [x] _how the company is organized_
- [x] _the number of employees_
- [x] _the departments_
- [x] _the markets the company serves_
- [x] _your role within the company_
- [ ] _etc._
]

In this report, I will describe the product I have first done research for,
and then developed during my Graduation Internship at Rythe Interactive.

During this process, I adhered to the Double Diamond @double-diamond design process model.

== Company

This graduation project is being done for the company Rythe Interactive.
Rythe is a very small startup company of just two employees, and an intern (me).

The product they are creating is the Rythe Game Engine, the aim of which is to be a modular yet performant game engine.
The modular nature makes it extra easy for companies to modify it to suit their own specific purposes,
without having to build an entirely new engine from scratch.

== Problem Definition

There are currently already multiple iterations of the Rythe Engine in existence.

The first version, Rythe Legacy, is so old that it still uses OpenGL.
OpenGL is bad for performance, due to the CPU usage required @vkguide-multithreading.
It can also not be properly multi-threaded, which is especially bad @khr-forum-multithreaded-rendering,
because one of the main goals of the engine is to make optimal use of *all* of the CPU and GPU, by making it as multi-threaded as possible.
The architecture of this version of the engine was too tightly integrated with OpenGL to be worth putting more effort into.

The first rewrite used more modern technologies, and had a dedicated renderer component called Rythe-LLRI, or "Rythe Low Level Rendering Interface".
It was a cross-platform GPU API abstraction, that was intended to be as low-level as possible to ensure maximum performance.
The LLRI is very old and was written before the Vulkan API had even properly released in 2016 @khronos-release-vulkan-1.0. It is also not finished.

Now, a second rewrite of the engine is being worked on, but it is still lacking a good rendering system.
Therefore, the LLRI component could also do with a rewrite, alongside the rest of the engine.

== Requirements and Constraints

The goal of the LLRI is to:
- Be portable to other GPU API's down the line (not necessarily immediately).
- Abstract away some implementation details, like initialization and placing barriers, that are more verbose and obtuse than they need to be,
  from the perspective of an engine user, who is implementing new graphics features into their game.
- Guarantee some safety checks that make it a bit harder for engineers to shoot themselves in the foot
  #footnote[Reference to the famouse quote _#quote("C makes it easy to shoot yourself in the foot; C++ makes it harder, but when you do it blows your whole leg off.")_ — #cite(<stroustrup-footguns>, form: "prose")],
  like ensuring that data is in the correct format and commands are sent in the correct order.
- Allow enough low level access to not restrict engineers from being able to design their own renderer architecture.
- Minimise overhead of the abstraction where possible, or at least move as much of it to
  compile-time or startup-time as possible.
- Allow Compute to be used, for even more control over the GPU, because Compute is often used in modern games,
  for dynamically generating data on the GPU.

=== Deliverable

At the end of the project, I will have a GitHub Repository with a few prototypes/experiments
with various GPU APIs and abstraction layers.
If there is time, I would also like to have a GitHub repository with a start of the actual LLRI2 library in it.

=== Indicators of Success

I'll have succeeded if I got the beginnings of a GPU API abstraction layer done.
Experimental prototypes with various GPU APIs and abstraction layers will be considered a success, too.
Those prototypes will show basic functionality needed for a rendering system,
such as rendering a spinning 3D model with a texture on it.

If I have gotten to the point where I have an initial prototype of the LLRI2 library itself,
I will verify and ensure that it is done enough by implementing the same as the prototypes,
but with the LLRI2 library instead.


#pagebreak()
= Theoretical Research

#if show_tips_from_manual [
_To understand what will make your product valuable and useful, and to set the conditions of satisfaction,
you need to gather a lot of information before you can start developing a solution. Regardless of the
design model you use, you will need to gain knowledge about the company, the actual problem behind the
question or idea that needs to be solved, the parties involved, what the client/user will do with the result,
the market, the users, the competitors, the trends, the technological possibilities and restrictions, etc.
Consider using the tools presented during Applied Research to structure this process, such as the people
value canvas, the empathy map, and the consumer trend canvas._

_The questions and answers, including how you found the answers, form an important first part of your
report. They reflect how you critically approached the client's question
and how you identified the actual main question of your graduation project._

_The preliminary research and formulation of the main question cover the Empathize and Define phases of
the Design Thinking method or the Discover and Define phases of the Double Diamond model. Detailed
information about the preliminary research and main question can be found in the Applied Research
section of the IMT&S module on Brightspace._
]

== GPU APIs

To make a good and performant rendering system, we need to interface with the Graphical Processing Unit (GPU).

There are many GPU APIs, like OpenGL, Vulkan, DirectX, Metal, and most consoles have their own specific ones.
All of these are compatible with different operating systems and platforms.

*OpenGL* is generally the most compatible with all kinds of hardware, but also the oldest and clunkiest, and is considered deprecated by many, myself included.
For that reason, OpenGL will not be mentioned much in this report, as it cannot really hold a candle to these other, more modern APIs.

*Vulkan* is a very low-level Acceleration Device API. #footnote[For the purposes of this report, I will consider it a GPU API.]
It was originally designed by researchers at AMD, under the codename "Mantle" @khronos-release-vulkan-1.0.
It was later donated to the Khronos Group, a consortium of many organizations that focuses on graphics @khronos-about,
who then developed it further into the Vulkan API that we know today.\
Vulkan is known as the most verbose GPU API, which is often used as ammunition to ridicule it, but being verbose has many advantages.
For example, being verbose means that it is much clearer about what it _actually does_.
And you also have more control over _what_ happens and _when_, which allows for extra optimization.
Of course that does come at the cost of development time and effort.
Vulkan is actually not exactly a GPU API, because it is more of a general-purpose Acceleration Device API.
GPUs are just one type of Acceleration Device.
However, for the purposes of this report, I will consider only the GPU aspects of Vulkan.

*DirectX* is for Windows and Xbox. In fact, the Xbox _only_ supports DirectX.
Windows itself does support more than just their own DirectX API, though.\
It is technically possible to run DirectX on Linux, through compatibility layers, like DXVK and vkd3d.
#footnote[For example, Valve makes use of them in their Proton software, which allows Windows games to run on Linux.]
However, it should be noted that these compatibility layers are not officially supported or endorsed by Microsoft, the developers of DirectX.

*Metal* is for Apple devices, which also don't (natively) support anything else.
#footnote[Technically, OpenGL does also work on macOS, but it is deprecated and thus not officially supported anymore.\
On top of that, it is limited to an older version (4.1 from 2011 @macos-opengl).
And the latest _normal_ OpenGL version is already old! (4.6 from 2017 @opengl46-release)]\
However, there is a very popular translation layer for running Vulkan on Apple devices, called MoltenVK.
MoltenVK is not officially supported by Apple, but it is part of the Khronos Vulkan Portability Initiative @moltenvk-2017.

PlayStation has two proprietary and "secret" APIs, called *GNM* and *GNMX* @schertenleib-2013.\
GNM is the low-level API, and GNMX is a higher-level wrapper around it @leadbetter-2013.\
Not much is publicly known about these APIs, because you need to sign an NDA to get access to the PlayStation Developer Kit.

Nintendo Switch also has a proprietary and "secret" API, called *NVN*.
This is the preferred API to use, but the Switch at least does _support_ Vulkan, too.
Not much is publicly known about this API, because you need to sign an NDA to get access to the Nintendo Switch Developer Kit.

#import "lib/03-api_compat_table.typ": api_compat_table
#figure(
	api_compat_table,
	caption: [An overview of Platform ↔ API Compatibility]
) <api_compat_table>

As we can see in @api_compat_table, Vulkan is the most cross-platform of any of these APIs,
being supported on Windows, Linux, Android, and Nintendo Switch, with compatibility layers existing for Apple devices.

This is why I will be starting with Vulkan as the first GPU API that I will be abstracting for the LLRI2.

However, when making actual applications, it is inconvenient and highly inefficient
to keep rewriting all Vulkan boilerplate from scratch for each new project.
This is why we make an abstraction layer on top of Vulkan, so it can be reused across multiple projects.

In this report, I will detail my efforts at making (the beginnings of) such a Vulkan Abstraction Layer.


#pagebreak()
== Possible Existing Solutions

#if show_tips_from_manual [
_Once the main question is formulated and acknowledged by your client, you can proceed to the next step
in the development process: generating ideas for possible solutions. We expect to see a range of possible
solutions, an evaluation of these ideas, and the selection of the final solution. You can use the techniques
for generating ideas presented during Applied Research. The evaluation can be conducted using a SWOT
analysis or COCD box._

_Showing and explaining the techniques you used to develop and select ideas in your report will provide
insight into the creative process, so take the opportunity to showcase this. As highlighted in the design
models, generating and selecting ideas is an iterative process, and it is expected that you will test a
selection of the ideas with the client and the user. Be sure to incorporate the iterations, including the tests
and results, in your report._

_More information can be found in the Applied Research section of the IMT&S module on Brightspace._
]

There already exist many GPU API abstraction layers. But, this is a good thing!
Because, in my experience, it is impossible to create an abstraction layer that is entirely unopinionated.

When making a big thing small, aspects of the big thing have to be dropped.

As such, depending on the opinions and preferences of the maker of the abstraction layer,
each abstraction layer will cut different aspects of the original API.
There can be no abstraction layer that keeps all aspects of the original API,
because then you would be right back at the original API.

There are many people who have gone before us in making abstraction layers,
so in this section, I will explore and research some of these GPU API abstraction layers that already exist.
Many of these abstraction layers use wildily different programming styles (paradigms), so I have categorised them.
After that, I will compare them and pick one (or a few) to do practical research with.
That entails making prototypes with them, to get hands-on experience with them, and to see how they work in practice.

I will be discussing the following paradigms:
Global State Machine, "Pipelines and Passes", Partial Abstractions, Rendergraph-based Abstractions, and Scenegraph-based Abstractions.
For each I will give a (small) description, list some already-existing implementations of it, and evalute its usefulness for this project.

After the prototyping, I will choose the paradigm to go ahead with for our own abstraction layer.


#pagebreak()
=== Global State Machine

State machines are a programming paradigm where there is some object that has a state,
upon which functions can be called that change the state of the object.
These objects are usually initialised with a pre-set state @state-pattern-nystrom.
They are very useful, but can get out of hand when the state starts encompassing too many things.
Or when the state is globally accessible, and can be changed from anywhere in the code @global-state-so @global-state-cneude.

Global State Machines are nevertheless a popular paradigm for GPU APIs.
It was especially common in APIs of the past, but is still used in some simpler abstractions today.
They often require relatively little code to get something up and running,
due to the initial state already being set up with default values.
They are very convenient for _small programs_, but can very quickly become unwieldy for larger programs.

There are two types of Global State Machine API: immediate-mode and buffer-paradigm.

Immediate mode entails that the programmer sends every tiny instruction to the GPU in many separate GPU calls.
This is *extremely* slow, because modern GPUs much prefer chewing through large datasets and instructions in one go,
rather than receiving one single instruction per call.

This is why the newer paradigm introduced buffers. Buffers are large sets of data that are copied to the GPU in one go.
The binding instructions of what to actually do with that data are usually still pretty small and separate calls, though,
and many are required at the beginning of each frame to set up the correct state for the GPU.

(This is what Pipelines and Passes APIs solved by encouraging setting up all of that state beforehand in a pipeline.
Then, at run-time, switching between pipelines is just a single call, instead of many separate ones.)

OpenGL, a really old GPU API #footnote[The last release, 4.6, was in 2017, and it is not in development anymore. @opengl46-release],
and older versions of DirectX actually were global state machines already @opengl-concepts.
Modern GPU APIs have moved away from this kind of architecture, because they were extremely cumbersome to work with, and often very slow.

Modern GPU APIs also match the things that are actually happening on a hardware level more closely than these older APIs.

Despite the aforementioned cons, some people still like the paradigm of global state machine APIs.

Most of these do not support Compute, but only Graphics, because Compute is a more recent addition to GPU APIs.
Compute was added to OpenGL in version 4.3, which is famously not supported by MacOS, to the chagrin of many developers.

==== Existing implementations

Immediate-Mode paradigm API:
- OpenGL Legacy (1.0 up to, but not including, 3.0)
- Direct3D 7 and before
- raylib's #link("https://github.com/raysan5/raylib/blob/master/src/rlgl.h")[rlgl.h].
  Provides a pseudo-OpenGL 1.1 immediate-mode style API, overtop modern OpenGL, with some optimizations, like batching.
  Supports both Graphics and Compute.

#pagebreak()
Buffer-paradigm APIs:
- OpenGL Modern (3.0 and later)
- Direct3D 8 to 11 (12 is a Pipelines and Passes-paradigm API)
- #link("https://github.com/bkaradzic/bgfx")[bgfx]. A rendering library with many backends and supported platforms,
  but with some more features than just direct GPU access, like text rendering. Supports both Graphics and Compute.

==== Evaluation

These abstractions are too high-level for Rythe, and global state is difficult to work with and reason about.
Global state machines also don't have enough potential for optimization,
because, depending on the specific API, it may be nigh-impossible to straight-up impossible to properly multi-thread.
This is a problem, because multi-threading is a very important aspect of the Rythe Engine.

Taking OpenGL, which is the most common API of this paradigm, as an example,
it is not possible to send commands to the GPU from multiple threads at the same time.
Engines that use OpenGL usually just have two threads:
one Game Thread, and one Render Thread on which essentially all OpenGL stuff happens @vkguide-multithreading.
This definitely helps compared to running everything on a single thread, but is still very much not enough for a modern game engine.


#v(4em)
=== Pipelines and Passes

Pipelines and Passes are the two main concepts of most "modern" GPU APIs.
Sadly I was not able to find a better actual term for this paradigm, so I will just call it "Pipelines and Passes".

These APIs encourage batching big instructions together on the CPU, and then sending them to the GPU in one go,
to reduce the amount of communication between the CPU and GPU, which in turn improves performance.
"Pipelines" are set up beforehand (rarely at runtime), and contain a lot of static information that doesn't change every frame, like shaders.
Then during runtime instructions and data are encoded into "command buffers" that are combined into "passes" in one go.
Synchronization with the CPU is minimized and explicit, instead of implicit, like many other APIs do (especially older ones, and ones that aren't meant for optimization).

Back in 2016, AMD released an experimental new GPU API called Mantle @khronos-release-vulkan-1.0.
This was the first Pipelines and Passes API.
AMD then donated it to the Khronos Group, who turned it into Vulkan, and continued developing it.
Khronos is also the main driving force for making it as cross-platform as it is.
In the meantime, Microsoft and Apple were also inspired by Mantle, and created DirectX 12 and Metal, respectively, based on it.

Pipelines and Passes are also the main concepts of Vulkan (and other modern GPU APIs, like DirectX12 and Metal) itself,
so you could call abstractions that use this same paradigm "flat abstractions".
With this I mean that these abstractions very closely mirror the original GPU API, except that they are simplified.
However, they do contain and use the same core principles, namely the Pipelines and Passes paradigm.

==== Existing implementations

- #link("https://wiki.libsdl.org/SDL3/CategoryGPU")[SDL3's GPU API]. A new GPU API that is meant to be a low-level abstraction of Vulkan, DirectX 12, and Metal, and console APIs.
  But it is not _too_ low-level, either, where you spend a lot of time writing meaningless boilerplate.
  It looked at what is actually commonly used in these APIs, and implemented only that. Supports both Graphics and Compute.\
  It aims to run on as many (non-retro) devices as possible, including even consoles!
  This comes at the cost of not supporting many modern GPU features, like hardware raytracing, mesh shaders, and bindless resources.
- #link("https://developer.mozilla.org/en-US/docs/Web/API/WebGPU_API")[WebGPU]: WebGPU is officially a JavaScript API meant for web browsers,
  but there are multiple native implementations of it, like #link("https://github.com/gfx-rs/wgpu")[wgpu-native] and #link("https://dawn.googlesource.com/dawn")[Dawn].
- #link("https://github.com/floooh/sokol")[Sokol]: A modular, but minimal application framework, of which the "gfx" component is also a "pipelines and passes" abstraction.
  Supports both Graphics and Compute.
  (Ironically enough, this one doesn't _actually_ abstract Vulkan, but _does_ abstract almost all other GPU APIs)
- Diligent Engine's #link("https://github.com/DiligentGraphics/DiligentCore")[Core]: A GPU Abstraction layer that supports very many platforms.
- #link("https://github.com/facebook/igl")[IGL]: A cross-platform GPU abstraction layer by Facebook, mostly developed for their Quest VR headsets.
  It is pretty new.
- #link("https://github.com/corporateshark/lightweightvk")[LightweightVK]: A "deeply refactored fork" of IGL, which specifically abstracts modern Vulkan,
  and only exposes modern features, like bindless resources, mesh shaders and hardware raytracing.
- #link("https://github.com/veldrid/veldrid")[Veldrid]. A GPU API abstraction layer specifically for C#sym.hash. Most other ones are either C or C++.
  For a pipelines and passes abstraction, it is relatively high-level.
  (I intend to specifically take inspiration from this one for our own abstraction, as it manages to keep things very nice and short.)
- RavEngine's #link("https://github.com/RavEngine/RGL")[Graphics Library]: A thin C++ GPU API abstraction layer, with many convenience features,
  like shader compilation and reflection, and a very modern syntax.
- #link("https://github.com/Devsh-Graphics-Programming/Nabla")[Nabla]: Abstracts only Vulkan: "a curated set of Vulkan extensions and features".
  Because Vulkan gets new features relatively often, developers often have to re-learn parts of Vulkan.
  This library aims to always use the latest features in the background, while keeping a consistent API for the user.
- #link("https://github.com/NVIDIA-RTX/NVRHI")[NVRHI]: NVIDIA's own cross-platform GPU API abstraction layer.
  It does not support many platforms, though; only Windows and Linux, but it does expose quite a few modern GPU features, like hardware raytracing.

==== Evaluation

I have tried a few of these APIs in the past, namely Veldrid, WebGPU, and SDL3's GPU API.

Veldrid is quite high level already, but quite nice to work with, due to the relative lack of boilerplate.
Sadly, it has become unmaintained, but it can still serve as inspiration for our own abstraction.

WebGPU is almost a nice API, but due to some design decisions and internal politics, it is not as good as I would have liked.
Especially because it's officially only a JavaScript specification,
which means that the native implementations have to just do their best to resemble it.
This has not gone very well, and the various native implementations are not very consistent with each other.
It also prescribes a custom shader language, of which the syntax is similar to the Rust programming language,
the style of which is too different from the style of C/C++ code that the Rythe Engine is written in to be neatly comprehensible together.

However, I really ended up liking SDL3's GPU API. The documentation is excellent, and it is incredibly pleasant to use.
It still allows for a lot of low-level access, while also being very user-friendly and cross-platform.
It achieves this by not just abstracting Vulkan, but also DirectX 12 and Metal (and console APIs, as well).

This is the paradigm I'll go with for our own abstraction layer, as it is the most flexible, powerful, and efficient.


#pagebreak()
=== Partial Abstractions

The abstractions mentioned before are abstractions over the _entire_ underlying API(s)
and (usually) don't allow access to the internals like the raw Vulkan API it is abstracting.

But these "partial abstractions" are libraries that abstract only _parts_ of the Vulkan API,
while still allowing direct access to the raw Vulkan API in other places.

You can use multiple of these together, for their different purposes.

These are also sometimes referred to as "helper libraries".

- #link("https://github.com/zeux/volk")[Volk]: Dynamically load Vulkan functions at startup-time, instead of linking with Vulkan at compile-time. It may be faster than loading them trough the driver.
  Many Vulkan examples use this library, because it is very small and easy to use. Many other helper libraries also optionally integrate with it.
- #link("https://github.com/charles-lunarg/vk-bootstrap")[vk-bootstrap]: Helps with the initialization of Vulkan, by providing a set of functions that set up the most common things.
- AMD's #link("https://github.com/GPUOpen-LibrariesAndSDKs/VulkanMemoryAllocator")[Vulkan Memory Allocator]: Abstracts away many parts of Vulkan's memory management,
  and provides a simple interface for allocating and freeing memory for specific tasks.

==== Evaluation

I have made a Vulkan program in the past that used no partial abstractions,
and while it was cool to see how it all works and a good learning experience,
it is unlikely to be necessary to do all that again.

So we might use one or multiple of the above in our own abstraction,
after I have conducted some experiments with them.

=== Other types of Abstractions

There are other types of abstractions that are not really relevant for this project, because they are too high-level,
and hide too much of the underlying API to be able to create our own architecture on top of.
Opinions are good in libraries, but Rythe also wants users to be able to have their own opinions too,
and these abstractions take away some of that agency.

Nevertheless, they are still interesting technologies that I want to mention.

- #link("https://github.com/martty/vuk")[vuk]: A render-graph-based abstraction layer for Vulkan.
- AMD's #link("https://github.com/GPUOpen-LibrariesAndSDKs/RenderPipelineShaders")[Render Pipeline Shaders]: A render-graph-based abstraction layer for Vulkan and DirectX 12.
- #link("https://github.com/asc-community/VulkanAbstractionLayer")[Vulkan Abstraction Layer]: A render-graph-based abstraction layer for Vulkan.
- #link("https://github.com/vsg-dev/VulkanSceneGraph")[Vulkan Scene Graph]: A scenegraph-based abstraction layer for Vulkan.


#pagebreak()
== Final Selected Solution(s)

The abstraction will be a Pipelines and Passes paradigm API, in which I may use some already-existing partial abstractions.

The reasoning is that this paradigm is just by far the most flexible and powerful.

=== About C and C++

Most of the existing GPU APIs are published in C, because it's the most fundamental language that is still widely used,
and it is relatively easy to interface with from other languages.

However, the Rythe Engine is written in C++, which can easily use C libraries.
So the LLRI2 library will be written in C++, so it might be able to benefit from some C++ features,
like classes, RAII, and templates, for example.\
But the biggest reason to stick to C++ is the ability to use the Rythe Standard Library, which is written in C++,
and to be able to interface with existing Rythe code in a two-way manner.\
Rythe is not against writing C libraries nor against using them,
but C code generally does not invoke and use C++ code, unless the C++ code is specifically designed to be used from C code.


#v(5em)
= Research Questions

For this project I will be working on creating the (start for a)
rendering system for the new version of the Rythe Game Engine.
This product could serve as the base for the complete LLRI rewrite.

== Main Research Question

My main research question is:
#v(1em)
#align(center)[_
	How can I develop a good start for a flexible,\
	yet performant cross-platform GPU API abstraction?
_]
#v(1em)

== Sub-questions

As part of this research, there are a few sub-questions that also need to be answered:
- How do you properly benchmark an in-house (graphics) engine?
- What are further potential avenues for more optimisation?


#pagebreak()
= Implementation

#if show_tips_from_manual [
_Once you have selected the most promising idea or ideas, you can start working on the prototype(s). As
explained in the Design Thinking module in year 1, quartile 1, prototyping involves creating basic models
or designs for a machine or other product. The prototyping phase will help you get closer to a valuable and
usable product by validating the ideas you have generated. If done correctly, prototyping will create useful
feedback that enables midflight corrections._

_Prototypes can be anything a user can interact with, such as sketches, storyboards, posters, handmade
gadgets, interactive applications, diagrams and frameworks, virtual models, videos, etc. Using a
combination of high-fidelity and low-fidelity prototypes during the design process will provide valuable
feedback that can be applied to make your design process iterative._

_Use your report to justify the choices you made regarding the combination of prototypes and the various
iterations you conducted._
]

At first, I had planned to make a few prototypes with different APIs and abstraction layers,
that all had a lot of features that were important to have in an abstraction layer.

I had planned to use the Vulkan prototypes as a base for our abstraction layer.
If I find the already-existing partial abstractions useful enough, I will use those in our abstraction.

However, making all those prototypes with all those features was taking very long, as I really should have expected.
So I decided to focus on just two prototypes: one with SDL3's GPU API, and one with Vulkan
(with partial abstractions, hereafter also referred to as "helper libraries").


== SDL3's GPU API Prototype (Iteration 1)

I started with this prototype, because it is the one I was most curious about at that time.
I had already used Vulkan in the past, so I wanted to first try something new that promised to be more user-friendly.

And it delivered on that promise; the API is very nice to use, and the function documentation is excellent.
The examples are also okay, though they do take some untangling,
if you want to follow them closely, because they pack a lot of functionality into one example.

There is sadly also no full guide, yet, like LearnOpenGL @learnopengl, Vulkan Tutorial @vulkan-tutorial, or VkGuide @vkguide.

Nevertheless, I managed to get a triangle on screen pretty quickly, after which I started adding more features.
//TODO: Write more

== Vulkan with Helper Libraries Prototype (Iteration 2)

After I was in a nice place with the SDL3 prototype, I started working on the Vulkan prototype.
I had already used Vulkan in the past, so I was at least a bit familiar with it already.

Last time, I followed the Vulkan Tutorial @vulkan-tutorial, which is a very good resource for learning Vulkan.
But it teaches you how to do everything from scratch, and only teaches Vulkan 1.0.

There is another popular resource for learning Vulkan, called VkGuide @vkguide, which uses some helper libraries,
namely Vulkan Memory Allocator and VkBootstrap, but not Volk, so I had to add that myself.
//TODO: Write more

// Things VkGuide taught me:
// - No more vertex attributes, vertex pull only.
// - No renderpasses, dynamic rendering only.
// - Imgui as part of the main tutorial.
// - Loading entire glTF scenes from blender and rendering them at high performance in a fully dynamic way.
// - The first draw operations are done through compute shaders, demonstrating them.
// - Window resizing.
// - Vertex buffers are done through Buffer Device Address, no binding needed
// - Descriptor set abstractions in the main tutorial
// Source: https://www.reddit.com/r/vulkan/comments/18sxbto/vkguide_new_version_released_with_a_complete/


#pagebreak()
= Testing

#if show_tips_from_manual [
_To fully benefit from the prototypes you developed and to get the feedback needed to further narrow down
the number of ideas or improve your concept/product (i.e., to conduct the next iteration), the use of
suitable test methods will be highly beneficial. The basis for this is a proper test plan to conduct one or
more tests. Select the methods that were presented to you during Applied Research, choosing those that
are suitable for professional practice within the context of your graduation project._

_To write a test plan, you can use the template provided during Applied Research. The test plan and the
results of the various tests are important components of your report. To find the best way to present the
test results, you can refer to the relevant section of Applied Research on Brightspace_
]

With the two prototypes I have made, I can do performance testing,
to compare the performance of the different APIs and abstraction layers.

== Methodology

I will make both programs do exactly the same thing, so that I can compare them fairly.
After that, I will unlock the framerates of both programs, and create a pre-allocated array of a few thousand elements,
which I will fill with that frame's frametime, measured in nanoseconds.
At the end, once those arrays are filled, the array gets written out to a file, and the program will close.

Naturally, I will run both programs in Release mode, to allow the compiler to optimize it.
If there is time, I will also run them in Debug mode, to see how much the performance differs between the two modes,
and in a "Mixed mode", where all the dependencies are compiled in Release mode, but the program itself is compiled in Debug mode.

With those two files full of frametimes, I can then compare the two programs' performance, by graphing the data.
All the values will be displayed in microseconds (µs),
because nanoseconds are too small to be useful for this kind of data, and milliseconds (ms) are too large.

I will create a line plot and a histogram of all the frametimes, and calculate the following statistics:
- The average frametimes
- The standard deviation
- Highs (1%, 0.1%, 0.01%)
- Lows (1%, 0.1%, 0.01%)
- The frame-to-frame deviation of the frametimes //TODO

I will also graph the occurrences of each frametime, to see how many frames were rendered with which times.
This is useful to see the grouping of the frametimes, and to see if there are any outliers.

These plots will be made with the Python library Matplotlib, which I also used for a previous project,
so I can largely re-use the scripts I wrote for that project.


#pagebreak()
== Performance Testing (Benchmarking)

Here are the results of the performance testing of the two prototypes I made.

There are three attempts, to ensure fair measurements in regards to run-to-run variations.

Attempt 001 is not included in this section, as its results were suspiciously out of balance.
You can read more about that in @wait-idle-debacle.

These were compiled with GCC 15.1.1, in Release Mode.

They were run on:
- *OS:* Manjaro Linux Zetar 25.0.3 (XFCE Edition)
	- *Kernel Version:* 6.6.90-1-MANJARO
- *CPU:* AMD Ryzen 7 5800H CPU
- *RAM:* 16GB
- *GPU:* NVIDIA GeForce RTX 3070 Laptop
	- *GPU Driver Version:* 570.144


#pagebreak()
=== Attempt 002

#import "Plots/Output/Attempt 002 - No more WaitDevice, Closed Everything/table.typ": table002
#figure(
	table002,
	caption: [Statistics of run #sym.hash​002 of the performance tests]
) <att002_table>

#figure(
	image("Plots/Output/Attempt 002 - No more WaitDevice, Closed Everything/plot.svg"),
	caption: [Line plot of the frametimes of run #sym.hash​002 of the performance tests]
) <att002_plot>

#figure(
	image("Plots/Output/Attempt 002 - No more WaitDevice, Closed Everything/hist.svg"),
	caption: [Histogram of the frametimes of run #sym.hash​002 of the performance tests]
) <att002_hist>


#pagebreak()
=== Attempt 003

#import "Plots/Output/Attempt 003 - Same as 002, but again/table.typ": table003
#figure(
	table003,
	caption: [Statistics of run #sym.hash​003 of the performance tests]
) <att003_table>

#figure(
	image("Plots/Output/Attempt 003 - Same as 002, but again/plot.svg"),
	caption: [Line plot of the frametimes of run #sym.hash​003 of the performance tests]
) <att003_plot>

#figure(
	image("Plots/Output/Attempt 003 - Same as 002, but again/hist.svg"),
	caption: [Histogram of the frametimes of run #sym.hash​003 of the performance tests]
) <att003_hist>


#pagebreak()
=== Attempt 004

In this measurement, the first frametimes of the SDL3\_GPU prototype was very high.
But I suspect that that is the cause of the high standard deviation.
I did not remove it from the data, though, because I wanted to keep the data as raw as possible.

#import "Plots/Output/Attempt 004 - Same again/table.typ": table004
#figure(
	table004,
	caption: [Statistics of run #sym.hash​004 of the performance tests]
) <att004_table>

#figure(
	image("Plots/Output/Attempt 004 - Same again/plot.svg"),
	caption: [Line plot of the frametimes of run #sym.hash​004 of the performance tests]
) <att004_plot>

#figure(
	image("Plots/Output/Attempt 004 - Same again/hist.svg"),
	caption: [Histogram of the frametimes of run #sym.hash​004 of the performance tests]
) <att004_hist>


#pagebreak()
= Conclusion

#if show_tips_from_manual [
_You are heading towards the finalization of your graduation project and the conclusion of your report. This
means you will round off your report by answering the main question you formulated at the start by
drawing conclusions._
]

The performance testing has shown that SDL3's GPU API is essentially on par with Vulkan,
except that it does have more highs and lows, which is a sign of less consistent performance.

The other side of that coin is that SDL3's GPU was much easier to use than Vulkan,
and it took significantly less time and effort to get the same results.

So, in conclusion, it is certainly possible to make an LLRI2 library with Vulkan directly,
with the help of some partial abstractions, but it could also be made on top of SDL3's GPU API.
That does come at the cost of a little bit of frame-time consistency, and lack of some modern GPU features,
but it is a lot easier to use.


#v(3em)
= Recommendation

#if show_tips_from_manual [
_Based on the conclusions, you will complete the project with recommendations,
providing your view on valuable follow-up actions for your client._

_During Applied Research, it is explained how to present conclusions
and recommendations. You will find this information in the relevant section on Brightspace._
]

I recommend that Rythe continue with the development of the LLRI2 library, using Vulkan as the first base GPU API to build on top of.
Because one of the goals of Rythe Engine is to do as much as possible in-house,
to be able to squeeze out the utmost performance as possible, and for transparency reasons that make debugging easier.
Some partial abstractions can be used to make the development easier, like Volk, Vulkan Memory Allocator and VkBootstrap.

But it might also be considered to use SDL3's GPU API as the base for the LLRI2 library in the form of a fork,
instead of a layer on top. If the licensing allows this, of course.
That way, we have more control again, but also a very nice head-start.
We could then also implement more modern GPU features that Rythe wants to support,
such as Bindless Textures and hardware raytracing.
If that happens, it should be considered whether to only use SDL3's Vulkan implementation,
or whether to keep supporting the other APIs that SDL3's GPU API supports, like DirectX 12 and Metal.
And it should also be considered whether to "upgrade" it to C++, because SDL3's GPU API is in C.

I cannot make this decision for Rythe, but whatever they choose, I propose they hire me to continue the work on LLRI2,
as I have already done a lot of research and prototyping for it.


#pagebreak()
== Further Research

=== Bindless Textures

The concept of Bindless Textures should be looked into.

Bindless Textures are a way to use textures without having to bind them to a texture unit first.
This is less safe, but more performant.
Research should be done into whether it is possible to create an abstraction for Bindless Textures that is relatively safe.

It apparently has the potential to be _much_ faster than Bindful Textures, which is the current standard.
Even though Bindless Textures have already existed for a very long time (2009 at least), still not all hardware supports it.
Research should be done into which hardware supports it, and whether it is worth it to use Bindless Textures in the LLRI2 library.
And possibly _only_ Bindless Textures, if it is supported by all hardware that Rythe wants to support.

Bindless Textures were supported in OpenGL, and Vulkan also supports various Bindless techniques,
but they are, of course, more involved than OpenGL. @opengl-bindful-to-vulkan-bindless @bindless-vulkan

When comparing bindless OpenGL to bindful OpenGL, the speedup can be 7x, according to NVIDIA. @bindless-opengl @bindless-opengl-slides
I suspect such high performance gains won't be achievable with Vulkan,
but only because properly written bindful Vulkan is already faster than bindful OpenGL.

=== Other Abstraction Layers

It might also be worth looking into the other promising frameworks and abstractions I've found, like Diligent Engine, Nabla, and NVRHI.
They might provide interesting insights into how to structure the LLRI2 library.

Or perhaps they could even be used as a base for the LLRI2 library as a layer on top, or as a fork.
If the license is permissive enough, of course.

#v(5em)
= Discussion

#if show_tips_from_manual [
_In the discussion chapter, you are expected to critically reflect on your design process and solution._

_You can ask questions such as:_
- _how valid the research you conducted is_
- _how reliable the test results are_
- _the suitability of the methods used_
- _what went well and what did not go so well_
- _the value of the insights you presented to your client_
- _and most importantly, to what extent you solved the problem of the client or the user_
_It’s important to show a critical but fair view on these topics._
]

Looking back, I am very content with the way I researched, and the things I found and learned.
I have learned a lot about modern GPU APIs, and how to use them.

I feel like the test results are quite reliable, as I tried my best to keep the testing conditions between both as similar as possible.
Both the input and the situation were the same, and I ran each program multiple times to ensure that the results were consistent.
Although there is one thing that was a bit strange about the first run, which I will discuss in the next section.

Hopefully, the results of this research and testing will be useful for Rythe in the future,
when they continue the development of the LLRI2 library.
I feel like I have provided them with a good start for the LLRI2 library,
and I hope they will continue the work I have started. With or without me.

#pagebreak()
== Waiting for GPU Device Idle<wait-idle-debacle>

For the testing, Glyn and I decided to make the GPU APIs wait until the GPU Device is idle before measuring each frametime.
The idea there was that it would accurately measure both the CPU and GPU time it takes to render a single frame.
However, SDL's `SDL_WaitForGPUIdle(device)` function clearly does something else than Vulkan's `vkDeviceWaitIdle(device)`,
because the SDL GPU program was _significantly_ faster than the Vulkan program, as you can see in @att001_table, @att001_plot, and @att001_hist.

#import "Plots/Output/Attempt 001 - WaitDevice, IDE Open, Right after first compile/table.typ": table001
#figure(
	table001,
	caption: [Statistics of run #sym.hash​001 of the performance tests, from when the wait calls were included]
) <att001_table>

#figure(
	image("Plots/Output/Attempt 001 - WaitDevice, IDE Open, Right after first compile/plot.svg"),
	caption: [Line plot of the frametimes of run #sym.hash​001 of the performance tests, from when the wait calls were included]
) <att001_plot>

#figure(
	image("Plots/Output/Attempt 001 - WaitDevice, IDE Open, Right after first compile/hist.svg"),
	caption: [Histogram of the frametimes of run #sym.hash​001 of the performance tests, from when the wait calls were included]
) <att001_hist>

Without those two wait calls, they were about the same speed.
Hence, I removed those wait calls again from both programs for the actual performance testing.


#pagebreak()
= Reflection

#if show_tips_from_manual [
_At the end of your report, you will include a self-reflection, containing what you consider your strong points
and what aspects need to be strengthened as a young professional, and how you would position yourself in
the industry. It’s valuable to not only look back but also ahead to the industry you will soon enter._
]

Due to many circumstances, both personal and external,
I did not manage to get as much done as I would have liked to,
so the scope of this project had to be reduced halfway through.

I should have expected that the prototyping would take longer than I had initially thought.
I had hoped to have been able to start on the LLRI2 library itself, but I did not manage to get that far.

Even so, I have learned a great deal during this project, and I am very proud of the work I have done.
Both the prototypes and the research.

So on the whole, I am still very happy with the results of this project.

With the knowledge I have gained during the development of these prototypes,
I feel like I am now pretty well-equipped to join the workforce as a junior graphics programmer.


//Stop numbering headings from here on out
#set heading(numbering: none)
#pagebreak()
= Appendices

== Showcase of the End Product

The prototypes I made can be found on GitHub, under the Rythe Interactive organisation:
https://github.com/Rythe-Interactive/LLRI2-Experiments

You can see the prototypes in action on YouTube:
https://youtu.be/a92zA46ItHg


#v(3em)
== Acknowledgements

I'd like to take this moment to thank my friends and family who helped and supported me during this project
with their advice, rubber ducking, and moral support!

A special thanks to my data data scientist #footnote[PhD student in the field of Astronomy] friend,
who helped me write and adapt my graphing scripts.

And more special thanks to the friends who proofread this report, and provided me with valuable feedback.

And thanks to Glyn, my Company Coach, and Yiwei, my Internship Coach, for their guidance and support during this project.

#pagebreak()
== Competences Reflection

=== I. Technological competences
==== 1. Technical research and analysis

#if show_tips_from_manual [
_The starting professional has a thorough knowledge of the current digital
technologies within that part of the field of work the training course aims at.
The starting professional can conduct technical research and analysis_
]
During this project, I solidified my knowledge of modern GPU APIs, by doing a lot of research into them,
both theoretically, by reading online, and practically, by making prototypes with them.

I also got more hands-on experience with multiple promising GPU APIs, like SDL3's GPU API and Vulkan.
In regards to Vulkan, I also learned how to use some common partial abstractions, and some more modern features of Vulkan,
like modern synchronization, dynamic rendering, and compute shaders.

I also learned about the different paradigms that GPU API abstraction layers might have.

==== 2. Designing and prototyping

#if show_tips_from_manual [
_The starting professional can create value by iteratively designing and prototyping,
based on a (new) technology, creative idea or demand articulation.
The starting professional shows an innovating, creative attitude at defining,
designing and elaborating a commission in the margin of what is technically and creatively feasible._
]

During the development, I kept in close contact with Glyn, my company supervisor,
about my findings and progress. He provided me with valuable feedback and ideas,
many of which I implemented.

I also talked online with other graphics programmers, who provided me with valuable insights into the design of GPU APIs,
and which features are important to have in an abstraction layer.

The code of the prototypes is reasonably modular, so that it can easily be repurposed for the LLRI2 library.

==== 3. Testing and rolling out

#if show_tips_from_manual [
_The starting professional is capable of repeatedly testing the technical results,
that come into being during the various stages of the designing process,
on their value in behaviour and perception.
The starting professional delivers the prototype/product/service
within the framework of the design, taking the user, the client and the technical context in due consideration._
]

When I was developing of the prototypes, I did a _lot_ of testing.
During that testing, I was helped a lot by the Vulkan Validation Layers.
They kept pointing out my mistakes, and sometimes even suggested how to fix them.
I learnt a lot from that, too.

I also did performance testing in multiple ways. Once with wait calls, and once without.

Sadly, there was no user testing, because the prototypes that took up all of the development time were not user-facing.
If I had had more time, I could have started work on the LLRI2 library itself, which would have been user-facing,
and I could have done user testing on that.

But even without that user testing, I still managed multiple iterations of the prototypes.

=== II. Designing competences
==== 4. Investigating and analysing

#if show_tips_from_manual [
_The starting professional can substantiate a design commission by means of research
and analysis. The starting professional, in their investigation activities, shows to
have a repertoire of relevant research skills at their disposal and can select from
this repertoire the proper method, given the research circumstances. Is capable of
developing prototypes as a communication tool within the context of implementation._
]

I did a lot of research online, by reading official documentation, articles, blog posts,
and talks given at conferences, like Vulkanised.
Glyn lent me a few Vulkan books, too, which I read a bit of, but I didn't have time to read them all, as they are VERY thick.

Last year, I even attended The Graphics Programming Conference 2024 in person, where I also learnt a lot.

I specifically always prioritized up-to-date sources, because graphics programming is a very fast-moving field.

I also did a lot of practical research, by making prototypes with various APIs and libraries.

Even online communities were a great source of information,
and I often talked about graphics programming there with others, to get more insights.

==== 5. Conceptualizing

#if show_tips_from_manual [
_The starting professional proves capable of being able to get to realistic (cross-
sectoral) demand articulation and project definition. The starting professional can
develop an innovative concept that creates value based on their own idea or
demand articulation._
]

Together, Glyn and I came up with some abstract plans, which I was then able to turn into concrete prototypes.

==== 6. Designing

#if show_tips_from_manual [
_The starting professional shows themself capable of presenting both their person
and their work professionally and well-groomed to third parties. The starting
professional shows themself capable of being able to communicate with a client
about choices and progress in the design process._
]

I structured the code for the multiple prototypes in a single Git repository, hosted on GitHub.
The build system uses CMake, so it is cross-platform and cross-IDE.
The CMake code is shared across the prototypes, so that it is easy to add new prototypes later on.

The final result is _not_ market-ready, specifically because they are prototypes,
but they are a good start for the LLRI2 library, which was the goal of this project.

=== III. Organisational competences
==== 10. Communication

#if show_tips_from_manual [
_The starting professional shows themself capable of presenting both their person
and their work professionally and well-groomed to third parties. The starting
professional shows themself capable of being able to communicate with a client
about choices and progress in the design process._
]

I always kept Glyn up to date with my progress, and I often asked him for feedback on my prototypes.
Other than that, there were no other stakeholders involved in this project, to communicate with.

=== IV. Professional competences
==== 11. Learning ability and reflectivity

#if show_tips_from_manual [
_The starting professional shows themself to be a ‘reflective practitioner’ by
constantly analysing and adjusting their own action, fostered by feedback of others.
The starting professional shows themself permanently directed and capable of
being able to keep up with relevant developments in the field of expertise. The
starting professional can further develop and deepen the craftsmanship, the personal
substantiation of the professional situation and their creativity._
]

During the development of these prototypes, I continuously reflected on my own work,
and always strived to make it better with every new line of code I wrote.

I also asked Glyn and others for feedback on my work, and I always took that feedback to heart.

==== 12. Responsibility

#if show_tips_from_manual [
_The starting professional has a capacity for empathy with other sectors and shows
awareness of ethical issues in their role as a designer and can explicitly make such
considerations in accounting for choices in the design process._
]

I always tried to keep the ultimate end user of the Rythe Engine in mind when creating the prototypes,
to hopefully one day make their lives easier, too, with the engine, built with the LLRI2 library.

I also always did my best to create the best possible code I could,
even though sometimes that came back to bite me later on.
From those moments, I learnt that sometimes you should not try to make things too pretty the first time around,
and to leave the refactoring for later, once you have a better idea of what needs to be done.

There are no proprietary technologies used in the prototypes, so there are no ethical issues there.

#pagebreak()
= Bibliography

#bibliography(
	"references.bib",
	style: "american-psychological-association",
	title: none,
)


#pagebreak()
= List of Figures

#let figureOutline = {
	show outline.entry.where(level: 1): set outline.entry(fill: align(right, repeat(text(weight: 100, "."), gap: 0.3em, justify: false)))
	set text(weight: 0) //reset font weights
	show outline.entry: it => {
		show regex(`^.+\s+\d+`.text): set text(weight: 200) //prefix
		show regex(`\d+$`.text): set text(weight: 300) //page number
		it
	}

	outline(title: none, target: figure)
}
#figureOutline


