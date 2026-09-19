// tb.v
// Self-checking testbench for comp2

module tb;

    reg [1:0] t_a, t_b;
    wire t_gt, t_lt, t_eq;

    integer a, b;
    integer errors;
    integer total;

    // Instantiate DUT
    comp2 DUT (
        .A(t_a),
        .B(t_b),
        .GT(t_gt),
        .LT(t_lt),
        .EQ(t_eq)
    );

    initial begin
        errors = 0;
        total = 0;

        // Test all 16 possible input combinations
        for (a = 0; a < 4; a = a + 1) begin
            for (b = 0; b < 4; b = b + 1) begin

                t_a = a;
                t_b = b;

                #1;

                // Expected results
                if ({t_gt, t_lt, t_eq} !== {
                    (a > b),
                    (a < b),
                    (a == b)
                }) begin

                    $display(
                        "FAIL: A=%b B=%b | Got GT=%b LT=%b EQ=%b | Expected GT=%b LT=%b EQ=%b",
                        t_a, t_b,
                        t_gt, t_lt, t_eq,
                        (a > b), (a < b), (a == b)
                    );

                    errors = errors + 1;
                end

                total = total + 1;
            end
        end

        $display("--------------------------------");
        $display("RESULT: %0d/%0d tests passed", total - errors, total);
        $display("Errors: %0d", errors);
        $display("--------------------------------");

        $finish;
    end

endmodule