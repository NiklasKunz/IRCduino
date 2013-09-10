require 'cinch'
require 'rubygems'
require 'arduino_firmata'

pin_msg = 4
pin_pm = 3
pin_join = 2

arduino = ArduinoFirmata.connect
puts "Firmata v.#{arduino.version}"
arduino.digital_write pin_msg,true
sleep 0.1
arduino.digital_write pin_pm, true
sleep 0.1
arduino.digital_write pin_join, true
sleep 1 
arduino.digital_write pin_msg, false
arduino.digital_write pin_pm, false
arduino.digital_write pin_join, false
puts "Arduino started successfully!"

bot = Cinch::Bot.new do
	configure do |c|
		c.server = "irc.freenode.org"
		c.channels = ["#hasi"]
		c.nick = "monobot"
		c.realname = "monographics_bot"
	end

	on :message do |m|
		arduino.digital_write pin_msg, true
		sleep 0.5	
		arduino.digital_write pin_msg, false
		puts "blink blink!"
	end

end

bot.start
	
