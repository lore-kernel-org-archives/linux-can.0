From: David Jander <david@protonic.nl>
Subject: [RFC PATCH V3 00/15] CAN: Add rx-fifo support and port flexcan to it
Date: Fri, 10 Oct 2014 17:46:45 +0200
Message-ID: <1412956020-21489-1-git-send-email-david@protonic.nl>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:18362 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356AbaJJPrA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 10 Oct 2014 11:47:00 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>, David Jander <david@protonic.nl>

This is the whole patch series again, adding the original rx-fifo framework
from Marc Kleine-Budde as well as the morphing into IRQ-offload mode and a
sample implementation using the flexcan driver.

The new flexcan driver supports full fifo abstraction mode for V10 and newer
peripherals, and simple irq-offloading for older parts.

Changes from V2:
 - Re-issued all patches leading up to this, because some old flexcan work
   needed re-basing.
 - Some cosmetic fixes
 - Added can_rx_fifo_reset() function
 - Added rx-fifo support for can state- and error polling
 - Added support for simple irq-offloading
 - Re-enabled flexcan support for RTR reception on older IPs.

David Jander (11):
  can: flexcan: Re-write receive path to use MB queue instead of FIFO
  can: rx-fifo: Increase MB size limit from 32 to 64
  can: rx-fifo: Change to do controller off-load in interrupt and NAPI
    poll
  can: rx-fifo: fix long lines
  can: rx-fifo: Add can_rx_fifo_reset() function
  can: rx-fifo: remove obsolete comment
  can: rx-fifo: Add support for can state tracking and error polling
  can: flexcan: Add support for RX-FIFO.
  can: rx-fifo: Add support for simple irq offloading
  can: flexcan: Add MB/Fifo specific column to comment table of IP
    versions
  can: flexcan: Re-enable RTR reception support for older flexcan IPs

Marc Kleine-Budde (4):
  can: flexcan: add documentation about mailbox organizaiton
  can: flexcan: rename crl2 -> ctrl2
  can: flexcan: replace open coded mailbox code by proper defines
  can: dev: add preliminary rx-fifo

 drivers/net/can/dev.c     | 324 +++++++++++++++++++++++++++++++++
 drivers/net/can/flexcan.c | 452 ++++++++++++++++++++++++++++++++--------------
 include/linux/can/dev.h   |  46 +++++
 3 files changed, 687 insertions(+), 135 deletions(-)

-- 
1.9.1

