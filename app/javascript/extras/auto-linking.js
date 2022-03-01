import { CompletionContext } from '@codemirror/autocomplete'
import { syntaxTree } from "@codemirror/language"

var fetchLinks = []

const noteLinkCompletion = (context) => {
  let word = context.matchBefore(/\w*/)
  let nodeBefore = syntaxTree(context.state).resolveInner(context.pos, -1)

  if (!['Image', 'Link'].includes(nodeBefore.name)) return null
  if (word.from == word.to && !context.explicit) return null

  let options = []

  fetchLinks.forEach((link) => {
    options.push({
      label: link.search_title,
      type: link.type,
      apply: (view, completion, from, to) => {
        const ins =`[${link.title}](${link.url})`

        view.dispatch({
          changes: { from: from - 1, to: to + 1, insert: ins },
          selection: { anchor: from - 1 + ins.length },
          userEvent: "input.complete",
        })
      }
    })
  })

  return {
    from: word.from,
    options: options,
  }
}

export const autoLinking = () => {
  fetch('/links.json')
    .then((response) => response.json())
    .then((results) => fetchLinks = results)
  return noteLinkCompletion
}
