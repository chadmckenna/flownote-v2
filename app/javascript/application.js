// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import mermaid from "mermaid"

import { draculaTheme, draculaHighlightStyle } from "extras/dracula-codemirror-theme"
import { setupKeybindings } from "extras/keybindings"

import { basicSetup, EditorState, EditorView } from '@codemirror/basic-setup'
import { markdown } from '@codemirror/lang-markdown'

const setupEditor = () => {
  const state = document.getElementById('editor-state')

  if (!state) return

  const onUpdate = EditorView.updateListener.of(update => {
    if (update.docChanged) {
      state.value = update.state.doc.toString()
    }
  })

  const initialState = EditorState.create({
    doc: state.value,
    extensions: [basicSetup, markdown(), onUpdate, draculaTheme, draculaHighlightStyle, EditorView.lineWrapping],
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

