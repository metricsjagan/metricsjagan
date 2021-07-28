//This is AHB interface file 
//project : AHB VIP 
interface ahb_if (input hclk,Input hreset_n)
  logic [31:0] haddr;
  logic        hmastlock;
  logic [2:0]  hsize;
  logic [1:0]  htrans;
  logic [31:0] hwdata;
  logic        hwrite;
  logic [31:0] hrata;
  logic        hready;
  logic        hresp;
endinterface 
  
