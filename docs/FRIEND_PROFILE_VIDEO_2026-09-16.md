# Friend profile previews, photos and video creation

- Friend details are displayed below the main profile's Friend Info entry and
  refreshed after editing: phone, tags, notes, photo count and thumbnails.
- Saved photos support zoom preview. The Photos row opens a dedicated management
  page that supports gallery multi-selection, deletion and preview. A failed
  import or metadata save does not publish partial additions; new orphan files
  are cleaned up. Annotations/photos remain private device-local data isolated
  by server, account and friend; this is not a cross-device photo backup.
- Discover Video Channels opens the video feed, with Publish Video and Go Live.
  Video-only composition requires a video and uses the existing Moment upload,
  visibility and friend-permission pipeline. Go Live calls a host callback,
  keeping the chat package independent of the host's LiveKit implementation.
- Generic channel discovery filters internal live-directory marker rooms.
- 33 focused tests passed, including edit-return refresh, multi-selection,
  partial-import cleanup, persisted preview, creator navigation and disabling
  text-only submissions in video composition. Native selection, actual video
  publication and live broadcasting are still acceptance gaps (QA-009).
