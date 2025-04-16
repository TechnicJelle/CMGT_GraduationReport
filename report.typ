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
- *Acceleration Device:* a hardware device that is specialized in a specific (type of) operation, to make that type of work faster than a general purpose device would be able to do.
- *GPU:* Graphics Processing Unit. An Acceleration Device that specializes in graphics calculations, but can also be used for more general purpose computing.
- *API:* Application Programming Interface. The "rules"/"contract" that a certain programming system offers; usually a set of functions that are able to be called by the programmer.
- *OpenGL:* absolutely ancient GPU API.
- *Low-level:* Offers a lot of control, at the cost of complexity. Is close to the hardware. //TODO: Improve this later
- *High-level:* Offers little control, but is often simpler #footnote[But _not_ necessarily easier]. Is far from the hardware. //TODO: Improve this later
- *Performance (Performant)*:
- *Flexible:*
- *Multi-threading:*
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

In this report, I will describe the product I have first researched for,
and then developed during my Graduation Internship at Rythe Interactive.

During this process, I adhered to the Double Diamond @double-diamond design process model.

== Company

This graduation project is being done for the company Rythe Interactive.
Rythe is a very small startup company of just two employees, and an intern (me).

The product they have is the Rythe Game Engine, the aim of which is to be a modular yet performant game engine.
The modular nature makes it extra easy for companies to modify it to suit their own specific purposes,
without having to build an entirely new engine from scratch.

== Problem Definition

There are currently already multiple iterations of the Rythe Engine in existence.

The Rythe Legacy engine is so old that it still uses OpenGL.
OpenGL is bad for performance, due to the CPU usage required.
It can also not be properly multi-threaded, which is especially bad, because one of the main goals of the engine is to be very parallel.
The engine is too tightly integrated with OpenGL to be salvagable.

The first rewrite used more modern technologies, and had a dedicated renderer component called Rythe-LLRI, or "Rythe Low Level Rendering Interface".
It was a cross-platform GPU API abstraction, that was intended to be as low-level as possible to ensure maximum performance.
The LLRI is very old and was written before the Vulkan API had even properly released. It is also not finished.

Now, a second rewrite of the engine is being worked on, but it is still lacking a good rendering system.
Therefore, the LLRI component could also do with a rewrite, alongside the rest of the engine.

== Research Questions

For this project I will be working on creating
the (start for a) rendering system for the new version of the Rythe Game Engine.
This product could serve as the base for the complete LLRI rewrite.

=== Main Research Question

My main research question is:
#v(1em)
#align(center)[_
	How can I develop a good start for a flexible,\
	yet performant cross-platform GPU API abstraction?
_]
#v(1em)

=== Sub-questions

As part of this research, there are a few sub-questions that also need to be answered:
- Which GPU API should I start with abstracting?
- How should I test?
- How can I make it faster?

== Requirements and Constraints

The goal of the LLRI is to:
- Be portable to other GPU API's down the line (not necessarily immediately).
- Abstract away some implementation details that are more verbose and obtuse than they need to be,
  from the perspective of someone implementing new graphics features.
- Guarantee some safety checks that make it a bit harder for engineers to shoot themselves in the foot. //TODO: APA to Bjarne Soustrup's "C vs C++"
- Allow enough low level access to not restrict engineers from being able to design their own renderer architecture.
- Minimise overhead of the abstraction where possible, or at least move as much of it to
  compile-time or startup-time as possible.

=== Deliverable

At the end of the project, I plan to have a GitHub repository with a library in it.
That library will be the start of the new LLRI.

=== Indicators of Success

I'll have succeeded if I got the beginnings of a GPU API abstraction layer done.
I will verify and ensure that it is done enough by making a test program with it.

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

*DirectX* is for Windows and Xbox. In fact, the Xbox _only_ supports DirectX. Luckily Windows itself does support more.\
It is technically possible to run DirectX on Linux, through compatibility layers, like DXVK and vkd3d.
#footnote[For example, Valve makes use of them in their Proton software, which allows Windows games to run on Linux.]
However, it should be noted that these compatibility layers are not officially supported or endorsed by Microsoft, the developers of DirectX.

*Metal* is for Apple devices, which also don't (natively) support anything else.
#footnote[Technically, macOS does also support OpenGL, but only an old version. And the latest _normal_ OpenGL version is already old!]\
However, there is a very popular translation layer for running Vulkan on Apple devices, called MoltenVK.
MoltenVK is not officially supported by Apple, but it is part of the Khronos Vulkan Portability Initiative. @moltenvk-2017

PlayStation has two proprietary and "secret" APIs, called *GNM* and *GNMX*.\
GNM is the low-level API, and GNMX is a higher-level wrapper around it. @leadbetter-2013\
Not much is publicly known about these APIs, because you need to sign an NDA to get access to the PlayStation Developer Kit.

Nintendo Switch also has a proprietary and "secret" API, called *NVN*.
This is the preferred API to use, but The Switch at least does _support_ Vulkan, too.
Not much is publicly known about this API, because you need to sign an NDA to get access to the Nintendo Switch Developer Kit.

#import "lib/03-api_compat_table.typ": api_compat_table
#figure(
	api_compat_table,
	caption: [An overview of Platform ↔ API Compatibility]
) <api_compat_table>

As we can see in @api_compat_table, Vulkan is the most cross-platform of any of these APIs,
being supported on Windows, Linux, Android, and Nintendo Switch, with compatibility layers existing for Apple devices.

This is why I will be starting with Vulkan, as it is the API that has the most platform compatibility.

However, when making actual applications, you don't want to have to write all your Vulkan code from scratch every single time.
So that's when you make an abstraction on top of Vulkan, which you can reuse across multiple projects.
In this report, I will detail my efforts at making such a Vulkan Abstraction Layer.

#pagebreak()

== Possible Solutions

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

When making big thing small, things of the big thing have to be dropped.
Depending on the opinion and preferences of the maker of the abstraction layer,
some people will choose to drop this bit and not that bit.
Others will choose to drop that bit and not this bit.
These are choices that have to be made.
And this is how multiple abstraction layers arise.
This makes it so there is something for everyone. :)

In this section, I will explore some of these GPU API abstraction layers that already exist by way of theoretical research.
Many of these abstraction layers use different wildily different programming styles (paradigms), so I have categorised them somewhat.
After that, I will compare them and pick one or a few to actually research practically, which I will do by prototyping with them.

I will be discussing A, B, C, D, E paradigms. For each of them I will give a (small) description, //TODO
list some already-existing implementations of it, and evalute its usefulness for this project.

After the prototyping, I will choose the paradigm to go ahead with for my own abstraction layer.

=== Global State Machine

Global state machines are //TODO

There are two types of Global State Machine API: immediate-mode and buffer-paradigm.

Immediate mode entails that the programmer sends every tiny command to the GPU in many different GPU calls.
This is *extremely* slow, because modern GPUs much prefer chomping on large datasets and instructions in one go,
rather than receiving one measly instruction per call.

This is why the newer paradigm introduced buffers. Buffers are large sets of data that are copied to the GPU in one go.
The instructions of what to do with that data are usually still pretty small and separate calls, though...

This is what Pipelines and Passes APIs solved by also making the instructions one large dataset, instead of small and separate instructions.

OpenGL, a really old GPU API, and older versions of DirectX actually were global state machines already.
Modern GPU APIs have moved away from this kind of architecture, because they were extremely cumbersome to work with, and often very slow.
//TODO: Add more deets about CPU & multi-threading

Modern GPU APIs also match the things that are actually happening on a hardware level more closely than these older APIs.

Despite the aforementioned cons, some people still like the paradigm of global state machine APIs.

Implementations:
Immediate-Mode paradigm API:
- OpenGL Legacy (1.0 up to, but not including, 3.0)
- Direct3D 7 and before
- rlgl: https://github.com/raysan5/raylib/blob/master/src/rlgl.h

Buffer-paradigm APIs:
- OpenGL Modern (3.0 and later)
- Direct3D 8 to 11 (12 is a Pipelines and Passes-paradigm API)
- bgfx: https://github.com/bkaradzic/bgfx

#heading(outlined: false, level: 4)[Evaluation]
Too high-level, and also global state kind of sucks to deal with.
And is also nigh-impossible to properly multi-thread, which is a very important aspect of the Rythe Engine.
BGFX will also be practically evaluated.

=== Pipelines and Passes (Flat Abstractions)

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

Existing implementations:
- SDL3's GPU API: https://wiki.libsdl.org/SDL3/CategoryGPU
	- Some words about this
- WebGPU (wgpu-native): https://github.com/gfx-rs/wgpu
- Sokol: https://github.com/floooh/sokol (ironically enough, this one doesn't _actually_ abstract Vulkan, but _does_ abstract almost all other GPU APIs)
- https://github.com/DiligentGraphics/DiligentCore
- IGL: https://github.com/facebook/igl
- https://github.com/corporateshark/lightweightvk

#heading(outlined: false, level: 4)[Evaluation]

I do really like SDL3's GPU API.
This is probably the paradigm I'll go with.

=== Partial Abstractions

These are libraries that only abstract _parts_ of the Vulkan API, while still allowing direct access to the raw Vulkan API in other places.
Most abstractions abstract the entire thing, and don't allow you to access the internals, like the raw Vulkan API.

You can use multiple of these together, for their different purposes.

- Entrypoint Loading: https://github.com/zeux/volk
- Initialization: https://github.com/charles-lunarg/vk-bootstrap
- Memory Allocation: https://github.com/GPUOpen-LibrariesAndSDKs/VulkanMemoryAllocator

#heading(outlined: false, level: 4)[Evaluation]
I might use one or multiple of these in my own abstraction.
We shall see. I would like to experiment with them "in-person".

=== Rendergraph-based Abstractions

Description

#heading(outlined: false, level: 4)[_Existing implementations_] //TODO: Make H4 less weight & italic
- https://github.com/martty/vuk
- https://github.com/asc-community/VulkanAbstractionLayer

#heading(outlined: false, level: 4)[_Evaluation_]

Cool, but too high-level.

=== Scenegraph-based Abstractions

Description

Existing implementations:
- https://github.com/vsg-dev/VulkanSceneGraph

#heading(outlined: false, level: 4)[Evaluation]
Cool, but _much_ too high-level.

=== Final Selected Solution(s)

The abstraction will be a Pipelines and Passes (Flat abstractions) paradigm API, in which I may use some already-existing partial abstractions.

The reasoning is that this paradigm is just by far the most flexible and powerful.

#pagebreak()

= Practical Research (Prototyping)

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


I should look into Bindless. It apparently has the potential to be MUCH faster than Bindful!
When comparing bindless OpenGL to bindful OpenGL, the speedup can be 7x, according to https://www.nvidia.com/en-us/drivers/bindless-graphics/
I assume such high performance gains won't be possible with Vulkan, because bindful Vulkan is already faster than bindful OpenGL.
But we will see when I actually get there...

I will make multiple programs that all do the following:
- show some spinning textured cubes
	- Textures may be bindless-only, whenever the API allows that functionality
- maybe a Suzanne
- super simple lighting
	- fancier(?if there is time; a day?)
- framebuffers
	- multiple inputs
	- for post-processing
		- bloom
	- offline rendering
		- snow/dynamic paint
- compute shaders(?if there is time?)

But in these different ways:
- With raw Vulkan
- With Vulkan with some partial abstractions
- With SDL3's GPU API
- With BGFX

Once these are done, I can use the Vulkan prototypes to see what features our new abstraction will need, and base our new abstraction on that.
If I find the already-existing partial abstractions worthy enough, I will use those in my abstraction.

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

== Performance Testing (Benchmarking)

Write test program in raw Vulkan, and in the Abstraction.
Potentially even in other APIs, like SDL3's GPU API, or Sokol or BGFX.
The earlier written prototypes will be useful for this as well.

== API Userfriendliness testing

Try and see if I can find people willing to try making something with my abstraction.

#pagebreak()
= Conclusion

#if show_tips_from_manual [
_You are heading towards the finalization of your graduation project and the conclusion of your report. This
means you will round off your report by answering the main question you formulated at the start by
drawing conclusions._
]

\/\/TODO


= Recommendation

#if show_tips_from_manual [
_Based on the conclusions, you will complete the project with recommendations,
providing your view on valuable follow-up actions for your client._

_During Applied Research, it is explained how to present conclusions
and recommendations. You will find this information in the relevant section on Brightspace._
]

\/\/TODO

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

= Self-Reflection

#if show_tips_from_manual [
_At the end of your report, you will include a self-reflection, containing what you consider your strong points
and what aspects need to be strengthened as a young professional, and how you would position yourself in
the industry. It’s valuable to not only look back but also ahead to the industry you will soon enter. Please
note that you will have to move the self-reflection to the annexes before posting it on Post it_
]

\/\/TODO

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

