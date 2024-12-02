import gleam/int
import gleam/io
import gleam/list
import gleam/string
import simplifile as fs

fn read_input() {
  let assert Ok(text) = fs.read("input.txt")
  text
}

fn parse(text: String) -> #(List(Int), List(Int)) {
  text
  |> string.split("\n")
  |> list.map(fn(line) { line |> string.split("   ") })
  |> list.map(fn(x) { x |> list.map(int.parse) })
  |> list.filter_map(fn(x) {
    case x {
      [Ok(l), Ok(r)] -> Ok(#(l, r))
      _ -> Error("")
    }
  })
  |> list.fold(#([], []), fn(acc, cur) {
    let #(left_list, right_list) = acc
    let #(left, right) = cur
    #([left, ..left_list], [right, ..right_list])
  })
}

fn part1(text: String) -> Int {
  parse(text)
  |> fn(x) {
    let #(left_list, right_list) = x
    let left_sorted = left_list |> list.sort(int.compare)
    let right_sorted = right_list |> list.sort(int.compare)
    #(left_sorted, right_sorted)
  }
  |> fn(x) {
    let #(left_list, right_list) = x
    list.zip(left_list, right_list)
  }
  |> list.fold(0, fn(acc, cur) {
    let #(l, r) = cur
    acc + int.absolute_value(l - r)
  })
}

fn part2(text: String) -> Int {
  parse(text)
  |> fn(x) {
    let #(left_list, right_list) = x
    list.fold(left_list, 0, fn(acc, l) {
      acc + { l * list.count(right_list, fn(r) { r == l }) }
    })
  }
}

pub fn main() {
  let input =
    "3   4
4   3
2   5
1   3
3   9
3   3"
  read_input()
  |> part1
  |> io.debug

  read_input()
  |> part2
  |> io.debug
}
