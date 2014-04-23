From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 0/2] iproute2: can: support CAN FD control interface
Date: Wed, 23 Apr 2014 19:27:25 +0200
Message-ID: <1398274047-5407-1-git-send-email-socketcan@hartkopp.net>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: stephen@networkplumber.org
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>
List-Id: linux-can.vger.kernel.org

For CAN FD a new set of bittiming configuration and enabling functions for the
data section is provided by the CAN driver infrastructure.

This patch set allows to configure the newly introduced CAN FD properties.

Tested with PEAK PCAN USB pro FD pilot series hardware.

Oliver Hartkopp (2):
  iproute2: can: fix indention white spaces
  iproute2: can: support CAN FD control interface

 ip/iplink_can.c | 144 +++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 107 insertions(+), 37 deletions(-)

-- 
1.9.2
