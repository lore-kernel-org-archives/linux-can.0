From: Philipp Lehmann <leph1016@hs-karlsruhe.de>
Subject: [Bug] Kernel Panic on Deletion of the network-namespace containing
 the SocketCAN interface
Date: Thu, 16 Jul 2020 16:46:30 +0000
Message-ID: <20ea6d4c00dc4d5f99cd004677280369@hs-karlsruhe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp.HS-Karlsruhe.DE ([193.196.64.25]:47721 "EHLO
        smtp.hs-karlsruhe.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgGPQqe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 16 Jul 2020 12:46:34 -0400
Content-Language: de-DE
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "wg@grandegger.com" <wg@grandegger.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "socketcan@hartkopp.net" <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "christian.sauer.w@sew-eurodrive.de" <christian.sauer.w@sew-eurodrive.de>

If a SocketCAN Interface (Tested with a PCAN-USB adapter) is moved into a network-namespace and the network namespace is deleted afterwards, without moving the device out of the namespace prior to the deletion. The device could not be found in any of the network namespaces afterwards, only a reboot of the system fixes this. If the device is instead removed from the USB-Bus without a restart, a kernel panic is the result.


Output of uname -r [Linux cpc4x 5.4.0-40-generic #44-Ubuntu SMP Tue Jun 23 00:01:04 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux]


The bug could be reproduced with the following steps:


1. Connect the (USB)-SocketCAN device to the host

2. Add a new network namespace [sudo ip netns add test]
3. Move the CAN-interface to the network name-space [sudo ip link set dev can0 netns test]
4. Delete the namespace [sudo ip netns delete test]
5. Remove the adapter from the USB-Bus. In most cases this should result in a kernel panic
