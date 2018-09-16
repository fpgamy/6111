library verilog;
use verilog.vl_types.all;
entity rs232send is
    generic(
        DIVISOR         : integer := 234;
        STATE_IDLE      : integer := 0;
        STATE_SENDING   : integer := 1;
        START_BIT       : integer := 0;
        STOP_BIT        : integer := 1;
        BITS_PER_PACKET : integer := 10
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        data            : in     vl_logic_vector(7 downto 0);
        start_send      : in     vl_logic;
        xmit_data       : out    vl_logic;
        xmit_clk        : out    vl_logic;
        led_debug       : out    vl_logic
    );
end rs232send;
