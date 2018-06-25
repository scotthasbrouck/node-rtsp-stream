child_process = require 'child_process'
util = require 'util'
events = require 'events'

Mpeg1Muxer = (options) ->
  self = @
  
  @url = options.url

  @stream = child_process.spawn "ffmpeg", [
    "-rtsp_transport"
    "tcp"
    "-i"
    @url
    '-f'
    'mpegts'
    '-codec:v'
    'mpeg1video'
    '-b:v'
    '800k'
    '-r'
    '25'
    '-'
  ], {detached: false}

  @inputStreamStarted = true
  @stream.stdout.on 'data', (data) ->
    self.emit 'mpeg1data', data

  @stream.stderr.on 'data', (data) ->
    self.emit 'ffmpegError', data

  @

util.inherits Mpeg1Muxer, events.EventEmitter

module.exports = Mpeg1Muxer
