`default_nettype none
module MAC #
(
parameter DATA_WIDTH = 8
)
(
input wire clk,
input wire rst_n,
input wire En,
input wire Clr,
input wire [DATA_WIDTH-1:0] Ain,
input wire [DATA_WIDTH-1:0] Bin,
output reg [DATA_WIDTH*3-1:0] Cout
);

logic [DATA_WIDTH*2-1:0] MCout;
logic [DATA_WIDTH*2-1:0] dout;

LPMMULT (
	.dataa(Ain),
	.datab(Bin),
	.result(MCout)
);

ADDER (
	.dataa(MCout),
	.datab(Cout),
	.result(dout)
);

always_ff @(posedge clk, negedge rst_n) begin
	if (!rst_n)
		Cout <= '0;
	else if (Clr)
		Cout <= '0;
	else if (En)
		Cout <= dout;
	else
		Cout <= Cout;
end


endmodule
