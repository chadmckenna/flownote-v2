export const setupKeybindings = () => {
  const notesShowRegEx = /^(\/notes\/)(\d+$)/i
  const notesEditRegEx = /^(\/notes\/)(\d+\/)(edit)/i
  const notesNewRegEx = /^(\/notes\/)(new)/i

  document.onkeyup = (e) => {
    if (e.ctrlKey && e.key === 'n') {
      Turbo.visit('/notes/new')
    }
    if (e.ctrlKey && e.key === 'a') {
      Turbo.visit('/notes')
    }

    if (notesShowRegEx.test(window.location.pathname)) {
      if (e.ctrlKey && e.key === 'i') {
        Turbo.visit(`/notes/${notesShowRegEx.exec(window.location.pathname)[2]}/edit`)
      }
    }

    if (notesEditRegEx.test(window.location.pathname) || notesNewRegEx.test(window.location.pathname)) {
      if (e.ctrlKey && e.key === 'w') {
        document.forms[0].submit()
      }
    }
  }
}
