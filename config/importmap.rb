# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin_all_from "app/javascript/extras", under: "extras"
pin "@codemirror/basic-setup", to: "https://ga.jspm.io/npm:@codemirror/basic-setup@0.19.1/dist/index.js"
pin "@codemirror/autocomplete", to: "https://ga.jspm.io/npm:@codemirror/autocomplete@0.19.12/dist/index.js"
pin "@codemirror/closebrackets", to: "https://ga.jspm.io/npm:@codemirror/closebrackets@0.19.0/dist/index.js"
pin "@codemirror/commands", to: "https://ga.jspm.io/npm:@codemirror/commands@0.19.8/dist/index.js"
pin "@codemirror/comment", to: "https://ga.jspm.io/npm:@codemirror/comment@0.19.0/dist/index.js"
pin "@codemirror/fold", to: "https://ga.jspm.io/npm:@codemirror/fold@0.19.3/dist/index.js"
pin "@codemirror/gutter", to: "https://ga.jspm.io/npm:@codemirror/gutter@0.19.9/dist/index.js"
pin "@codemirror/highlight", to: "https://ga.jspm.io/npm:@codemirror/highlight@0.19.7/dist/index.js"
pin "@codemirror/history", to: "https://ga.jspm.io/npm:@codemirror/history@0.19.2/dist/index.js"
pin "@codemirror/language", to: "https://ga.jspm.io/npm:@codemirror/language@0.19.7/dist/index.js"
pin "@codemirror/lint", to: "https://ga.jspm.io/npm:@codemirror/lint@0.19.3/dist/index.js"
pin "@codemirror/matchbrackets", to: "https://ga.jspm.io/npm:@codemirror/matchbrackets@0.19.4/dist/index.js"
pin "@codemirror/panel", to: "https://ga.jspm.io/npm:@codemirror/panel@0.19.1/dist/index.js"
pin "@codemirror/rangeset", to: "https://ga.jspm.io/npm:@codemirror/rangeset@0.19.8/dist/index.js"
pin "@codemirror/rectangular-selection", to: "https://ga.jspm.io/npm:@codemirror/rectangular-selection@0.19.1/dist/index.js"
pin "@codemirror/search", to: "https://ga.jspm.io/npm:@codemirror/search@0.19.8/dist/index.js"
pin "@codemirror/state", to: "https://ga.jspm.io/npm:@codemirror/state@0.19.9/dist/index.js"
pin "@codemirror/text", to: "https://ga.jspm.io/npm:@codemirror/text@0.19.6/dist/index.js"
pin "@codemirror/tooltip", to: "https://ga.jspm.io/npm:@codemirror/tooltip@0.19.13/dist/index.js"
pin "@codemirror/view", to: "https://ga.jspm.io/npm:@codemirror/view@0.19.44/dist/index.js"
pin "@lezer/common", to: "https://ga.jspm.io/npm:@lezer/common@0.15.11/dist/index.js"
pin "crelt", to: "https://ga.jspm.io/npm:crelt@1.0.5/index.es.js"
pin "style-mod", to: "https://ga.jspm.io/npm:style-mod@4.0.0/src/style-mod.js"
pin "w3c-keyname", to: "https://ga.jspm.io/npm:w3c-keyname@2.2.4/index.es.js"
pin "@codemirror/lang-markdown", to: "https://ga.jspm.io/npm:@codemirror/lang-markdown@0.19.5/dist/index.js"
pin "@codemirror/lang-css", to: "https://ga.jspm.io/npm:@codemirror/lang-css@0.19.3/dist/index.js"
pin "@codemirror/lang-html", to: "https://ga.jspm.io/npm:@codemirror/lang-html@0.19.4/dist/index.js"
pin "@codemirror/lang-javascript", to: "https://ga.jspm.io/npm:@codemirror/lang-javascript@0.19.7/dist/index.js"
pin "@lezer/css", to: "https://ga.jspm.io/npm:@lezer/css@0.15.2/dist/index.es.js"
pin "@lezer/html", to: "https://ga.jspm.io/npm:@lezer/html@0.15.0/dist/index.es.js"
pin "@lezer/javascript", to: "https://ga.jspm.io/npm:@lezer/javascript@0.15.3/dist/index.es.js"
pin "@lezer/lr", to: "https://ga.jspm.io/npm:@lezer/lr@0.15.7/dist/index.js"
pin "@lezer/markdown", to: "https://ga.jspm.io/npm:@lezer/markdown@0.15.4/dist/index.js"
pin "mermaid", to: "https://cdn.jsdelivr.net/npm/mermaid@11.4.1/+esm"
pin "@replit/codemirror-vim", to: "https://ga.jspm.io/npm:@replit/codemirror-vim@0.19.0/dist/index.js"
pin "@codemirror/stream-parser", to: "https://ga.jspm.io/npm:@codemirror/stream-parser@0.19.6/dist/index.js"
pin "@rails/activestorage", to: "https://ga.jspm.io/npm:@rails/activestorage@7.0.2-2/app/assets/javascripts/activestorage.esm.js"
