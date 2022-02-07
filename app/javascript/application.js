// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

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
    extensions: [basicSetup, markdown(), onUpdate],
  })


  const view = new EditorView({
    parent: document.getElementById('editor'),
    state: initialState,
  })

  return view
}

document.addEventListener('turbo:load', async (event) => {
  event.preventDefault()

  window.view = setupEditor()
})

document.addEventListener('turbo:before-stream-render', async (event) => {
  if (PR) {
    setTimeout(PR.prettyPrint, 1)
  }
})


