let context = #{};

if switch_enabled("debug-answers") {
    log(Info, `${archetect::archetype::description()} Answers:`);
    display(as_yaml(ANSWERS));
}

context += prompt("Project Prefix:", "prefix-name", #{
    placeholder: "Transaction",
    help: "Project Name",
    cases: [
        CasedIdentityCasedValue(PROGRAMMING_CASES),
    ],
});

context += prompt("Project Suffix:", "suffix-name", #{
    help: "Project Type",
    defaults_with: "Service",
    cases: [
        CasedIdentityCasedValue(PROGRAMMING_CASES),
    ],
});

context += set("project-name", render("{{ prefix-name }}_{{ suffix-name }}", context), #{
    cases: [
        CasedIdentityCasedValue(PROGRAMMING_CASES),
    ],
});

context += prompt("Persistence:", "persistence", #{
    help: "Project Persistence",
    defaults_with: "None",
    type: Select([
      "CockroachDB",
      "PostgreSQL",
      "MySQL",
      "MSSQL",
    ]),
});

// if context.project_suffix == "service" {
//   context += prompt("Persistence:", "persistence", #{
//       type: Select(["CockroachDB", "None"]),
//       help: "Persistence",
//       defaults_with: "CockroachDB",
//   });
// }


context += prompt("Protocol:", "protocol", #{
  type: Select([
    "REST",
    "GraphQL",
    "gRPC",
  ]),
});

context += prompt("Language:", "language", #{
  type: Select([
    "Java",
    "Rust",
    "JavaScript",
    "Python",
    "Golang",
    ".Net",
  ]),
});

// switch context["project-suffix"] {
//     "domain-gateway" => context["service-protocol"]="GraphQL",
//     "frontend" => context["service-protocol"]="REST",
//     _ => context["service-protocol"]="gRPC",
// }

// let project_language = ANSWERS["project-language"];
// if project_language == () {
//     project_language = "Java"
// } 
//
// context += set("project-language", project_language, #{});

if switch_enabled("debug-context") {
    log(Info, `${archetect::archetype::description()} Context:`);
    display(as_yaml(context));
}

Directory("contents").render(context);
