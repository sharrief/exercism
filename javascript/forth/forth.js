export class Forth {
  _stack = []
  words = new Map([
    ['DUP', this.DUP],
    ['DROP', this.DROP],
    ['SWAP', this.SWAP],
    ['OVER', this.OVER],
    ['+', this.ADD],
    ['-', this.SUB],
    ['*', this.MULT],
    ['/', this.DIV]
  ])

  evaluate(program) {
    const tokens = program.toUpperCase().split(' ').reverse()

    let token
    while (token = tokens.pop()) {

      if (!isNaN(token)) {
        this._stack.push(Number(token))
        continue
      }

      if (token == ':') {
        this.defineWord(tokens)
        continue
      }

      const definition = this.words.get(token)

      if (typeof definition == 'string')
        this.evaluate(definition)

      else if (typeof definition === 'function')
        definition.bind(this)()

      else
        throw new Error('Unknown command')
    }
  }

  /** 
  * Extracts the entire definition from the array of tokens, mutating it.
  * Creates a new word with the extracted tokens as its definition.
  * @param {string[]} tokens
  */
  defineWord(tokens) {
    const word = tokens.pop()

    if (!isNaN(word)) throw new Error("Invalid definition")

    // definitions can be nested
    // we are done with this definition when depth reaches 0
    let depth = 1
    const definition_tokens = []

    while (depth > 0) {
      let sub_token = tokens.pop()

      if (sub_token == ':')
        depth++

      else if (sub_token == ';')
        depth--

      // replace custom words with their definition
      else if (typeof this.words.get(sub_token) == 'string')
        sub_token = this.words.get(sub_token)

      // don't include the ending semi in the definition
      if (depth == 0) break;

      definition_tokens.push(sub_token)
    }

    this.words.set(word, definition_tokens.join(' '))
  }

  get stack() {
    return [...this._stack]
  }

  get len() {
    return this._stack.length
  }

  getArgs(size) {
    if (size > this.len)
      switch (this.len) {
        case 0: throw new Error("Stack empty")
        case 1: throw new Error("Only one value on the stack")
      }
    switch (size) {
      case 1: return [this._stack.pop()]
      case 2: return [this._stack.pop(), this._stack.pop()]
    }
  }

  DUP() {
    const [x0] = this.getArgs(1)
    this._stack.push(x0, x0)
  }
  DROP() {
    this.getArgs(1)
  }
  SWAP() {
    const [x0, x1] = this.getArgs(2)
    this._stack.push(x0, x1)
  }
  OVER() {
    const [x0, x1] = this.getArgs(2)
    this._stack.push(x1, x0, x1)
  }

  ADD() {
    const [x0, x1] = this.getArgs(2)
    this._stack.push(x0 + x1)
  }

  SUB() {
    const [x0, x1] = this.getArgs(2)
    this._stack.push(x1 - x0)
  }

  MULT() {
    const [x0, x1] = this.getArgs(2)
    this._stack.push(x0 * x1)
  }

  DIV() {
    const [x0, x1] = this.getArgs(2)
    if (x0 == 0) throw new Error("Division by zero")
    this._stack.push(Math.floor(x1 / x0))
  }
}
