class Game 

    @width
    @height
    @columns
    @@empty = ' '

    def initialize()
        @width = 7
        @height = 6
        @columns = []
        @width.times do 
            @columns << Array.new(@height, @@empty)
        end
    end

    def show()
        puts state_as_text()
    end

    def state_as_text()
        text = ""
        (0...@height).reverse_each{ |idx|
            row = []
            @columns.each{|column|
                val = column[idx]
                row << val
            }
            text += "|#{row.join('|')}|\n" 
        }
        text += "---------------\n"
        text += "|0|1|2|3|4|5|6|\n"
        return text
    end

    def add_token_to_column(token, column)
        row = @columns[column]
        if row.include?(@@empty) 
            row[row.index(@@empty)] = token
        else
            false
        end
    end

    def take_computer_turn(computer_token, player_token)
        column = nil
        if potential_column_neighbor_counts(computer_token)[3]
            column = potential_column_neighbor_counts(computer_token)[3].sample
        elsif potential_column_neighbor_counts(player_token).max_by{|k,v| k}[0] >= 2
            column = potential_column_neighbor_counts(player_token).max_by{|k,v| k}[1].sample
        else
            column = potential_column_neighbor_counts(computer_token).max_by{|k,v| k}[1].sample
        end
        add_token_to_column(computer_token, column)
    end

    def potential_column_neighbor_counts(token)
        column_neighbor_counts(token, true)
    end

    def column_neighbor_counts(token, potential = false)
        column_neighbor_count = Hash.new
        (0...@width).each{|i|
            if(potential)
                j = @columns[i].index(@@empty)
            else
                j = @columns[i].rindex(token)
            end
            if j != nil
                count = neighbor_count(token, i, j)
            else
                count = 0
            end
            if column_neighbor_count[count] == nil
                column_neighbor_count[count] = []
            end
            column_neighbor_count[count] << i
        }
        return column_neighbor_count
    end

    def neighbor_count(token, i, j)
        neighbor_counts = []
        #down
        col = i
        row = j - 1
        count = 0
        while row >= 0 && @columns[col][row] == token do
            count += 1
            row -= 1
        end
        neighbor_counts << count
        #across
        col = i + 1
        row = j
        count = 0
        while col < @width && @columns[col][row] == token do
            count += 1
            col += 1
        end
        col = i - 1
        while col >= 0 && @columns[col][row] == token do
            count += 1
            col -= 1
        end
        neighbor_counts << count
        #upright and downleft
        #upright
        col = i + 1
        row = j + 1
        count = 0
        while row < @height && col < @width && @columns[col][row] == token do
            count += 1
            row += 1
            col += 1
        end
        #downleft
        col = i - 1
        row = j - 1
        while row >= 0 && col >= 0 && @columns[col][row] == token do
            count += 1
            row -= 1
            col -= 1
        end
        neighbor_counts << count
        #upleft and downright
        #upleft
        col = i - 1
        row = j + 1
        count = 0
        while row < @height && col >= 0 && @columns[col][row] == token do
            count += 1
            row += 1
            col -= 1
        end
        #downright
        col = i + 1
        row = j - 1
        while row >= 0 && col < @width && @columns[col][row] == token do
            count += 1
            row -= 1
            col += 1
        end
        neighbor_counts << count
        neighbor_counts.max
    end    

    def is_won?(token)
        column_neighbor_counts(token).keys.max >= 3
    end
    
    def is_draw?
        !@columns.join.include?(@@empty)
    end        

end