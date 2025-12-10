return {
  settings = {
    basedpyright = {
      analysis = {
        inlayHints = {
          callArgumentNames = true,
        },
        diagnosticSeverityOverrides = {
          reportUnknownVariableType = 'none',
          reportUnknownMemberType = 'none',
        },
        typeCheckingMode = 'basic',
      },
    },
  },
}
