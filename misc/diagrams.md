# Diagramming Guidelines

We use [Mermaid](https://mermaid.js.org/intro/) as our primary diagramming tool. Mermaid is [“a JavaScript based diagramming and charting tool that renders Markdown-inspired text definitions to create and modify diagrams dynamically”](https://mermaid.js.org/intro/#about-mermaid). Mermaid enables us to:

* take a “diagram-as-code” approach for creating diagrams;

* include diagrams as part of code review;

* easily modify diagrams to reflect updated functionality;

* maintain change history of our diagrams (i.e., changes tracked via git commits);

* collaborate with one another more effectively when creating diagrams;

* establish consistency in our documentation by using a shared language.

This guideline provides some tips and questions to consider when creating diagrams with accessibility and interpretability in mind.

## Who is the intended audience

Before starting your diagram, it’s important to think about your intended audience. Who are you creating the diagram for and who is it meant to help? Your audience will inform the level of detail your diagram requires. For instance, a low-level, “nuts-and-bolts” diagram may be more useful for an engineering team, while higher-level diagrams may be better suited for other stakeholders.

## When do we create diagrams

Diagrams should be incorporated in the early stages of application development and incorporated into the engineering plan. Ask yourself, “how many words does it take to describe the flow?” and determine if a diagram will ease explanation. Before writing any code for the application or a new feature, try to write a description of the purpose of the application (or feature update) and create diagrams that explain the architecture or code workflow. For example, create a [class diagram](https://mermaid.js.org/syntax/classDiagram.html) describing a proposed Python module, or create a [sequence diagram](https://mermaid.js.org/syntax/sequenceDiagram.html) describing the interactions (i.e., data flow) between software utilities that the application will rely on.

## Where do we use diagrams

Diagrams are included in our GitHub repositories and Confluence documents. Both applications support Mermaid. Github allows you to [include diagrams in your Markdown files with Mermaid](https://github.blog/2022-02-14-include-diagrams-markdown-files-mermaid/). Code blocks marked as `mermaid` will render raw Mermaid syntax into diagrams in your local browser. Atlassian provides a variety of apps (e.g., [Mermaid Diagrams for Confluence](https://marketplace.atlassian.com/apps/1226567/mermaid-diagrams-for-confluence?hosting=cloud&tab=overview)) that allow you to embed Mermaid diagrams directly in your Confluence documents.

## Why do we need diagrams

Diagrams are useful for communicating the data flow within an application. Diagrams can be particularly helpful for complex data-intensive applications. That being said, there are some applications where the flow is simple and straightforward enough to not require a diagram. In these applications, thoughtfully written code can serve as documentation. Diagrams also increase accessibility of our data applications, by serving as another medium through which developers and stakeholders alike can understand the tools we create to support the work of MIT Libraries.