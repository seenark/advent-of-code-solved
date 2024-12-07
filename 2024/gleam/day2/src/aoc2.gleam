import gleam/int
import gleam/io
import gleam/list
import gleam/string
import simplifile as fs

//   let input =
//     "7 6 4 2 1
// 1 2 7 8 9
// 9 7 6 2 1
// 1 3 2 4 5
// 8 6 4 4 1
// 1 3 6 7 9
//     "

fn read_input() {
  let assert Ok(text) = fs.read("src/input.txt")
  text
}

fn parase(text: String) {
  text
  |> string.trim
  |> string.split("\n")
  |> list.map(fn(x) { string.split(x, " ") })
  |> list.map(fn(x) { list.map(x, int.parse) })
  |> list.map(fn(x) {
    list.filter_map(x, fn(y) {
      case y {
        Ok(i) -> Ok(i)
        _ -> Error("")
      }
    })
  })
  |> list.map(fn(x) { x })
}

fn is_safe_list(test_list: List(Int)) {
  list.drop(up_to: 1, from: test_list)
  |> list.map2(test_list, int.subtract)
  |> fn(x) {
    list.all(x, fn(x) { x >= 1 && x <= 3 })
    || list.all(x, fn(x) { x <= -1 && x >= -3 })
  }
}

pub fn main() {
  let count =
    read_input()
    |> parase
    // parase(input)
    |> list.map(is_safe_list)
    |> list.count(fn(x) { x })

  io.debug(count)
}
