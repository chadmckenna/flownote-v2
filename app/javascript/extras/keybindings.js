export const setupKeybindings = () => {
  const notesShowRegEx = /^(\/notes\/)(\d+$)/i
  const notesHistoryRegEx = /^(\/notes\/)(\d+)(\/history)$/i
  const notesEditRegEx = /^(\/notes\/)(\d+)(\/edit)$/i
  const notesNewRegEx = /^(\/notes\/)(new)/i

  document.onkeyup = (e) => {
    if (e.ctrlKey && e.key === 'n') {
      Turbo.visit('/notes/new')
    }
    if (e.ctrlKey && e.key === 'a') {
      Turbo.visit('/notes')
    }

    if (e.ctrlKey && e.key === '\\') {
      Turbo.visit('/search')
    }

    if (notesShowRegEx.test(window.location.pathname)) {
      if (e.ctrlKey && e.key === 'i') {
        Turbo.visit(`/notes/${notesShowRegEx.exec(window.location.pathname)[2]}/edit`)
      }
      if (e.ctrlKey && e.key === 'h') {
        Turbo.visit(`/notes/${notesShowRegEx.exec(window.location.pathname)[2]}/history`)
      }
    }

    if (notesHistoryRegEx.test(window.location.pathname)) {
      if (e.ctrlKey && e.key === 'i') {
        Turbo.visit(`/notes/${notesHistoryRegEx.exec(window.location.pathname)[2]}/edit`)
      }
      if (e.ctrlKey && e.key === 'v') {
        Turbo.visit(`/notes/${notesHistoryRegEx.exec(window.location.pathname)[2]}`)
      }
    }

    if (notesEditRegEx.test(window.location.pathname)) {
      if (e.ctrlKey && e.key === 'h') {
        Turbo.visit(`/notes/${notesEditRegEx.exec(window.location.pathname)[2]}/history`)
      }
      if (e.ctrlKey && e.key === 'v') {
        Turbo.visit(`/notes/${notesEditRegEx.exec(window.location.pathname)[2]}`)
      }
    }

    if (notesEditRegEx.test(window.location.pathname) || notesNewRegEx.test(window.location.pathname)) {
      if (e.ctrlKey && e.key === 'w') {
        Object.values(document.forms).forEach((f) => {
          if (f.id === 'note_edit_form') {
            f.submit()
          }
        })
      }
    }
  }
}
