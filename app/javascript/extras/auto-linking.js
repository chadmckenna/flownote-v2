import { CompletionContext } from '@codemirror/autocomplete'
import { syntaxTree } from "@codemirror/language"

const fetchNotes = fetch('/notes/all.json').then((response) => response.json())

export const noteLinkCompletion = (context) => {
  let word = context.matchBefore(/\w*/)
  let nodeBefore = syntaxTree(context.state).resolveInner(context.pos, -1)

  if (nodeBefore.name !== 'Link') return null
  if (word.from == word.to && !context.explicit) return null

  let options = []

  fetchNotes.then((results) => {
    results.forEach((n) => {
      options.push({
        label: n.title,
        type: 'url',
        apply: (view, completion, from, to) => {
          const ins =`[${n.title}](${n.url})`

          view.dispatch({
            changes: { from: from - 1, to: to + 1, insert: ins },
            selection: { anchor: from - 1 + ins.length },
            userEvent: "input.complete",
          })
        }
      })
    })
  })

  return {
    from: word.from,
    options: options,
  }
}
