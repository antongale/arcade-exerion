library ieee;
use ieee.std_logic_1164.all;

library altera_mf;
use altera_mf.all;

entity dpram_dc is
    generic (
        init_file     : string := " ";
        widthad_a     : natural;
        width_a       : natural := 8;
        outdata_reg_a : string  := "UNREGISTERED";
        outdata_reg_b : string  := "UNREGISTERED"
    );
    port (
        address_a : in std_logic_vector (widthad_a - 1 downto 0);
        address_b : in std_logic_vector (widthad_a - 1 downto 0) := (others => '0');
        clock_a   : in std_logic;
        clock_b   : in std_logic;
        data_a    : in std_logic_vector (width_a - 1 downto 0)   := (others => '0');
        data_b    : in std_logic_vector (width_a - 1 downto 0)   := (others => '0');
        wren_a    : in std_logic                                 := '0';
        wren_b    : in std_logic                                 := '0';
        byteena_a : in std_logic_vector (width_a/8 - 1 downto 0) := (others => '1');
        byteena_b : in std_logic_vector (width_a/8 - 1 downto 0) := (others => '1');
        q_a       : out std_logic_vector (width_a - 1 downto 0);
        q_b       : out std_logic_vector (width_a - 1 downto 0)
    );
end dpram_dc;
architecture SYN of dpram_dc is

    signal sub_wire0 : std_logic_vector (width_a - 1 downto 0);
    signal sub_wire1 : std_logic_vector (width_a - 1 downto 0);

    component altsyncram
        generic (
            address_reg_b                 : string;
            clock_enable_input_a          : string;
            clock_enable_input_b          : string;
            clock_enable_output_a         : string;
            clock_enable_output_b         : string;
            indata_reg_b                  : string;
            init_file                     : string;
            intended_device_family        : string;
            lpm_type                      : string;
            numwords_a                    : natural;
            numwords_b                    : natural;
            operation_mode                : string;
            outdata_aclr_a                : string;
            outdata_aclr_b                : string;
            outdata_reg_a                 : string;
            outdata_reg_b                 : string;
            power_up_uninitialized        : string;
            read_during_write_mode_port_a : string;
            read_during_write_mode_port_b : string;
            widthad_a                     : natural;
            widthad_b                     : natural;
            width_a                       : natural;
            width_b                       : natural;
            width_byteena_a               : natural;
            width_byteena_b               : natural;
            wrcontrol_wraddress_reg_b     : string
        );
        port (
            wren_a    : in std_logic;
            clock0    : in std_logic;
            wren_b    : in std_logic;
            clock1    : in std_logic;
            address_a : in std_logic_vector (widthad_a - 1 downto 0);
            address_b : in std_logic_vector (widthad_a - 1 downto 0);
            q_a       : out std_logic_vector (width_a - 1 downto 0);
            q_b       : out std_logic_vector (width_a - 1 downto 0);
            byteena_a : in std_logic_vector (width_a/8 - 1 downto 0);
            byteena_b : in std_logic_vector (width_a/8 - 1 downto 0);
            data_a    : in std_logic_vector (width_a - 1 downto 0);
            data_b    : in std_logic_vector (width_a - 1 downto 0)
        );
    end component;

begin
    q_a <= sub_wire0(width_a - 1 downto 0);
    q_b <= sub_wire1(width_a - 1 downto 0);

    altsyncram_component : altsyncram
    generic map(
        address_reg_b                 => "CLOCK1",
        clock_enable_input_a          => "BYPASS",
        clock_enable_input_b          => "BYPASS",
        clock_enable_output_a         => "BYPASS",
        clock_enable_output_b         => "BYPASS",
        indata_reg_b                  => "CLOCK1",
        init_file                     => init_file,
        intended_device_family        => "Cyclone III",
        lpm_type                      => "altsyncram",
        numwords_a                    => 2 ** widthad_a,
        numwords_b                    => 2 ** widthad_a,
        operation_mode                => "BIDIR_DUAL_PORT",
        outdata_aclr_a                => "NONE",
        outdata_aclr_b                => "NONE",
        outdata_reg_a                 => outdata_reg_a,
        outdata_reg_b                 => outdata_reg_a,
        power_up_uninitialized        => "FALSE",
        read_during_write_mode_port_a => "NEW_DATA_NO_NBE_READ",
        read_during_write_mode_port_b => "NEW_DATA_NO_NBE_READ",
        widthad_a                     => widthad_a,
        widthad_b                     => widthad_a,
        width_a                       => width_a,
        width_b                       => width_a,
        width_byteena_a               => width_a/8,
        width_byteena_b               => width_a/8,
        wrcontrol_wraddress_reg_b     => "CLOCK1"
    )
    port map(
        wren_a    => wren_a,
        clock0    => clock_a,
        wren_b    => wren_b,
        clock1    => clock_b,
        address_a => address_a,
        address_b => address_b,
        data_a    => data_a,
        data_b    => data_b,
        q_a       => sub_wire0,
        q_b       => sub_wire1,
        byteena_a => byteena_a,
        byteena_b => byteena_b
    );

end SYN;
