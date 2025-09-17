import csv
from robot.api.deco import keyword
import random

@keyword
def get_total_rows_excluding_headers():
    csv_file_path = 'formdata.csv'
    with open(csv_file_path, newline='', encoding='utf-8') as csvfile:
        reader = csv.reader(csvfile)
        next(reader, None)  # Skip header
        return sum(1 for _ in reader)
    
@keyword
def get_row_values_as_list(row_number):
    csv_file_path = 'formdata.csv'
    with open(csv_file_path, newline='', encoding='utf-8') as csvfile:
        reader = csv.reader(csvfile)
        next(reader, None)  # Skip header
        for idx, row in enumerate(reader, start=1):
            if idx == row_number:
                return row
    return []

@keyword
def shuffle_list(input_list):
    shuffled = input_list[:]
    random.shuffle(shuffled)
    return shuffled


@keyword
def generate_random_integer(start, end):
    """
    Generate a random integer between start and end (inclusive).
    """
    return random.randint(start, end)
# Example usage:
if __name__ == "__main__":
    csv_path = 'formdata.csv'
    total_rows = get_total_rows_excluding_headers(csv_path)
    print(f"Total rows (excluding headers): {total_rows}")