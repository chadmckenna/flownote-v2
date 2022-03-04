export const setupKeybindings = () => {
  const notesShowRegEx = /^(\/notes\/)(\d+$)/i
  const notesHistoryRegEx = /^(\/notes\/)(\d+)(\/history)$/i
  const notesEditRegEx = /^(\/notes\/)(\d+)(\/edit)$/i
  const notesNewRegEx = /^(\/notes\/)(new)/i

  document.onkeyup = (e) => {
    // setKeybinding([notesShowRegEx, notesHistoryRegEx], [['ctrlKey', true], ['key', 'i']], '/search')
    const setKeybinding = (where, keys, action) => {
      if (where.length === 0 || where.some((l) => l.test(window.location.pathname))) {
        if (keys.every((k) => e[k[0]] === k[1] )) {
          action()
        }
      }
    }

    const navTo = (relUrl, regex = []) => {
      if (regex.length === 2) {
        if (regex[1].exec(window.location.pathname)) {
          const id = regex[1].exec(window.location.pathname)[2]
          return () => { Turbo.visit(relUrl.replace(regex[0], id)) }
        } else {
          return () => {}
        }
      } else {
        return () => { Turbo.visit(relUrl) }
      }
    }

    const submitEditForm = () => {
      Object.values(document.forms).forEach((f) => {
        if (f.id === 'note_edit_form') {
          f.submit()
        }
      })
    }

    // Global keybindings
    // -> Mac keybindings
    setKeybinding([], [['ctrlKey', true], ['key', 'n']], navTo('/notes/new'))
    setKeybinding([], [['ctrlKey', true], ['key', 'a']], navTo('/notes'))
    setKeybinding([], [['ctrlKey', true], ['key', '\\']], navTo('/search'))

    // -> Windows keybindings
    setKeybinding([], [['altKey', true], ['shiftKey', true], ['code', 'KeyN']], navTo('/notes/new'))
    setKeybinding([], [['altKey', true], ['shiftKey', true], ['code', 'KeyA']], navTo('/notes'))
    setKeybinding([], [['altKey', true], ['shiftKey', true], ['code', 'Backslash']], navTo('/search'))

    // Show page specific keybindings
    // -> Mac keybindings
    setKeybinding([notesShowRegEx], [['ctrlKey', true], ['key', 'i']], navTo('/notes/:id/edit', [':id', notesShowRegEx]))
    setKeybinding([notesShowRegEx], [['ctrlKey', true], ['key', 'h']], navTo('/notes/:id/history', [':id', notesShowRegEx]))

    // -> Windows keybindings
    setKeybinding([notesShowRegEx], [['altKey', true], ['shiftKey', true], ['code', 'KeyI']], navTo('/notes/:id/edit', [':id', notesShowRegEx]))
    setKeybinding([notesShowRegEx], [['altKey', true], ['shiftKey', true], ['code', 'KeyH']], navTo('/notes/:id/history', [':id', notesShowRegEx]))

    // History page specific keybindings
    // -> Mac keybindings
    setKeybinding([notesHistoryRegEx], [['ctrlKey', true], ['key', 'i']], navTo('/notes/:id/edit', [':id', notesHistoryRegEx]))
    setKeybinding([notesHistoryRegEx], [['ctrlKey', true], ['key', 'v']], navTo('/notes/:id', [':id', notesHistoryRegEx]))

    // -> Windows keybindings
    setKeybinding([notesHistoryRegEx], [['altKey', true], ['shiftKey', true], ['code', 'KeyI']], navTo('/notes/:id/edit', [':id', notesHistoryRegEx]))
    setKeybinding([notesHistoryRegEx], [['altKey', true], ['shiftKey', true], ['code', 'KeyV']], navTo('/notes/:id', [':id', notesHistoryRegEx]))

    // Edit page specific keybindings
    // -> Mac keybindings
    setKeybinding([notesEditRegEx], [['ctrlKey', true], ['key', 'h']], navTo('/notes/:id/history', [':id', notesEditRegEx]))
    setKeybinding([notesEditRegEx], [['ctrlKey', true], ['key', 'v']], navTo('/notes/:id', [':id', notesHistoryRegEx]))

    // -> Windows keybindings
    setKeybinding([notesEditRegEx], [['altKey', true], ['shiftKey', true], ['code', 'KeyH']], navTo('/notes/:id/history', [':id', notesEditRegEx]))
    setKeybinding([notesEditRegEx], [['altKey', true], ['shiftKey', true], ['code', 'KeyV']], navTo('/notes/:id', [':id', notesHistoryRegEx]))

    // Edit or New page specific keybindings
    // -> Mac keybindings
    setKeybinding([notesEditRegEx, notesNewRegEx], [['ctrlKey', true], ['key', 's']], submitEditForm)

    // -> Windows keybindings
    setKeybinding([notesEditRegEx, notesNewRegEx], [['ctrlKey', true], ['shiftKey', true], ['code', 'KeyS']], submitEditForm)
  }
}
