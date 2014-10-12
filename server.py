import random
import signal
import socket
import struct
import sys
import time

PORT = 1234
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
s.bind(('', PORT))
s.listen(1)
print("Server started on port %u" % PORT)

def signal_handler(signal, frame):
	s.close()
	print("\nServer stopped.")
	sys.exit(0)
signal.signal(signal.SIGINT, signal_handler)

try:
	while True:
		(conn, addr) = s.accept()
		conn.setblocking(0)
		r = 127
		g = 127
		b = 127
		print("Client connected: %s:%d" % addr)
		while True:
			if random.randint(0, 100) < 95:
				dr = random.randint(-10, 10)
				dg = random.randint(-10, 10)
				db = random.randint(-10, 10)
				r = (r + dr) % 255
				g = (g + dg) % 255
				b = (b + db) % 255
				command = struct.pack("!Bhhh", 0x1, dr, dg, db)
			else:
				r = random.randint(0, 255)
				g = random.randint(0, 255)
				b = random.randint(0, 255)
				command = struct.pack("!BBBB", 0x2, r, g, b)
			print "r: %i, g: %i, b: %i" % (r, g, b)
			conn.send(command)
			time.sleep(1)
		print("Client disconnected.")
except:
	s.close()