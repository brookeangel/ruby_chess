module BoardCastleable
  def castle(fin)
    start_row = fin[0]
    start_col = fin[1] < 3 ? 0 : 7

    end_row = fin[0]
    end_col = fin[1] < 3 ? 2 : 5

    move!([start_row, start_col], [end_row, end_col])
  end

  def castle?(start, fin)
    self[*start].class == King && !(fin[1] - start[1]).between?(-1, 1)
  end
end
