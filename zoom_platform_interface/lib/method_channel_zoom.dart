import 'package:flutter/services.dart';
import 'package:zoom_platform_interface/zoom_options.dart';
import 'package:zoom_platform_interface/zoom_platform_interface.dart';

class MethodChannelZoom extends ZoomPlatform {
  final MethodChannel channel = MethodChannel('plugins.webcare/zoom_channel');

  /// The event channel used to interact with the native platform.
  final EventChannel eventChannel =
      EventChannel('plugins.webcare/zoom_event_stream');
  @override
  Future<List> initZoom(ZoomOptions options) async {
    assert(options != null);

    var optionMap = new Map<String, String>();
    // optionMap.putIfAbsent("appKey", () => options.appKey);
    // optionMap.putIfAbsent("appSecret", () => options.appSecret);
    optionMap.putIfAbsent("jwtToken", () => options.jwtToken);
    optionMap.putIfAbsent("domain", () => options.domain);

    return channel.invokeMethod('init', optionMap);
  }

  @override
  Future<bool> startMeeting(ZoomMeetingOptions options) async {
    assert(options != null);
    var optionMap = new Map<String, String>();
    optionMap.putIfAbsent("userId", () => options.userId);
    optionMap.putIfAbsent("displayName", () => options.displayName);
    optionMap.putIfAbsent("meetingId", () => options.meetingId);
    optionMap.putIfAbsent("meetingPassword", () => options.meetingPassword);
    optionMap.putIfAbsent("zoomToken", () => options.zoomToken);
    optionMap.putIfAbsent("zoomAccessToken", () => options.zoomAccessToken);
    optionMap.putIfAbsent("disableDialIn", () => options.disableDialIn);
    optionMap.putIfAbsent("disableDrive", () => options.disableDrive);
    optionMap.putIfAbsent("disableInvite", () => options.disableInvite);
    optionMap.putIfAbsent("disableShare", () => options.disableShare);
    optionMap.putIfAbsent("noDisconnectAudio", () => options.noDisconnectAudio);
    optionMap.putIfAbsent("noAudio", () => options.noAudio);

    return channel.invokeMethod('start', optionMap);
  }

  @override
  Future<bool> joinMeeting(ZoomMeetingOptions options) async {
    assert(options != null);
    var optionMap = new Map<String, String>();
    optionMap.putIfAbsent("userId", () => options.userId);
    optionMap.putIfAbsent("meetingId", () => options.meetingId);
    optionMap.putIfAbsent("meetingPassword", () => options.meetingPassword);
    optionMap.putIfAbsent("disableDialIn", () => options.disableDialIn);
    optionMap.putIfAbsent("disableDrive", () => options.disableDrive);
    optionMap.putIfAbsent("disableInvite", () => options.disableInvite);
    optionMap.putIfAbsent("disableShare", () => options.disableShare);
    optionMap.putIfAbsent("noDisconnectAudio", () => options.noDisconnectAudio);
    optionMap.putIfAbsent("noAudio", () => options.noAudio);

    return channel.invokeMethod('join', optionMap);
  }

  @override
  Future<List> meetingStatus(String meetingId) async {
    assert(meetingId != null);

    var optionMap = new Map<String, String>();
    optionMap.putIfAbsent("meetingId", () => meetingId);

    return channel.invokeMethod('meeting_status', optionMap);
  }

  @override
  Stream<dynamic> onMeetingStatus() {
    return eventChannel.receiveBroadcastStream();
  }
}