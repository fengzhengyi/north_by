import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sort"
export default class extends Controller {
  static targets = ['sortElement']

  initialize() {
    const target = this.element
    const observer = new MutationObserver((mutations) => {
      observer.disconnect()
      Promise.resolve().then(start)
      this.sortTargets()
    })
    function start() {
      observer.observe(target, { subtree: true, childList: true })
    }
    start()
  }

  sortTargets() {
    if (this.targetsAlreadySorted()) {
      return
    }
    // 添加的节点可以是已经存在于文档中的节点，这样会将其从原来的位置移动到新的位置。
    // 如果希望复制一个节点而不是移动它，可以使用cloneNode()方法先复制节点，然后再添加
    this.sortElementTargets.sort((a, b) => this.sortValue(a) - this.sortValue(b))
      .forEach(elm => this.element.append(elm))
  }

  targetsAlreadySorted() {
    let [first, ...rest] = this.sortElementTargets
    for (const next of rest) {
      if (this.sortValue(first) > this.sortValue(next)) {
        return false
      }
      first = next
    }
    return true
  }

  sortValue(element) {
    return parseInt(element.dataset.sortValue, 10)
  }
}
