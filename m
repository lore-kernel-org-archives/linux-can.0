From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [CANFD] Upgraded can-utils tools to support CAN FD for Linux 3.6
Date: Tue, 21 Aug 2012 17:41:24 +0200
Message-ID: <5033AC24.1010005@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:34165 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755650Ab2HUPlZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 21 Aug 2012 11:41:25 -0400
Received: from [192.168.178.40] (p5B0B0B8E.dip0.t-ipconnect.de [91.11.11.142])
	by smtp.strato.de (josoe mo88) (RZmta 30.9 DYNA|AUTH)
	with ESMTPA id X03417o7LDW01G for <linux-can@vger.kernel.org>;
	Tue, 21 Aug 2012 17:41:24 +0200 (CEST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi all,

as the includes and the userspace API for CAN FD (raw sockets) are now
finalized in Linux 3.6-rc2 i started to work on the can-utils.

The changed tools have been pushed to a separate 'canfd' branch:

https://gitorious.org/linux-can/can-utils/commits/canfd

Feel free to test it with the latest 3.6-rc2 kernel and don't forget to set
the MTU of the vcan interface to 72 ( CANFD_MTU sizeof(struct canfd_frame) )

# ifconfig vcan0 down
# ifconfig vcan0 mtu 72 up

Especially cangen has now a '-m' (mix) option which randomly generates CAN2.0,
RTR frames and CAN FD frames - so one can see every type of CAN frames to play
with output representations, logfiles, etc.

'candump' has a new '-x' option to display extra frame information, e.g. RX/TX
information (if frames are received by the host or sent) and BRS/ESI for CAN FD.

Have fun!

Oliver


---

    canfd: upgrade tools to support CAN FD for Linux 3.6
    
    This is a major upgrade of the basic tools to handle CAN FD frames.
    The library to parse and print CAN frames and logfiles has been extended.
    
    In detail:
    
     asc2log.c      |    5 +
     candump.c      |   46 ++++++++++---
     cangen.c       |  172 ++++++++++++++++++++++++++++++++------------------
     canlogserver.c |   28 +++++---
     canplayer.c    |   25 ++++---
     cansend.c      |   55 ++++++++++++---
     lib.c          |  196 ++++++++++++++++++++++++++++++++++++++-------------------
     lib.h          |  113 ++++++++++++++++++++++++--------
     log2asc.c      |    8 +-
     log2long.c     |   26 ++++++-
     10 files changed, 471 insertions(+), 203 deletions(-)
    
    asc2log.c / log2asc.c
    - updates for new lib functions
    - still can only handle CAN2.0 frames (no new info about ASC file layout)
    
    log2long.c / canlogserver.c / canplayer.c
    - updates for new lib functions to handle CAN FD
    
    lib.h / lib.c
    - reworked lib functions to handle CAN FD
    - parse_canframe() now returns CAN_MTU and CANFD_MTU on success, 0 at failure
    - added can_dlc2len() and can_len2dlc() helpers
    - moved hexstring2candata to hexstring2data to support simple byte buffers
    - added new view CANLIB_VIEW_INDENT_SFF to fix sloppy out when mixing EFF & SFF
    - in the long CAN frame representation use %03X/%08X instead of %3X/%8X
    - introduced unified buffer size definitions for ASCII CAN frames
    - updated documentation
    
    cangen.c
    - support CAN FD frames (added -f option to create CAN FD frames)
    - added -m option ('mix') to create random extended / RTR / CAN FD frames
    - fixed the 'fixed data' option which was zero'ing the payload by the time
    - updated help text

    candump.c
    - support CAN FD frames (print, bridge, log)
    - updated layout with CANLIB_VIEW_INDENT_SFF when detecting an EFF frame
    - distinguish frame types by length info: [0] = CAN2.0 [00] = CAN FD frame
    - added -x option to print extra message infos: RX/TX BRS ESI
 
EOF
