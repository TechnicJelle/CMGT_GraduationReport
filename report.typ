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
- *Architecture*:
- *Acceleration Device:* a hardware device that is specialized in a specific (type of) operation, to make that type of work faster than a general purpose device would be able to do.
- *GPU:* Graphics Processing Unit. An Acceleration Device that specializes in graphics calculations, but can also be used for more general purpose computing.
- *API:* Application Programming Interface. The "rules"/"contract" that a certain programming system offers; usually a set of functions that are able to be called by the programmer.
- *OpenGL:* absolutely ancient GPU API.
- *Low-level:* Offers a lot of control, at the cost of complexity. Is close to the hardware. //TODO: Improve this later
- *High-level:* Offers little control, but is often simpler #footnote[But _not_ necessarily easier]. Is far from the hardware. //TODO: Improve this later
- *Performance (Performant)*:
- *Flexible:*
- *Multi-threading:*
- *Boilerplate:*
- *Parallel:*
- *Abstraction:*
- *Wrapper:*
- *Verbose:*
- *Obtuse:*
- *Compile-time:*
- *Startup-time:*
- *Run-time:*
- *(Game) Console*:
- *Operating System:*
- *Vulkan:* newer API than OpenGL, made to be similarly cross-platform as OpenGL, but much more low-level, to allow more control to the users. Technically not a GPU API, but an Acceleration Device API.
- *paradigm:* style / way of doing things

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
//TODO (Glyn): Be specific, requirements should all be measurable(in the end either the requirement is met or not), "some details are abstracted away" is not measurable.
- Abstract away some implementation details that are more verbose and obtuse than they need to be,
  from the perspective of someone implementing new graphics features.
- Guarantee some safety checks that make it a bit harder for engineers to shoot themselves in the foot.
  #footnote[Reference to the famouse quote _#quote("C makes it easy to shoot yourself in the foot; C++ makes it harder, but when you do it blows your whole leg off.")_ — #cite(<stroustrup-footguns>, form: "prose")]
- Allow enough low level access to not restrict engineers from being able to design their own renderer architecture.
- Minimise overhead of the abstraction where possible, or at least move as much of it to
  compile-time or startup-time as possible.

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

//TODO: Collect more sources for this stuff.

To make a good and performant rendering system, we need to interface with the Graphical Processing Unit (GPU).

There are many GPU APIs, like OpenGL, Vulkan, DirectX, Metal, and most consoles have their own specific ones.
All of these are compatible with different operating systems and platforms.

*OpenGL* is generally the most compatible with all kinds of hardware, but also the oldest and clunkiest, and is considered deprecated by many, myself included.
For that reason, OpenGL will not be mentioned much in this report, as it cannot really hold a candle to these other, more modern APIs.

//TODO: This paragraph has got to be improved
*Vulkan* is a very low-level GPU API, by the Khronos Group, a consortium of organizations that focuses on graphics. @khronos-about\
Vulkan is known as the most verbose GPU API, which is often used as ammunition to ridicule it, but being verbose has many advantages.
It is much clearer about what it actually does, for example, and you have more control over what happens and when.
This means it allows for a lot of control and thus optimization, at the cost of development effort.
Vulkan is actually not exactly a GPU API, because it is more of a general-purpose Acceleration Device API.
GPUs are just one type of Acceleration Device.
However, for the purposes of this report, I will consider only the GPU aspects of Vulkan.

*DirectX* is for Windows and Xbox. In fact, the Xbox _only_ supports DirectX.
Windows itself does support more than just their own DirectX API, though.\
It is technically possible to run DirectX on Linux, through compatibility layers, like DXVK and vkd3d.
#footnote[For example, Valve makes use of them in their Proton software, which allows Windows games to run on Linux.]
However, it should be noted that these compatibility layers are not officially supported or endorsed by Microsoft, the developers of DirectX.

*Metal* is for Apple devices, which also don't (natively) support anything else.
#footnote[Technically, macOS does also support OpenGL, but only an old version (4.1 from 2011 @macos-opengl).
And the latest _normal_ OpenGL version is already old! (4.6 from 2017 @opengl46-release)]\
However, there is a very popular translation layer for running Vulkan on Apple devices, called MoltenVK.
MoltenVK is not officially supported by Apple, but it is part of the Khronos Vulkan Portability Initiative. @moltenvk-2017

PlayStation has two proprietary and "secret" APIs, called *GNM* and *GNMX*. @schertenleib-2013\
GNM is the low-level API, and GNMX is a higher-level wrapper around it. @leadbetter-2013\
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
Many of these abstraction layers use different wildily different programming styles (paradigms), so I have categorised them.
After that, I will compare them and pick one or a few to actually research practically, which I will do by prototyping with them.

I will be discussing the following paradigms:
Global State Machine, Pipelines and Passes (Mantle-descendants), Partial Abstractions, Rendergraph-based Abstractions, and Scenegraph-based Abstractions.
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
The instructions of what to do with that data are usually still pretty small and separate calls, though.

This is what Pipelines and Passes APIs solved by also making the instructions one large dataset, instead of small and separate instructions.

OpenGL, a really old GPU API #footnote[The last release, 4.6, was in 2017, and it is not in development anymore. @opengl46-release],
and older versions of DirectX actually were global state machines already @opengl-concepts.
Modern GPU APIs have moved away from this kind of architecture, because they were extremely cumbersome to work with, and often very slow.

Modern GPU APIs also match the things that are actually happening on a hardware level more closely than these older APIs.

Despite the aforementioned cons, some people still like the paradigm of global state machine APIs.

==== Existing implementations

Immediate-Mode paradigm API:
- OpenGL Legacy (1.0 up to, but not including, 3.0)
- Direct3D 7 and before
- rlgl: https://github.com/raysan5/raylib/blob/master/src/rlgl.h

Buffer-paradigm APIs:
- OpenGL Modern (3.0 and later)
- Direct3D 8 to 11 (12 is a Pipelines and Passes-paradigm API)
- bgfx: https://github.com/bkaradzic/bgfx

==== Evaluation

These abstractions are too high-level for Rythe, and global state is difficult to work with and reason about.
Global state machines also don't have enough potential for optimization,
because it is also nigh-impossible to properly multi-thread, which is a very important aspect of the Rythe Engine.

#pagebreak()
=== Pipelines and Passes (Flat Abstractions) (Mantle-descendants)

Pipelines and Passes are the two main concepts of "modern" GPU APIs.
Specifically, they are //TODO

Back in 2016, AMD released an experimental new GPU API called Mantle.
This was the first Pipelines and Passes API.
AMD then donated it to the Khronos Group, who turned it into Vulkan, and continued developing it.
Khronos is also the main driving force for making it as cross-platform as it is.
In the meantime, Microsoft and Apple were also inspired by Mantle, and created DirectX 12 and Metal, respectively, based on it.

Pipelines and Passes are also the main concepts of Vulkan itself, so I am going to call the abstractions that use them "flat abstractions".
The term "flat abstraction" is my own creation, for lack of a better one.
With this I mean that these abstractions very closely mirror the original GPU API, except that they are simplified.
However, they do contain and use the same core principles.

==== Existing implementations

- SDL3's GPU API: https://wiki.libsdl.org/SDL3/CategoryGPU
	- Some words about this
- WebGPU (wgpu-native): https://github.com/gfx-rs/wgpu
- Sokol: https://github.com/floooh/sokol (ironically enough, this one doesn't _actually_ abstract Vulkan, but _does_ abstract almost all other GPU APIs)
- https://github.com/DiligentGraphics/DiligentCore
- IGL: https://github.com/facebook/igl
- https://github.com/corporateshark/lightweightvk
- Veldrid: https://github.com/veldrid/veldrid (specifically take inspiration from this one, as it manages to keep this VERY nice and short!)
- Ravbug's RHI: https://github.com/RavEngine/RGL-Samples/blob/master/01-HelloTriangle/hellotriangle.cpp
- https://github.com/Devsh-Graphics-Programming/Nabla
- https://github.com/NVIDIA-RTX/NVRHI

==== Evaluation

I have tried a few of these APIs in the past, namely Veldrid, WebGPU, and SDL3's GPU API.

Veldrid is quite high level already, but quite nice to work with, due to the relative lack of boilerplate.
Sadly, it has become unmaintained, but it can still serve as inspiration for our own abstraction.

WebGPU is almost a nice API, but due to some design decisions and internal politics, it is not as good as I would have liked.
Especially because it's officially only a JavaScript specification,
which means that the native implementations have to just do their best to resemble it.
This has not gone very well, and the various native implementations are not very consistent with each other.
It also prescribes a custom shader language, of which the syntax is very like the Rust programming language,
which is not very beloved at Rythe.

However, I really ended up liking SDL3's GPU API. The documentation is excellent, and it is incredibly pleasant to use.
It still allows for a lot of low-level access, while also being very user-friendly and cross-platform.
It achieves this by not just abstracting Vulkan, but also DirectX 12 and Metal (and console APIs, as well).

This the paradigm I'll go with for our own abstraction layer, as it is the most flexible and powerful.

#pagebreak()
=== Partial Abstractions

The abstractions mentioned before abstract the _entire thing_, and don't allow access to the internals, like the raw Vulkan API it is abstracting.

But these "partial abstractions" are libraries that abstract only _parts_ of the Vulkan API,
while still allowing direct access to the raw Vulkan API in other places.

You can use multiple of these together, for their different purposes.

These are also sometimes referred to as "helper libraries".

==== Existing implementations

- Entrypoint Loading: https://github.com/zeux/volk
- Initialization: https://github.com/charles-lunarg/vk-bootstrap
- Memory Allocation: https://github.com/GPUOpen-LibrariesAndSDKs/VulkanMemoryAllocator

==== Evaluation

I have made a Vulkan program in the past that used no partial abstractions,
and while it was cool to see how it all works and a good learning experience,
it is unlikely to be necessary to do all that again.

So we might use one or multiple of the above in our own abstraction,
after I have conducted some experiments with them.

#pagebreak()
=== Rendergraph-based Abstractions

Description

==== Existing implementations

- https://github.com/martty/vuk
- https://github.com/GPUOpen-LibrariesAndSDKs/RenderPipelineShaders
- https://github.com/asc-community/VulkanAbstractionLayer

==== Evaluation

Cool, but too high-level.

#pagebreak()
=== Scenegraph-based Abstractions

Description

==== Existing implementations

- https://github.com/vsg-dev/VulkanSceneGraph

==== Evaluation

Cool, but _much_ too high-level.

#pagebreak()
== Final Selected Solution(s)

The abstraction will be a Pipelines and Passes (Flat abstractions) paradigm API, in which I may use some already-existing partial abstractions.

The reasoning is that this paradigm is just by far the most flexible and powerful.

=== About C and C++

Most of the existing GPU APIs are published in C, because it's the most fundamental language that is still widely used,
and it is relatively easy to interface with from other languages.

However, the Rythe Engine is written in C++, which can easily use C libraries.
So the LLRI2 library will be written in C++, so it might be able to benefit from some C++ features,
like RAII, templates, and smart pointers,


#pagebreak()

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
- Which features should the abstraction layer have?
- How do you properly benchmark an in-house (graphics) engine?
- What can are further potential avenues for more optimisation?

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


== SDL3's GPU API Prototype

I started with this prototype, because it is the one I was most curious about at that time.
I had already used Vulkan in the past, so I wanted to first try something new that promised to be more user-friendly.

And it delivered on that promise; the API is very nice to use, and the function documentation is excellent.
The examples are also okay, though they do take some untangling,
if you want to follow them closely, because they pack a lot of functionality into one example.

There is sadly also no full guide, yet, like LearnOpenGL @learnopengl, Vulkan Tutorial @vulkan-tutorial, or VkGuide @vkguide.

Nevertheless, I managed to get a triangle on screen pretty quickly, after which I started adding more features.


== Vulkan (With Helper Libraries) Prototype

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

I will create a plot of all the frametimes, and calculate the following statistics:
- The average frametimes (Nanoseconds)
	- The standard deviation
	- Highs (1%, 0.1%, 0.01%)
	- Lows (1%, 0.1%, 0.01%)
- The frame-to-frame deviation of the frametimes

I will also graph the occurrences of each frametime, to see how many frames were rendered with which times.
This is useful to see the grouping of the frametimes, and to see if there are any outliers.

These plots will be made with the Python library Matplotlib, which I also used for a previous project,
so I can largely re-use the scripts I wrote for that project, with the help of a friend who is a data scientist #footnote[PhD student in the field of Astronomy].


#pagebreak()
== Performance Testing (Benchmarking)

//TODO: Logarithmic scales for the graphs may be used, if it helps to see the data better.


== API Userfriendliness testing

Try and see if I can find people willing to try making something with our abstraction.

#pagebreak()


= Conclusion

#if show_tips_from_manual [
_You are heading towards the finalization of your graduation project and the conclusion of your report. This
means you will round off your report by answering the main question you formulated at the start by
drawing conclusions._
]

\/\/TODO
//TODO: Mention difference in effort of using bare vk vs sdlgpu


= Recommendation

#if show_tips_from_manual [
_Based on the conclusions, you will complete the project with recommendations,
providing your view on valuable follow-up actions for your client._

_During Applied Research, it is explained how to present conclusions
and recommendations. You will find this information in the relevant section on Brightspace._
]

I recommend that Rythe continue with the development of the LLRI2 library.
I propose they hire me to do so, as I have already done a lot of research and prototyping for it.

It should also be considered to use SDL3's GPU API as the base for the LLRI2 library,
and fork it to add the more modern GPU features that Rythe wants to support,
such as Bindless Textures and hardware raytracing.
If that happens, it should be considered whether to only use SDL3's Vulkan implementation,
or whether to keep supporting the other APIs that SDL3's GPU API supports, like DirectX 12 and Metal.
And it should also be considered whether to "upgrade" it to C++, because SDL3's GPU API is in C.

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

#pagebreak()
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

\/\/TODO

= Reflection

#if show_tips_from_manual [
_At the end of your report, you will include a self-reflection, containing what you consider your strong points
and what aspects need to be strengthened as a young professional, and how you would position yourself in
the industry. It’s valuable to not only look back but also ahead to the industry you will soon enter. Please
note that you will have to move the self-reflection to the annexes before posting it on Post it_
]

Due to many circumstances, both personal and external,
I did not manage to get as much done as I would have liked to,
so the scope of this project had to be reduced halfway through.

I should have expected that the prototyping would take longer than I had initially thought.
I had hoped to have been able to start on the LLRI2 library itself, but I did not manage to get that far.

Even so, I have learned a great deal during this project, and I am very proud of the work I have done.
Both the prototypes and the research.

So on the whole, I am still very happy with the results of this project.

//Stop numbering headings from here on out
#set heading(numbering: none)
#pagebreak()

= Appendices

== Competences Reflection

\/\/TODO


== Showcase of the End Product

Probably a YouTube link.
Not Saxion's own Kaltura, because I probably want to keep this around.

#pagebreak()
= Bibliography

#bibliography(
	"references.bib",
	style: "american-psychological-association",
	title: none,
)

#pagebreak()
= List of Figures

#show outline.entry.where(level: 1): set outline.entry(fill: align(right, repeat(text(weight: 100, "."), gap: 0.3em, justify: false)))
#set text(weight: 0) //reset font weights
#show outline.entry: it => {
	show regex(`^.+\s+\d+`.text): set text(weight: 200) //prefix
	show regex(`\d+$`.text): set text(weight: 300) //page number
	it
}

#outline(title: none, target: figure)

