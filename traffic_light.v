module trafficlight1(
    input clk , rst ,
    output reg [1:0] north_light , west_light , south_light , east_light 
);

parameter [1:0] GREEN = 2'b00 ;
parameter [1:0] YELLOW = 2'b01 ;
parameter [1:0] RED = 2'b10 ;

parameter [2:0] s0 = 3'b000 ;
parameter [2:0] s1 = 3'b001 ;
parameter [2:0] s2 = 3'b010 ;
parameter [2:0] s3 = 3'b011 ;
parameter [2:0] s4 = 3'b100 ;
parameter [2:0] s5 = 3'b101 ;
parameter [2:0] s6 = 3'b110 ;
parameter [2:0] s7 = 3'b111 ;

reg [2:0] ps , ns ;
reg [25:0] counter ;

//PRESENT STATE LOGIC
always@(posedge clk) begin
    if(rst) begin
        ps <= s0 ;
    end
    else
        ps <= ns ;
end

//COUNTER LOGIC
always @(posedge clk) begin
    if (rst)
        counter <= 0;
    else if (ps != ns)
        counter <= 0;   // reset when state changes
    else
        counter <= counter + 1;
end


//NEXT STATE LOGIC
always@(*) begin
    
       case(ps)

       s0 : begin
             north_light = GREEN ;
             west_light = RED ;
             south_light = RED ;
             east_light = RED ;
            
             if(counter == 26'd50_000_000) begin
                ns = s1 ;
             end 
             else begin
                ns = s0 ;
             end
            end
        
        s1 : begin
             north_light = YELLOW ;
             west_light = RED ;
             south_light = RED ;
             east_light = RED ;
            
             if(counter == 26'd10_000_000) begin
                ns = s2 ;
             end 
             else begin
                ns = s1 ;
             end
            end
        
         s2 : begin
             north_light = RED ;
             west_light = GREEN ;
             south_light = RED ;
             east_light = RED ;
            
             if(counter == 26'd50_000_000) begin
                ns = s3 ;
             end 
             else begin
                ns = s2 ;
             end
            end

         s3 : begin
             north_light = RED;
             west_light = YELLOW ;
             south_light = RED ;
             east_light = RED ;
            
             if(counter == 26'd10_000_000) begin
                ns = s4 ;
             end 
             else begin
                ns = s3 ;
             end
            end
        
           s4 : begin
             north_light = RED;
             west_light = RED ;
             south_light = GREEN ;
             east_light = RED ;
            
             if(counter == 26'd50_000_000) begin
                ns = s5 ;
             end 
             else begin
                ns = s4 ;
             end
            end

           s5 : begin
             north_light = RED;
             west_light = RED ;
             south_light = YELLOW ;
             east_light = RED ;
            
             if(counter == 26'd10_000_000) begin
                ns = s6 ;
             end 
             else begin
                ns = s5 ;
             end
            end

           s6 : begin
             north_light = RED;
             west_light = RED ;
             south_light = RED ;
             east_light = GREEN ;
            
             if(counter == 26'd50_000_000) begin
                ns = s7 ;
             end 
             else begin
                ns = s6 ;
             end
            end

            
           s7 : begin
             north_light = RED;
             west_light = RED ;
             south_light = RED ;
             east_light = YELLOW ;
            
             if(counter == 26'd10_000_000) begin
                ns = s0 ;
             end 
             else begin
                ns = s7 ;
             end
            end
         
            default : ns = s0 ;

       endcase
end

endmodule