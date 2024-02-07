// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "extras/direct-upload"

import mermaid from "mermaid"
import { draculaTheme, draculaHighlightStyle } from "extras/dracula-codemirror-theme"
import { setupKeybindings } from "extras/keybindings"
import { autoLinking } from "extras/auto-linking"

import { basicSetup, EditorState, EditorView } from '@codemirror/basic-setup'
import { autocompletion } from '@codemirror/autocomplete'
import { markdown, markdownLanguage } from '@codemirror/lang-markdown'
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
    autocompletion({
      override: [
        autoLinking(),
      ]
    }),
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

const setupRenameLinks = () => {
  const showLinks = document.querySelectorAll("a[data-file-id-show]")
  const cancelLinks = document.querySelectorAll("a[data-file-id-cancel]")

  showLinks.forEach((element) => {
    element.addEventListener("click", (event) => {
      event.preventDefault();
      const renameForm = document.getElementById(element.dataset.fileIdShow)
      const nameLink = document.getElementById(`show-${element.dataset.fileIdShow}`)
      renameForm.style.display = 'block'
      nameLink.style.display = 'none'
    })
  })

  cancelLinks.forEach((element) => {
    element.addEventListener("click", (event) => {
      event.preventDefault();
      const renameForm = document.getElementById(element.dataset.fileIdCancel)
      const nameLink = document.getElementById(`show-${element.dataset.fileIdCancel}`)
      renameForm.style.display = 'none'
      nameLink.style.display = 'flex'
    })
  })
}

document.addEventListener('turbo:load', async (event) => {
  setupLibraries()
  setupEditor()
  setupKeybindings()
  setupRenameLinks()
})

document.addEventListener('turbo:before-stream-render', async (event) => {
  setupLibraries()
})


setupLibraries()
setupEditor()
setupKeybindings()
setupRenameLinks()
mermaid.initialize()
