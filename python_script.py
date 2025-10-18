import struct

# Function to convert hexadecimal to signed floating point numbers
def hex_to_float(hex_list):

    float_list = []
    
    for hex_num in hex_list:
        try:
            # Convert the hex string to a binary representation (4 bytes for single-precision)
            binary_data = bytes.fromhex(hex_num)
            
            # Convert the binary data to a signed floating-point number (assuming single precision)
            float_num = struct.unpack('!f', binary_data)[0]
            
            # Append the result to the list
            float_list.append(float_num)
        
        except (ValueError, struct.error):
            float_list.append("Invalid or incompatible input")
    
    return float_list

# Example usage: List of hex numbers representing IEEE 754 single-precision floating points

hex_list = []
 # Example hex list

# Convert hex to signed floating point numbers
float_list = hex_to_float(hex_list)

# Print the results
for i, f in enumerate(float_list):
    print(f"Hexadecimal: {hex_list[i]} -> Floating-point: {f:.4f}")

new_float_list = [round(f, 4) for f in float_list]

def print_matrix(lst, rows, cols):
    if len(lst) != rows * cols:
        print("Error: The list size does not match the specified matrix order.")
        return
    
    # Generate the matrix by slicing the list
    matrix = [lst[i * cols:(i + 1) * cols] for i in range(rows)]
    
    # Print the matrix in a readable format
    for row in matrix:
        print(" ".join(map(str, row)))

# Example usage
rows = 5
cols = 5

print("The matrix is:")
print_matrix(new_float_list, rows, cols)
