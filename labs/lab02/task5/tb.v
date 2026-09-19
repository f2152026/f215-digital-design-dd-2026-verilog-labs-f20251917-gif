// tb.v
// Self-checking testbench for alu

module tb;

    reg [3:0] a, b;
    reg op;
    wire [3:0] result;

    alu dut (
        .a(a),
        .b(b),
        .op(op),
        .result(result)
    );

    task check;
        input [3:0] expected;
        begin
            #1;
            if (result !== expected)
                $display("FAIL: a=%d b=%d op=%b | Got=%d Expected=%d",
                         a, b, op, result, expected);
            else
                $display("PASS: a=%d b=%d op=%b | result=%d",
                         a, b, op, result);
        end
    endtask

    initial begin
        // Same operands, switch op
        a = 4'd7;
        b = 4'd3;

        op = 1'b0;       // add
        check(4'd10);

        op = 1'b1;       // subtract
        check(4'd4);

        // Change operands and test both operations
        a = 4'd5;
        b = 4'd9;

        op = 1'b0;       // add
        check(4'd14);

        op = 1'b1;       // subtract: 5 - 9 = -4 = 4'b1100
        check(4'b1100);

        // Another subtraction
        a = 4'd12;
        b = 4'd5;

        op = 1'b1;
        check(4'd7);

        $finish;
    end

endmodule