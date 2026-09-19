// and_beh_before.v
// Behavioral AND gate with delay before assignment

module and_beh_before (
    input a,
    input b,
    output reg y
);

always @(*) begin
    #1 y = a & b;
end

endmodule