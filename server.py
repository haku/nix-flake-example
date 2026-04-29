#!/usr/bin/env -S python -u

from http.server import BaseHTTPRequestHandler
from http.server import ThreadingHTTPServer
import argparse

parser = argparse.ArgumentParser(allow_abbrev=False)
parser.add_argument('--address', default="127.0.0.1", help='Address to bind to.')
parser.add_argument('--port', type=int, required=True, help='Port to bind to.')
args = parser.parse_args()

class MyServer(BaseHTTPRequestHandler):
  def do_GET(self):
    self.send_response(200)
    self.end_headers()
    self.wfile.write(b"Hello world.")

server = ThreadingHTTPServer((args.address, args.port), MyServer)
print('Listening: http://%s:%s' % server.server_address)
try:
  server.serve_forever()
except KeyboardInterrupt:
  pass
server.server_close()
