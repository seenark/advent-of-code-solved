import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import simplifile as fs

fn read_input() {
  let assert Ok(text) = fs.read("src/input.txt")
  text
}

fn parase(text: String) -> List(List(Int)) {
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

fn p1(input: List(List(Int))) -> Int {
  input
  |> list.map(is_safe_list)
  |> list.count(fn(x) { x })
}

fn dampen(input: List(Int)) -> List(List(Int)) {
  io.print("input: ")
  io.debug(input)
  case input {
    [] -> [[]]
    [lv, ..remain] -> {
      io.print("lv: ")
      io.debug(lv)
      let result =
        dampen(remain)
        |> list.map(fn(x) { [lv, ..x] })
        |> fn(x) {
          io.print("after map: ")
          io.debug(x)
          io.print("remain: ")
          io.debug(remain)
          x
        }
        |> list.prepend(this: remain)
      io.print("result: ")
      io.debug(result)

      result
      // dampen(remain)
      // |> list.map(fn(x) { [lv, ..x] })
      // |> fn(x) { x }
      // |> list.prepend(this: remain)
    }
  }
}

fn p2(input: List(List(Int))) -> Int {
  use l <- list.count(input)
  dampen(l)
  |> list.any(is_safe_list)
}

//   let input =
//     "7 6 4 2 1
// 1 2 7 8 9
// 9 7 6 2 1
// 1 3 2 4 5
// 8 6 4 4 1
// 1 3 6 7 9
//     "
pub fn main() {
  let input =
    "7 6 4
    "
  // let count =
  //   read_input()
  let count =
    input
    |> parase
    |> p2

  io.debug(count)
}
