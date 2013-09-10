require 'cinch'
require 'rubygems'
require 'arduino_firmata'

# Many different pins. Yay!
pin1 = 4 # Messages
pin2 = 3 # Private messages
pin3 = 2 # Status indicator

# Username to monitor!
username = "monographic"

# Initializing Arduino
arduino = ArduinoFirmata.connect
puts "[DEBUG] Connection to Arduino established!"
puts "[DEBUG] Firmata version #{arduino.version}"

# Step 1
arduino.digital_write pin1, true
puts "[DEBUG] [1/1] Arduino started successfully!"

# Initializing Cinch bot
bot = Cinch::Bot.new do
	
	# Initializing Configuration
	configure do |c|
		c.server = "irc.freenode.org"
		c.channels = ["#hasi"]
		c.nick = "monobot"
		c.realname = "monographenbot"
		
		# Step 2
		arduino.digital_write pin2, true
		puts "[DEBUG] [2/3] Configuration finished successfully!"
	end	
	
	on :connect do
		# Step 3
		arduino.digital_write pin3, true
		puts "[DEBUG] [3/3] Connection established!"
	end
	
	#
	arduino.digital_write pin1, false
	arduino.digital_write pin2, false
	arduino.digital_write pin3, false
	
	# New messages
	on :message do |m|
		arduino.digital_write pin1, true
		sleep 1	
		arduino.digital_write pin1, false
	end
	
	# New private messages
	on :message, "#{username}" do
		arduino.digital_write pin2, true
		sleep 1
		arduino.digital_write pin2, false
	end

end

bot.start
	
