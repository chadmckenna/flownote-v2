// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import mermaid from "mermaid"
import { draculaTheme, draculaHighlightStyle } from "extras/dracula-codemirror-theme"
import { setupKeybindings } from "extras/keybindings"
import { noteLinkCompletion } from "extras/auto-linking"

import { basicSetup, EditorState, EditorView } from '@codemirror/basic-setup'
import { autocompletion } from '@codemirror/autocomplete'
import { markdown, markdownLanguage } from '@codemirror/lang-markdown'
import { javascriptLanguage } from '@codemirror/lang-javascript'
import { vim } from '@replit/codemirror-vim'

const setupEditor = () => {
  const state = document.getElementById('editor-state')

  if (!state) return

  const onUpdate = EditorView.updateListener.of(update => {
    if (update.docChanged) {
      state.value = update.state.doc.toString()
    }
  })

  const extensions = [
    markdown({ base: markdownLanguage }),
    basicSetup,
    onUpdate,
    draculaTheme,
    draculaHighlightStyle,
    autocompletion({ override: [noteLinkCompletion] }),
    EditorView.lineWrapping
  ]

  const vimMode = !('ontouchstart' in document.documentElement && navigator.userAgent.match(/Mobi/));

  if (vimMode) extensions.unshift(vim())

  const initialState = EditorState.create({
    doc: state.value,
    extensions: extensions,
  })

  const view = new EditorView({
    parent: document.getElementById('editor'),
    state: initialState,
  })

  const title = document.getElementById('note_title')

  if (title) title.focus()

  return view
}

const setupLibraries = () => {
  if (Prism) {
    setTimeout(Prism.highlightAll, 1)
  }
  if (mermaid) {
    setTimeout(mermaid.init, 1)
  }
  if (document.getElementById('query')) {
    document.getElementById('query').focus()
  }
}

document.addEventListener('turbo:load', async (event) => {
  setupLibraries()
  setupEditor()
  setupKeybindings()
})

document.addEventListener('turbo:before-stream-render', async (event) => {
  setupLibraries()
})

setupLibraries()
setupEditor()
setupKeybindings()
