module gamemachine (
    input clk,
    input rst,
    input enter1,
    input enter2,
    input [2:0] dataIn,
    output reg [3:0] score1,
    output reg [3:0] score2
);
    reg [3:0] state, next_state;

    // State Kodlaması
    parameter IDLE = 4'd0,
              P1_0 = 4'd1,
              P1_1 = 4'd2,
              P1_2 = 4'd3,
              P1_3 = 4'd4,
              P2_0 = 4'd5,
              P2_1 = 4'd6,
              P2_2 = 4'd7,
              P2_3 = 4'd8,
              CALC = 4'd9,
              DONE = 4'd10;

    reg [2:0] p1 [0:3];
    reg [2:0] p2 [0:3];

    
    reg p2_is_match [0:3]; 

    reg [3:0] tmp_score1;
    reg [3:0] tmp_score2;
    reg found;
    integer i, j;

    // STATE REGISTER
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // NEXT STATE LOGIC
    always @(*) begin
        next_state = state;
        case (state)
            IDLE: next_state = P1_0;

            P1_0: if (enter1) next_state = P1_1;
            P1_1: if (enter1) next_state = P1_2;
            P1_2: if (enter1) next_state = P1_3;
            P1_3: if (enter1) next_state = P2_0;

            P2_0: if (enter2) next_state = P2_1;
            P2_1: if (enter2) next_state = P2_2;
            P2_2: if (enter2) next_state = P2_3;
            P2_3: if (enter2) next_state = CALC;

            CALC: next_state = DONE;
            DONE: next_state = DONE;

            default: next_state = IDLE;
        endcase
    end

    // INPUT SAMPLING
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            for (i=0; i<4; i=i+1) begin
                p1[i] <= 3'd0;
                p2[i] <= 3'd0;
            end
        end else begin
            case (state)
                P1_0: if (enter1) p1[0] <= dataIn;
                P1_1: if (enter1) p1[1] <= dataIn;
                P1_2: if (enter1) p1[2] <= dataIn;
                P1_3: if (enter1) p1[3] <= dataIn;
                P2_0: if (enter2) p2[0] <= dataIn;
                P2_1: if (enter2) p2[1] <= dataIn;
                P2_2: if (enter2) p2[2] <= dataIn;
                P2_3: if (enter2) p2[3] <= dataIn;
            endcase
        end
    end

    // SCORE CALCULATION (Combinational Logic)
    always @(*) begin
        tmp_score1 = 4'd0;
        tmp_score2 = 4'd0;

        // Reset match flags
        for (i = 0; i < 4; i = i + 1) begin
            p2_is_match[i] = 1'b0;
        end

        //Exact Match
        for (i = 0; i < 4; i = i + 1) begin
            if (p1[i] == p2[i]) begin
                tmp_score2 = tmp_score2 + 2;
                p2_is_match[i] = 1'b1; 
            end
        end

        //Coincidence or No Match Control
        for (i = 0; i < 4; i = i + 1) begin
            // If it is not already exact match:
            if (p2_is_match[i] == 1'b0) begin
                found = 1'b0;
                
                // Scan player 1 list
                
                // might be a reference for coincidence
                for (j = 0; j < 4; j = j + 1) begin
                    if (!found && (p2[i] == p1[j])) begin
                        // Coincidence
                        tmp_score1 = tmp_score1 + 1;
                        tmp_score2 = tmp_score2 + 1;
                        found = 1'b1; // flag for exiting the inner loop
                    end
                end

                // No Match
                if (found == 1'b0) begin
                    tmp_score1 = tmp_score1 + 2;
                end
            end
        end
    end

    // OUTPUT REGISTER - Sequential Update
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            score1 <= 4'd0;
            score2 <= 4'd0;
        end else if (state == CALC) begin
            score1 <= tmp_score1;
            score2 <= tmp_score2;
        end
    end

endmodule