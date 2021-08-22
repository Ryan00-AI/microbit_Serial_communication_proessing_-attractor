serial.set_baud_rate(BaudRate.BAUD_RATE115200)

def on_forever():
    serial.write_numbers([input.light_level(),
            input.temperature(),
            input.sound_level(),
            input.acceleration(Dimension.STRENGTH)])
basic.forever(on_forever)