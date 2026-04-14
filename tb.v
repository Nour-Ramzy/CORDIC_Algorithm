module tb (
    
);
parameter WIDTH = 16;
reg clk;
reg [WIDTH-1:0] x_start,y_start;
reg [31:0] angle;
wire [WIDTH-1:0] sin,cos;
//
localparam An = 19436;    //


//
CORDIC  DUT(.*);
//
initial begin
    clk = 1'b0;
    forever   #1 clk = ~clk;
end
//
initial begin
   x_start = An; y_start = 0;
   // 45
   angle =  'b00100000000000000000000000000000;
   repeat(18) begin
     @(negedge clk);
   end
   // 60
   angle =  'b00101010101010101010101010101010;
   repeat(18) begin
     @(negedge clk);
   end
   // 90
   angle =  'b01000000000000000000000000000000;
   repeat(18) begin
     @(negedge clk);
   end
   // 75
   angle =  'b00110101010101010101010101010101;
   repeat(18) begin
     @(negedge clk);
   end
   // 0
   angle =  32'b0;
   repeat(18) begin
     @(negedge clk);
   end

    $stop;
    
end

endmodule //tb