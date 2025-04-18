import csv

def parse_hex_line(line):
    """Convert a line of space-separated or comma-separated hex values to a list of uppercase hex strings."""
    return [val.strip()[2:].upper().zfill(2) for val in line.strip().replace(",", " ").split()]

def parse_csv_file(csv_filename):
    """Read CSV file and return a list of hex value lists (ignoring the index column)."""
    csv_data = []
    with open(csv_filename, newline='') as csvfile:
        reader = csv.reader(csvfile)
        next(reader)  # Skip header
        for row in reader:
            csv_data.append([val.upper().zfill(2) for val in row[1:]])  # Ignore index
    return csv_data

def compare_files(hex_filename, csv_filename, output_filename):
    """Compare hex file line by line with reference CSV, mark mismatches, and output results."""
    with open(hex_filename, 'r') as hex_file:
        hex_lines = [line.strip() for line in hex_file]  # Keep original lines
        parsed_hex_lines = [parse_hex_line(line) for line in hex_lines]

    csv_lines = parse_csv_file(csv_filename)

    csv_index = 0  # Tracks position in the CSV reference
    last_matched_index = None  # Track last successfully matched CSV line
    mismatches = []
    updated_lines = []

    for i, (hex_line, original_line) in enumerate(zip(parsed_hex_lines, hex_lines)):
        if last_matched_index is not None and csv_lines[last_matched_index] == hex_line:
            # This line is a duplicate of the last matched CSV line -> Accept without checking
            updated_lines.append(original_line)
            continue

        found_match = False
        incorrect_bytes = []  # Store incorrect bytes for marking

        # Look ahead in CSV reference to find the first matching line
        for j in range(csv_index, len(csv_lines)):
            if csv_lines[j] == hex_line:
                csv_index = j + 1  # Move the CSV index forward
                last_matched_index = j  # Store last successful match
                found_match = True
                break

        if found_match:
            updated_lines.append(original_line)  # Keep the line unmodified
        else:
            # Identify incorrect bytes using the last known good match
            expected_line = csv_lines[last_matched_index] if last_matched_index is not None else None

            if expected_line:
                incorrect_bytes = [
                    f"{hex_line[k]}->{expected_line[k]}" for k in range(min(len(hex_line), len(expected_line))) if hex_line[k] != expected_line[k]
                ]

            error_msg = "  # " + ", ".join(incorrect_bytes) if incorrect_bytes else "  # (unknown error)"
            mismatches.append(f"Line {i + 1} mismatch: {original_line}{error_msg}")
            updated_lines.append(original_line + error_msg)  # Mark mismatched line with incorrect bytes

    # Write the updated hex file with mismatched lines marked
    with open(output_filename, 'w') as out_file:
        out_file.write("\n".join(updated_lines) + "\n")

    if mismatches:
        print("\nMismatched lines found:")
        for mismatch in mismatches:
            print(mismatch)
    else:
        print("Files match sequentially!")

# Example usage
compare_files("log_10000us_tick_10000Hz.csv", "data.csv", "output.csv")

