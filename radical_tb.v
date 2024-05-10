`timescale 10ns/10ps

//Testbench for out square root calculator design.
module sqrt_tb;  //testbench module is always empty. No input or output ports.

reg Clock, reset;
wire done;
parameter N = 16;   //width of the input.
reg [N-1:0] num_in;
reg [N:0] i;
wire [N/2-1:0] sq_root;
integer error,actual_result;  //this indicates the number of errors encountered during simulation.
parameter Clock_period = 10;    //Change clock period here. 
wire eroare;

//Apply the inputs to the design and check if the results are correct. 
//The number of inputs for which the results were wrongly calculated are counted by 'error'. 
initial begin
    Clock = 1;
    error = 0;
    i=1;
    //First we apply reset input for one clock period.
    reset = 0;
    #Clock_period;
    reset = 1;
    //Test the design for all the combination of inputs.
    //Since we have (2^16)-1 inputs, we test all of them one by one. 
    while(i<=2**N-1) begin
        apply_input(i);
        i = i+1;
    end
    #Clock_period;
    reset = 0;   //all inputs are tested. Apply reset
    num_in = 0;     //reset the 'num_in'
    $stop;  //Stop the simulation, as we have finished testing the design.
end

task apply_input;
    input [N:0] i;
begin
    num_in = i[N-1:0];  
    wait(~done);    //wait for the 'done' to finish its previous high state
    wait(done); //wait until 'done' output goes High.
    wait(~Clock);   //we sample the output at the falling edge of the clock.
    actual_result = $rtoi($floor($pow(i,0.5))); //Calculate the actual result.
    //if actual result and calculated result are different increment 'error' by 1.
    if(actual_result != sq_root) 
        error = error + 1; 
end
endtask

//generate a 50Mhz clock for testing the design.
always #(Clock_period/2) Clock <= ~Clock;

//Instantiate the matrix multiplier
square_root #(.N(N)) find_sq_root 
        (.Clock(Clock), 
        .reset(reset), 
        .num_in(num_in), 
        .done(done),
        .sq_root(sq_root),
        .eroare(eroare)
        );

endmodule   //End of testbench.