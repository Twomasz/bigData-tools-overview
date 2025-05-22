import csv
import os

def split_csv(input_file, output_file, max_rows=10_000_000):
    """
    Write the first million rows from input_file to output_file.
    
    Args:
        input_file (str): Path to the input CSV file
        output_file (str): Path to the output CSV file
        max_rows (int): Maximum number of rows to write
    """
    row_count = 0
    
    # Check if input file exists
    if not os.path.exists(input_file):
        raise FileNotFoundError(f"Input file not found: {input_file}")
    
    print(f"Reading from {input_file} and writing first {max_rows} rows to {output_file}")
    
    with open(input_file, 'r', newline='', encoding='latin-1') as infile:
        reader = csv.reader(infile)
        header = next(reader)
        
        with open(output_file, 'w', newline='') as outfile:
            writer = csv.writer(outfile)
            writer.writerow(header)
            
            for row in reader:
                writer.writerow(row)
                row_count += 1
                
                if row_count % 100000 == 0:
                    print(f"Processed {row_count} rows...")
                
                if row_count >= max_rows:
                    break
    
    print(f"Done! Wrote {row_count} rows to {output_file}")

if __name__ == "__main__":
    input_file = "data/airline.csv.shuffle" 
    output_file = "data/ten_million_airline.csv"
    
    split_csv(input_file, output_file)