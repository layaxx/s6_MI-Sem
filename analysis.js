const readline = require("readline")
const fs = require("fs")
const path = require("path")

const prefix = process.argv[3] ?? "data/formatted"

const strings = []

const filename = process.argv[2] ?? "data/t.jsonl"

function processLine(line) {
  const { id, articles, summary } = JSON.parse(line)

  const string = JSON.stringify({
    id: id,
    numberArticles: articles.length,
    articleLengths: articles.map((article) => article.text.length),
    lengthSummary: summary.length,
  })

  strings.push(string)
}

try {
  fs.rmdirSync(prefix, { recursive: true })
} catch (error) {
  console.log(error)
  // Allowed to fail if no directory exists
}

fs.mkdirSync(prefix, { recursive: true })

const readInterface = readline.createInterface({
  input: fs.createReadStream(filename),
  output: false,
})

readInterface.on("line", processLine)

readInterface.on("close", function () {
  fs.writeFileSync(
    path.join(
      filename.split("/")[filename.split("/").length - 1].split(".")[0] +
        ".json"
    ),
    "{values: [" + strings.join(",\n") + "]}"
  )
  console.log("done")
})
