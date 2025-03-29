// The student must describe in the report the problem definition and the assignment, the applied methods,
// and the project approach process. This includes the literature used, how the result was achieved (using
// common steps in the professional field), a justification of the choices made, the conclusions drawn, and the
// recommendations related to the assignment. A reflection on the graduation period is also part of the
// report.

// Limits: +/- 10 000 words | +/- 25 pages  (+/- 10%)
//  Excluding preface, abstract, references, appendices.

#import "@preview/cheq:0.2.2": checklist
#show: checklist

#import "lib/00-setup.typ": style
#show: style

#import "lib/01-front.typ": front_page
#show: front_page

= Abstract

_The abstract is situated at the beginning of your report. However, you can only write it at the very end as it
is meant to explain to any reader who will not read the entire report what information is in the report.
Here, the reader will find your main question, the key topics you investigated, a basic overview of the
iterations you made, and your conclusions and recommendations. You can use the guidelines from Scribbr:
How to Write an Abstract_

#pagebreak()

#import "lib/02-toc.typ": toc
#show: toc

= Glossary
// Explanation of some (technical) terms, for people who don't know them yet.
// These aren't explained in-text, to not disrupt the flow of the text for people who do actually understand the terms.
- *paradigm*: style / way of doing things

#pagebreak()

= Introduction

_Your report starts, of course, with the Introduction, which should include:_
- [x] _A general description of the company assignment_
- [ ] _The (preliminary) problem_
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

== Company

This graduation project is being done for the company Rythe Interactive.
Rythe is a very small startup company of just two employees, and an intern (me).

The (primary) product they have is the Rythe Game Engine, the aim of which is to be a modular yet performant game engine.
The modular nature makes it extra easy for companies to modify it to suit their own specific purposes,
without having to build an entirely new engine form scratch.

There are already a few earlier iterations of the engine in existence, but they are all
too tightly integrated with outdated technologies, or have suboptimal architectures.

Hence, a new version of the engine is being worked on, but it is still lacking a good rendering system.
So that is what I will be working on, for this project: creating the (start for a) rendering system for the new version of the Rythe Game Engine.

== Problem Definition

== Research Questions

=== Main Research Question


=== Sub-questions
-
-
-

== Requirements

=== Deliverable

=== Indicators of Success

=== Constraints

#pagebreak()

= Research

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

== GPU APIs

//TODO: Collect more sources for this stuff.

To make a good and performant rendering system, we need to interface with the Graphical Processing Unit.

There are many GPU APIs, like OpenGL, Vulkan, DirectX, Metal, and most consoles have their own specific ones.
All of these are compatible with different OSes and platforms.

*OpenGL* is generally the most compatible, but also the oldest and clunkiest, and is considered deprecated by many, myself included.
For that reason, OpenGL will not be mentioned much in this report, as it cannot really hold a candle to these other, more modern APIs.

//TODO: This paragraph has got to be improved
*Vulkan* is a very low-level GPU API, by the Khronos Group, a consortium of organizations that focuses on graphics. @khronos-about\
Vulkan is known as the most verbose GPU API, which is often used as ammunition to ridicule it, but being verbose has many advantages.
It is much clearer about what it actually does, for example, and you have more control over what happens.
which means it allows for a lot of control and thus optimization, at the cost of development effort.
Vulkan is actually not exactly a GPU API, because it is more of a general-purpose Acceleration Device API.
GPUs are just one type of Acceleration Device.
However, for the purposes of this report, I will consider only the GPU aspects of Vulkan.

*DirectX* is for Windows and Xbox. In fact, the Xbox _only_ supports DirectX. Luckily Windows itself does support more.\
It is technically possible to run DirectX on Linux, through compatibility layers.
#footnote[For example, Valve makes use of them in their Proton software, which allows Windows games to run on Linux.]
However, it should be noted that these compatibility layers are not officially supported or endorsed by Microsoft, the developers of DirectX.

*Metal* is for Apple devices, which also don't (natively) support anything else.
#footnote[Technically, macOS does also support OpenGL, but only an old version. And the latest normal OpenGL version is already old!]\
Though there is a very popular translation layer for running Vulkan on Apple devices, called MoltenVK.
MoltenVK is not officially supported by Apple, but it is part of the Khronos Vulkan Portability Initiative. @moltenvk-2017

PlayStation has two proprietary and "secret" APIs, called *GNM and GNMX*.\
GNM is the low-level API, and GNMX is a higher-level wrapper around it. @leadbetter-2013\
Not much is publicly known about these APIs, because you need to sign an NDA to get access to the PlayStation Developer Kit.

Nintendo Switch also has a proprietary and "secret" APIs, called *NVN*.
This is the preferred API to use, but it at least does _support_ Vulkan, too.
Not much is publicly known about this API, because you need to sign an NDA to get access to the Nintendo Switch Developer Kit.

#import "lib/03-api_compat_table.typ": api_compat_table
#figure(
	api_compat_table,
	caption: [An overview of Platform ↔ API Compatibility]
) <api_compat_table>

As we can see in @api_compat_table, Vulkan is the most cross-platform of any of these APIs,
being supported on Windows, Linux, Android, and Nintendo Switch, with compatibility layers existing for Apple devices.

This is why I will be choosing to start with Vulkan, as it is the API that has the most platform compatibility.

However, when making actual applications, you don't want to have to be writing Vulkan code from scratch every single time.
So that's when you make an abstraction overtop Vulkan, which you can reuse across multiple projects.
In this report, I will detail my efforts at making such a Vulkan Abstraction Layer.

#pagebreak()

== Possible Solutions

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

Of course, there already exist many GPU API abstraction layers. But, this is a good thing!
Because, in my experience, it is impossible to create an abstraction layer that is entirely unopinionated.
It makes it so there is something for everyone :)

In this section, I will explore some of these GPU API abstraction layers that already exist by way of theoretical research.
Many of these abstraction layers use different paradigms, so I have categorised them somewhat.
After that, I will compare them an pick one or a few, to actually prototype with.

After the prototyping, I will choose the paradigm to go ahead with for my own abstraction layer.

=== Potential Solution: Rendergraph-based abstractions

Description

Existing implementations:
- https://github.com/martty/vuk
- https://github.com/asc-community/VulkanAbstractionLayer

#heading(outlined: false, level: 4)[Evaluation]
Cool, but too high-level.

=== Potential Solution: Scenegraph-based abstractions

Description

Existing implementations:
- https://github.com/vsg-dev/VulkanSceneGraph

#heading(outlined: false, level: 4)[Evaluation]
Cool, but _much_ too high-level.

=== Potential Solution: Pipelines and Passes (Flat abstractions)

These are APIs that use the concepts of Pipelines and Passes.
As these are also the main concepts of Vulkan itself, I am going to call these "flat abstractions".
The term "flat abstraction" is my own creation, for lack of a better one.

I mean that these abstractions very closely mirror the original GPU API, except they are simplified.
But they do contain and use the same core principles.

Existing implementations:
- https://wiki.libsdl.org/SDL3/CategoryGPU
- https://github.com/gfx-rs/wgpu
- https://github.com/floooh/sokol (ironically enough, this one doesn't _actually_ abstract Vulkan, but _does_ abstract almost all other GPU APIs)
- https://github.com/DiligentGraphics/DiligentCore
- https://github.com/facebook/igl
- https://github.com/corporateshark/lightweightvk

==== Evaluation

I do really like SDL's GPU API.
This is probably the paradigm I'll go with.

=== Potential Solution: Global State Machine

OpenGL, a really old GPU API, and older versions of DirectX actually were global state machines already.

Modern GPU APIs have moved away from this kind of architecture, because they were extremely cumbersome to work with.
They also match the things that are actually happening on a hardware level more closely than these older APIs, nowadays.

Still, some people like the paradigm of global state machine APIs.

Implementations:
Immediate-Mode paradigm API:
- OpenGL Legacy (1.0 up to, but not including, 3.0)
- Direct3D 7 and before
- rlgl: https://github.com/raysan5/raylib/blob/master/src/rlgl.h

Buffer-paradigm APIs:
- OpenGL Modern (3.0 and later)
- Direct3D 8 to 11 (12 is a Pipelines&Passes-paradigm API)
- bgfx: https://github.com/bkaradzic/bgfx

#heading(outlined: false, level: 4)[Evaluation]
Too high-level, and also global state kind of sucks to deal with.
And is also nigh-impossible to properly multi-thread, which is a very important aspect of the Rythe Engine.

=== Potential Solution: Partial Abstractions

These are libraries that only abstract _parts_ of the Vulkan API, while still allowing direct access to the raw Vulkan API in other places.
Most abstractions abstract the entire thing, and don't allow you to access the internals. Like the raw Vulkan API.

You can use multiple of these together, for their different purposes.

- https://github.com/charles-lunarg/vk-bootstrap (Initialization)
- https://github.com/GPUOpen-LibrariesAndSDKs/VulkanMemoryAllocator (Memory Allocation)
- https://github.com/zeux/volk (Entrypoint Loading)

#heading(outlined: false, level: 4)[Evaluation]
I might use one or multiple of these in my own abstraction.
We shall see. I would like to experiment with them "in-person".

=== Final Selected Solution(s)

The abstraction will be a Pipelines and Passes (Flat abstractions) paradigm API, in which I may use some already-existing partial abstractions.

The reasoning is that this paradigm is just by far the most flexible and powerful.

#pagebreak()

= Prototype(s)

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


I should look into Bindless. It apparently has the potential to be MUCH faster!
When comparing bindless OpenGL to bindful OpenGL, the speedup can be 7x, according to https://www.nvidia.com/en-us/drivers/bindless-graphics/
I assume such high performance gains won't be possible with Vulkan, because bindful Vulkan is already faster than bindful OpenGL.
But we will see when I actually get there...

I will make multiple programs that all do the this:
- show some spinning textured cubes
	- Textures may be bindless-only, whenever the API allows that functionality
- maybe a suzanne
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

Once these are done, I can use the Vulkan prototypes to see what features the abstraction will need, and base it on that.
If I find the already-existing partial abstractions worthy enough, I will use those in my abstraction.

#pagebreak()

= Testing

_To fully benefit from the prototypes you developed and to get the feedback needed to further narrow down
the number of ideas or improve your concept/product (i.e., to conduct the next iteration), the use of
suitable test methods will be highly beneficial. The basis for this is a proper test plan to conduct one or
more tests. Select the methods that were presented to you during Applied Research, choosing those that
are suitable for professional practice within the context of your graduation project._

_To write a test plan, you can use the template provided during Applied Research. The test plan and the
results of the various tests are important components of your report. To find the best way to present the
test results, you can refer to the relevant section of Applied Research on Brightspace_

== Performance Testing (Benchmarking)

Write test program in raw Vulkan, and in the Abstraction.
Potentially even in other APIs, like SDL3's GPU API, or Sokol or BGFX.
The earlier written prototypes will be useful for this as well.

== API Userfiendliness testing

Try and see if I can find people willing to try making something with my abstraction.

= Conclusion

_You are heading towards the finalization of your graduation project and the conclusion of your report. This
means you will round off your report by answering the main question you formulated at the start by
drawing conclusions._


= Recommendation

_Based on the conclusions, you will complete the project with recommendations,
providing your view on valuable follow-up actions for your client._

_During Applied Research, it is explained how to present conclusions
and recommendations. You will find this information in the relevant section on Brightspace._

= Discussion

_In the discussion chapter, you are expected to critically reflect on your design process and solution._

_You can ask questions such as:_
- _how valid the research you conducted is_
- _how reliable the test results are_
- _the suitability of the methods used_
- _what went well and what did not go so well_
- _the value of the insights you presented to your client_
- _and most importantly, to what extent you solved the problem of the client or the user_
_It’s important to show a critical but fair view on these topics._

= Self-Reflection

_At the end of your report, you will include a self-reflection, containing what you consider your strong points
and what aspects need to be strengthened as a young professional, and how you would position yourself in
the industry. It’s valuable to not only look back but also ahead to the industry you will soon enter. Please
note that you will have to move the self-reflection to the annexes before posting it on Post it_

//Stop numbering headings from here on out
#set heading(numbering: none)

= Appendices

== Competences Reflection

== Showcase of the End Product

Probably a YouTube link.
Not Saxion's own Kaltura, because I probably want to keep this around.

= Bibliography

#bibliography(
	"references.bib",
	style: "american-psychological-association",
	title: none,
)

= List of Figures

#show outline.entry.where(level: 1): set outline.entry(fill: align(right, repeat(text(weight: 100, "."), gap: 0.3em, justify: false)))
#set text(weight: 0) //reset font weights
#show outline.entry: it => {
	show regex(`^.+\s+\d+`.text): set text(weight: 200) //prefix
	show regex(`\d+$`.text): set text(weight: 300) //page number
	it
}

#outline(title: none, target: figure)

