mudule ahb_top(
  input hclk;
  input [31:0] haddr;
  input        hmastlock;
  inout [2:0]  hsize;
  input [1:0]  htrans;
  input [31:0] hwdata;
  input        hwrite;
  output [31:0] hrata;
  output        hready;
  output        hresp;
);
  

always (posedle hclk) begin
end
  
  
  
  
  endmodule 
