import csv
import argparse

def hex_format(value):
    # Ensure the value is represented as a 4-digit hex
    return f'x"{value.zfill(4)}"'

def process_csv(input_file, output_file, num_rows=None):
    with open(input_file, newline='', mode='r') as csvfile:
        reader = csv.reader(csvfile)
        
        # Skip the first row (which is a comment or any unwanted row)
        next(reader)
        
        # Read headers
        headers = next(reader)
        
        # Prepare the dictionary to store the LUT data
        lut_data = {key[:-2]: [] for key in headers if "_H" in key}  # Only keys with "_H"
        
        # Process the rows up to the specified number
        row_count = 0
        for row in reader:
            if num_rows and row_count >= num_rows:
                break
            for i, header in enumerate(headers):
                if "_H" in header:
                    base_name = header[:-2]  # Strip _H suffix
                    low_key = base_name + "_L"
                    if low_key in headers:
                        high_value = row[i]
                        low_value = row[headers.index(low_key)]
                        lut_data[base_name].append(hex_format(high_value + low_value))
            row_count += 1
        
        # Write the VHDL output
        with open(output_file, 'w') as vhdlfile:
            # Define the LUT array type and size based on the number of elements per LUT
            vhdlfile.write(f'type dummy_lut_t is array (0 to {len(lut_data["AccelX"])-1}) of std_logic_vector(15 downto 0);\n\n')
            
            for key, values in lut_data.items():
                vhdlfile.write(f"signal s_dummy_{key.lower()}_lut : dummy_lut_t := (\n")
                for i in range(0, len(values), 8):  # Group in 8 values per line
                    vhdlfile.write("    " + ", ".join(values[i:i+8]) + ",\n")
                vhdlfile.write(");\n\n")

# Command-line argument parsing
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Process CSV to generate VHDL LUTs.")
    parser.add_argument("input_file", help="The input CSV file")
    parser.add_argument("output_file", help="The output VHDL file")
    parser.add_argument("--rows", type=int, default=None, help="Number of rows to process from the CSV")
    
    args = parser.parse_args()
    
    # Process the CSV with the specified number of rows (if provided)
    process_csv(args.input_file, args.output_file, num_rows=args.rows)

