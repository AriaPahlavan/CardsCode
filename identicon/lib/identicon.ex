defmodule Identicon do

  @num_rows 5
  @square_size 50
  @grid_size 250

  def main do
    main "ariapr"
  end

  def main(name) do
    name
    |> hash_input
    |> pic_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
    |> draw_image
    |> save_identicon(name)
  end

  def save_identicon(image, filename) do
    File.write("#{filename}.ing", image)

  end

  def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(@grid_size, @grid_size)
    fill = :egd.color(color)

    Enum.each pixel_map, fn({start, stop}) ->
      :egd.filledRectangle(image, start, stop, fill)
    end

    :egd.render(image)
  end

  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel_map =
      Enum.map grid, fn({_code, index}) ->
        horizontal = rem(index, @num_rows) * @square_size
        vertical = div(index, @num_rows) * @square_size

        top_left = {horizontal, vertical}
        bottom_right = {horizontal + @square_size, vertical + @square_size}

        {top_left, bottom_right}
      end

    %Identicon.Image{image | pixel_map: pixel_map}
  end

  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    grid=
      Enum.filter grid, fn({code, _index}) ->
        rem(code, 2) == 0
      end

    %Identicon.Image{image | grid: grid }
  end

  def build_grid(%Identicon.Image{seed: hex} = image) do
    grid =
      hex
      |> Enum.chunk(3)
      # |> Enum.map(&mirror_row/1)               # method 1 pass func reference
      |> Enum.map(fn(row) -> mirror_row row end) # method 2 lambda expression
      |> List.flatten
      |> Enum.with_index

    %Identicon.Image{image | grid: grid}
  end

  def mirror_row(row) do
    [first, second | _tail] = row
    row ++ [second, first]
  end

  def pic_color(%Identicon.Image{seed: [r, g, b | _tail]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end

  def hash_input(input) do
    hex_list = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{seed: hex_list}
  end
end
