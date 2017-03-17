From: Mario Huettel <mario.huettel@de.bosch.com>
Subject: [PATCH v2 0/3] can: m_can: Add driver support for M_CAN versions > v3.0.x
Date: Fri, 17 Mar 2017 13:52:51 +0100
Message-ID: <1489755174-17546-1-git-send-email-mario.huettel@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:39069 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbdCQMxl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 17 Mar 2017 08:53:41 -0400
Received: from vsmta13.fe.internet.bosch.com (unknown [10.4.98.53])
        by imta23.fe.bosch.de (Postfix) with ESMTP id 4E2241580214
        for <linux-can@vger.kernel.org>; Fri, 17 Mar 2017 13:52:59 +0100 (CET)
Received: from FE-HUB1000.de.bosch.com (vsgw24.fe.internet.bosch.com [10.4.98.24])
        by vsmta13.fe.internet.bosch.com (Postfix) with ESMTP id DE1CD2E40E4F
        for <linux-can@vger.kernel.org>; Fri, 17 Mar 2017 13:52:58 +0100 (CET)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

This patch adds support for all newer versions of the Bosch M_CAN IP Module.

The defines for registers, bits and masks are adapted to be compatible with the
newer versions. They are named accordingl to the most recent user's manual for 
M_CAN version v3.2.1.

All initialization routines check the core release version and set the registers
accordingly. 

The newly added support for versions >= v3.1.x includes a major functionality
change: Instead of only one TX Buffer the whole TX FIFO is used. This is now
possible, because the configuration whether a frame is a CAN-FD Frame and the 
BRS configuration are now done in the Buffer/FIFO Element of the message and not
globally via a config register as before. this implies that the functionality
change does not work for the M_CAN versions v3.0.x.

The driver reserves as many echo_skb slots as there are slots in the TX FIFO of
the M_CAN. Sending a frame is done by getting the index from the M_CAN that
determines in which slot the message shall be written. The echo_skb is written
to the same index in the Linux-internal list. On top of that, the message marker
of the message is set to the index.

Once the message is sent, the message marker (=index) is written into the TX
Event FIFO. The interrupt service routine reads this marker and uses it to echo
the correct echo skb back to the network stack.

Tested on Altera Cyclone V SoC FPGA using M_CAN v3.2.1 (CREL=0x32150320).

Mario Huettel (3):
  can: m_can: Support M_CAN IP versions > v3.0.x
  can: m_can: Enable M_CAN IP version dependent initialization
  can: m_can: Enable TX FIFO Handling for M_CAN IP version >= v3.1.x

 drivers/net/can/m_can/m_can.c | 774 +++++++++++++++++++++++++++++++++---------
 1 file changed, 613 insertions(+), 161 deletions(-)

-- 
1.9.1

