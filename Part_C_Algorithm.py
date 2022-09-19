def main():
    # change this value to do the experiment
    list_block = [8, 8, 5, 7, 9, 8, 7, 4, 8]

    min_block = count_min_block(list_block)
    print(min_block)

def count_min_block(list_block):
    count = 0

    # stopping condition
    if len(list_block) == 0:
        return 0
    
    # get min value
    min_num = min(list_block)

    # if there's 0, split list into 2 separate list
    if min_num == 0:
        count += count_min_block(list_block[:list_block.index(0)])
        count += count_min_block(list_block[list_block.index(0) + 1:])
        return count
    
    # decrease all list value by the minimum value (+1 wall block)
    list_block = list(map(lambda num: num - min_num, list_block))
    count += 1
    count += count_min_block(list_block)

    return count

main()