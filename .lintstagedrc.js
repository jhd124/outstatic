module.exports = {
  '(!README)*.(md|json|graphql)': 'prettier --write',
  ...[
    'apps/china-travel',
    'apps/web',
    'examples/blog',
    'packages/eslint-custom-config',
    'packages/outstatic',
    'packages/tsconfig'
  ].reduce((actions, pkg) => {
    actions[`${pkg}/**/*.{cjs,mjs,js,jsx,ts,tsx}`] = [
      'eslint --fix',
      // uncomment to enable type-checking a project in lint-staged
      // () => `tsc --project ./${pkg}/tsconfig.json --noEmit`,
      'prettier --write'
    ]
    return actions
  }, {})
}
