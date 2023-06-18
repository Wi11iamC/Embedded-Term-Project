-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;

entity cache_controller is
	port (
		clk : in std_logic;  		--Clock
		clk_en : in std_logic; 		--Clock enable
		rst : in std_logic;			--Reset. Will clear the entire cache.

		-- The address whose contents the processor wants to fetch
		target_address : in std_logic_vector(13 downto 0);
		
		-- The data the processor wants, at the target_address.
		-- This gets hooked up to an input of the processor.
		data_out : out std_logic_vector(15 downto 0);
		
		-- The address whose contents the processor wants to fetch,
		-- if the cache doesn't contain this. This gets hooked up to the
		-- address port of the BRAM (or whatever your memory entity is).
		main_memory_address: out std_logic_vector(13 downto 0);
		
		-- This will be '1' if we are currently busy reading from main memory
		busy_reading : out std_logic;
		
		-- This will be a '1' if the data requested by the processor 
		-- (present on data_out) is ready for reception.
		data_ready : out std_logic
	);
end cache_controller;

-- architecture
architecture bcache_controller of cache_controller is

	-- Define size of cache
	constant cache_size : integer := 32;
	
	-- Define the size of the index fields and tag fields
	constant index_bits : integer := 5;
	constant tag_bits : integer := 9;

    -- Define the size of the data and address fields
    constant data_bits : integer := 16;
	constant address_bits : integer := 14;
	
	-- Define signals for the cache tags, data, and valid bits
	type cache_entry is record
		tag : std_logic_vector(tag_bits-1 downto 0);
		data : std_logic_vector(data_bits-1 downto 0);
		valid : std_logic;
	end record;
	
	type cache_array is array (0 to cache_size-1) of cache_entry;
	signal cache : cache_array;
	
	-- Define signals for current request and response
	signal current_address : std_logic_vector(address_bits-1 downto 0);
	signal current_data : std_logic_vector(data_bits-1 downto 0);
	signal current_valid : std_logic;
	signal current_tag : std_logic_vector(tag_bits-1 downto 0);
	signal current_index : std_logic_vector(index_bits-1 downto 0);
	
	-- Define signals for main memory interface
	signal main_memory_read_address : std_logic_vector(address_bits-1 downto 0);
	signal main_memory_read_data : std_logic_vector(data_bits-1 downto 0);
	signal main_memory_read_valid : std_logic;
	
begin

	-- Reset cache on rising edge of reset signal
	process (clk, rst)
	begin
		if rst = '1' then
			for i in 0 to cache_size-1 loop
				cache(i).valid <= '0';
			end loop;
		end if;
	end process;
	
	-- Extract the tag and index from the target address
	process (target_address)
	begin
		current_tag <= target_address(address_bits-1 downto index_bits);
		current_index <= target_address(index_bits-1 downto 0);
	end process;
	
	-- Check if the current request is a hit or miss
	process (current_index, current_tag)
	begin
		if cache(to_integer(unsigned(current_index))).tag = current_tag and cache(to_integer(unsigned(current_index))).valid = '1' then
			-- Hit
			current_data <= cache(to_integer(unsigned(current_index))).data;
			current_valid <= '1';
		else
			-- Miss
			current_valid <= '0';
			main_memory_read_address <= target_address;
			main_memory_read_valid <= '1';
		end if;
	end process;
	
	-- Read data from main memory with one cycle of latency
	process (clk)
	begin
		if rising_edge(clk) then
			if main_memory_read_valid = '1' then
				current_data <= main_memory_read_data;
				current_valid <= '1';
				cache(to_integer(unsigned(current_index))).tag <= current_tag;
				cache(to_integer(unsigned(current_index))).data <= current_data;
				cache(to_integer(unsigned(current_index))).valid <= '1';
				main_memory_read_valid <= '0';
			end if;
		end if;
	end process;
	
	-- Output control and response signals
	data_out <= current_data;
	busy_reading <= main_memory_read_valid;
	data_ready <= current_valid;
	main_memory_address <= main_memory_read_address;
	
end bcache_controller;
