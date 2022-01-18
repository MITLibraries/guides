# Architecture Decision Records

Architecture Decision Records (ADRs) should be used to capture architecture decisions made when implementing a software artifact or making a major technology decision.

ADRs have been used by MIT DLS engineers since 2017 to capture architecture decisions in a lightweight manner. We have been using [adr-tools] (https://github.com/npryce/adr-tools) to create standardized ADRs across our repos.

## Format

ADRs should be created in a special docs/ folder in the source repository. They should be numbered (for example, /docs/adrs/0002-use-postgres.md). 

An ADR should contain the following sections.

### Title

The specific decision being made (for example, "Use PostgresSQL for the database requirement"). Each ADR should capture a distinct decision or aspect of the system.

### Status

The decision's status: Proposed (for future discussion), Decided/Accepted, Not Accepted, Deprecated, Superseded, etc.

### Context

This section should briefly begin with why it is necessary to make a decision in the first place. This should describe (and when possible
directly link to) the specific technical requirement or pain point that the decision will address (for example, "This decision is required
for storing image bitstreams in an efficient way. Image storage has been determined as an important requirement for the system. Please refer to 'Project Documentation' for details."). 

Next, the section should summarize the issues at stake (for example, the pros and cons for different database options). 

For complex decisions that involve significant issues and implications (and possibly significant discussion in teams), a separate section (for example, "Details") may be created for capturing further information, with relevant subheadings such as assumptions, constraints, guiding principles, related decisions, related requirements, related documentation, etc. 

### Decision

This should summarize the change being made (for example, "Decided against using PostgreSQL due to unclear fit to X requirement.").

### Consequences

*This should highlight the positive (for example, "This decision implements the metadata storage requirement, outlined in 'Project Document/Issue Tracker'") and any anticipated negative effects (for example, "Although we have selected X for Y use case, the tool we rely on is not a production version. Backward compatibility is not guaranteed. This may require a major future effort for ABC team."). 

*Consequences may also include possible side effects on other systems, requirements, etc. Similarly, the section may also capture external implications (for example, "We need to discuss with other technology stakeholders if there needs to be a general policy or principle around this decision, making it relevant to other projects as well.").

## Notes

The [resource] (https://github.com/joelparkerhenderson/architecture-decision-record) contains additional information on ADRs and related tools. Example 
ADRs can be found in various local repositories in our GitHub (see, for example, [this ADR](https://raw.githubusercontent.com/MITLibraries/dspace-submission-service/main/docs/architecture-decisions/0004-metadata-json-spec.md)).

It is recommended to use [adr-tools] (https://github.com/npryce/adr-tools) to follow the exisisting ADRs in our repos.

In future, we hope to add specific guidelines that an ADR reviewer should consider when accepting an ADR pull request.
