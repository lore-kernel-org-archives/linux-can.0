From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 0/3] RFC/RFT: CAN FD support for can-gw
Date: Thu, 10 Jan 2019 22:02:52 +0100
Message-ID: <20190110210255.4291-1-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: linux-can@vger.kernel.org
Cc: ieatmuttonchuan@gmail.com, meissner@suse.de, mkubecek@suse.cz, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

As a follow-up to the discussion about CVE-2019-3701 I walked through the
can-gw code to add the support for handling CAN FD frames.

Patch 1/3 is still the CVE fix and can be omitted when a recent Linux tree
is used that is already patched.

Patch 2/3 and 3/3 introduce the CAN FD support.

The updated user space tool 'cangw' can be found in the 'cangwfd' branch of
my can-utils fork at https://github.com/hartkopp/can-utils .

Feedback and testing is welcome!

Oliver Hartkopp (3):
  can: gw: ensure DLC boundaries after CAN frame modification
  can: gw: use struct canfd_frame as internal data structure
  can: gw: add support for CAN FD frames

 include/uapi/linux/can/gw.h |  17 +-
 net/can/gw.c                | 424 +++++++++++++++++++++++++++---------
 2 files changed, 333 insertions(+), 108 deletions(-)

-- 
2.20.1
