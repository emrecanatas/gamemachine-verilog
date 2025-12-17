module gamemachine_tb();

    reg clk;
    reg rst;
    reg enter1;
    reg enter2;
    reg [2:0] dataIn;
    
    wire [3:0] score1;
    wire [3:0] score2;
    
    gamemachine dut(
        .clk(clk),
        .rst(rst),
        .enter1(enter1),
        .enter2(enter2),
        .dataIn(dataIn),
        .score1(score1),
        .score2(score2)
    );
    
    // Half period of our clock signal
    parameter HP = 5;
    // Full period of our clock signal
    parameter FP = (2*HP);
    
    // For generating the clock signal
    always #HP clk = ~clk;
    

    initial begin
    //  * Our waveform is saved under this file.
    $dumpfile("gamemachine_tb.vcd");

    // * Get the variables from the module.
    $dumpvars(0,gamemachine_tb);

    $display("Simulation started.");

    clk = 1;
    rst = 1;
    enter1 = 0;
    enter2 = 0;
    dataIn = 0;

    // ================= RESET =================
    rst = 0;
    #20;
    rst = 1;
    #FP;
    // ======================================================
    // CASE 1
    // P1: 0 1 2 3
    // P2: 0 1 2 4
    // Expected -> Score1 = 2 , Score2 = 6
    // ======================================================
    dataIn=0; enter1=1; #FP; enter1=0; #FP;
    dataIn=1; enter1=1; #FP; enter1=0; #FP;
    dataIn=2; enter1=1; #FP; enter1=0; #FP;
    dataIn=3; enter1=1; #FP; enter1=0; #FP;

    dataIn=0; enter2=1; #FP; enter2=0; #FP;
    dataIn=1; enter2=1; #FP; enter2=0; #FP;
    dataIn=2; enter2=1; #FP; enter2=0; #FP;
    dataIn=4; enter2=1; #FP; enter2=0; #FP;

    #(FP*3);
    $display("CASE 1 -> Score1 = %d | Score2 = %d", score1, score2);

    // ================= RESET =================
    rst = 0; #FP; rst = 1; #FP;

    // ======================================================
    // CASE 2
    // P1: 0 1 2 3
    // P2: 0 1 3 2
    // Expected -> Score1 = 2 , Score2 = 6
    // ======================================================
    dataIn=0; enter1=1; #FP; enter1=0; #FP;
    dataIn=1; enter1=1; #FP; enter1=0; #FP;
    dataIn=2; enter1=1; #FP; enter1=0; #FP;
    dataIn=3; enter1=1; #FP; enter1=0; #FP;

    dataIn=0; enter2=1; #FP; enter2=0; #FP;
    dataIn=1; enter2=1; #FP; enter2=0; #FP;
    dataIn=3; enter2=1; #FP; enter2=0; #FP;
    dataIn=2; enter2=1; #FP; enter2=0; #FP;

    #(FP*3);
   
    $display("CASE 2 -> Score1 = %d | Score2 = %d", score1, score2);

    // ================= RESET =================
    rst = 0; #20; rst = 1;
    #FP;
    // ======================================================
    // CASE 3
    // P1: 0 1 2 3
    // P2: 1 0 4 3
    // Expected -> Score1 = 4 , Score2 = 4
    // ======================================================
    dataIn=0; enter1=1; #FP; enter1=0; #FP;
    dataIn=1; enter1=1; #FP; enter1=0; #FP;
    dataIn=2; enter1=1; #FP; enter1=0; #FP;
    dataIn=3; enter1=1; #FP; enter1=0; #FP;

    dataIn=1; enter2=1; #FP; enter2=0; #FP;
    dataIn=0; enter2=1; #FP; enter2=0; #FP;
    dataIn=4; enter2=1; #FP; enter2=0; #FP;
    dataIn=3; enter2=1; #FP; enter2=0; #FP;

    #(FP*3);
    $display("CASE 3 -> Score1 = %d | Score2 = %d", score1, score2);

    // ================= RESET =================
    rst = 0; #20; rst = 1;
    #FP;
    // ======================================================
    // CASE 4
    // P1: 0 1 2 3
    // P2: 4 5 6 7
    // Expected -> Score1 = 8 , Score2 = 0
    // ======================================================
    dataIn=0; enter1=1; #FP; enter1=0; #FP;
    dataIn=1; enter1=1; #FP; enter1=0; #FP;
    dataIn=2; enter1=1; #FP; enter1=0; #FP;
    dataIn=3; enter1=1; #FP; enter1=0; #FP;

    dataIn=4; enter2=1; #FP; enter2=0; #FP;
    dataIn=5; enter2=1; #FP; enter2=0; #FP;
    dataIn=6; enter2=1; #FP; enter2=0; #FP;
    dataIn=7; enter2=1; #FP; enter2=0; #FP;

    #(FP*3);
    $display("CASE 4 -> Score1 = %d | Score2 = %d", score1, score2);

    // ================= RESET =================
    rst = 0; #20; rst = 1;
    #FP;
// ======================================================
// CASE 5
// P1: 0 1 2 3
// P2: 0 0 2 5
// Expected -> Score1 = 3 , Score2 = 5
// ======================================================
    dataIn=0; enter1=1; #FP; enter1=0; #FP;
    dataIn=1; enter1=1; #FP; enter1=0; #FP;
    dataIn=2; enter1=1; #FP; enter1=0; #FP;
    dataIn=3; enter1=1; #FP; enter1=0; #FP;

    dataIn=0; enter2=1; #FP; enter2=0; #FP;
    dataIn=0; enter2=1; #FP; enter2=0; #FP;
    dataIn=2; enter2=1; #FP; enter2=0; #FP;
    dataIn=5; enter2=1; #FP; enter2=0; #FP;

    #(FP*3);
    $display("CASE 5 -> Score1 = %d | Score2 = %d", score1, score2);

// ================= RESET =================
    rst = 0; #20; rst = 1;
    #FP;
// ======================================================
// CASE 6
// P1: 0 1 2 3
// P2: 0 0 0 4
// Expected -> Score1 = 4 , Score2 = 4
// ======================================================
    dataIn=0; enter1=1; #FP; enter1=0; #FP;
    dataIn=1; enter1=1; #FP; enter1=0; #FP;
    dataIn=2; enter1=1; #FP; enter1=0; #FP;
    dataIn=3; enter1=1; #FP; enter1=0; #FP;

    dataIn=0; enter2=1; #FP; enter2=0; #FP;
    dataIn=0; enter2=1; #FP; enter2=0; #FP;
    dataIn=0; enter2=1; #FP; enter2=0; #FP;
    dataIn=4; enter2=1; #FP; enter2=0; #FP;
    #(FP*3);
    $display("CASE 6 -> Score1 = %d | Score2 = %d", score1, score2);

// ================= RESET =================
    rst = 0; #20; rst = 1;
    #FP;
// ======================================================
// CASE 7
// P1: 0 0 1 1
// P2: 0 1 2 3
// Expected -> Score1 = 5 , Score2 = 3
// ======================================================
    dataIn=0; enter1=1; #FP; enter1=0; #FP;
    dataIn=0; enter1=1; #FP; enter1=0; #FP;
    dataIn=1; enter1=1; #FP; enter1=0; #FP;
    dataIn=1; enter1=1; #FP; enter1=0; #FP;

    dataIn=0; enter2=1; #FP; enter2=0; #FP;
    dataIn=1; enter2=1; #FP; enter2=0; #FP;
    dataIn=2; enter2=1; #FP; enter2=0; #FP;
    dataIn=3; enter2=1; #FP; enter2=0; #FP;

    #(FP*3);
    $display("CASE 7 -> Score1 = %d | Score2 = %d", score1, score2);

// ================= RESET =================
    rst = 0; #20; rst = 1;
    #FP;
// ======================================================
// CASE 8
// P1: 0 0 1 1
// P2: 0 1 0 1
// Expected -> Score1 = 2 , Score2 = 6
// ======================================================
    dataIn=0; enter1=1; #FP; enter1=0; #FP;
    dataIn=0; enter1=1; #FP; enter1=0; #FP;
    dataIn=1; enter1=1; #FP; enter1=0; #FP;
    dataIn=1; enter1=1; #FP; enter1=0; #FP;

    dataIn=0; enter2=1; #FP; enter2=0; #FP;
    dataIn=1; enter2=1; #FP; enter2=0; #FP;
    dataIn=0; enter2=1; #FP; enter2=0; #FP;
    dataIn=1; enter2=1; #FP; enter2=0; #FP;

    #(FP*3);
    $display("CASE 8 -> Score1 = %d | Score2 = %d", score1, score2);
    
// ================= RESET =================
    rst = 0; #20; rst = 1;
    #FP;
// ======================================================
// CASE 9
// P1: 0 1 2 3
// P2: 1 0 0 1
// Expected -> Score1 = 4 , Score2 = 4
// ======================================================
    dataIn=0; enter1=1; #FP; enter1=0; #FP;
    dataIn=1; enter1=1; #FP; enter1=0; #FP;
    dataIn=2; enter1=1; #FP; enter1=0; #FP;
    dataIn=3; enter1=1; #FP; enter1=0; #FP;

    dataIn=1; enter2=1; #FP; enter2=0; #FP;
    dataIn=0; enter2=1; #FP; enter2=0; #FP;
    dataIn=0; enter2=1; #FP; enter2=0; #FP;
    dataIn=1; enter2=1; #FP; enter2=0; #FP;

    #(FP*3);
    $display("CASE 9 -> Score1 = %d | Score2 = %d", score1, score2);
    

    // ================= FINISH =================
    $display("Simulation finished.");
    $finish(); 
end


endmodule