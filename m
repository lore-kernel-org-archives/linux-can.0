From: David Jander <david@protonic.nl>
Subject: [PATCH V4 00/14] CAN: Add rx-fifo support and port flexcan to it
Date: Thu,  6 Nov 2014 09:33:59 +0100
Message-ID: <1415262853-22907-1-git-send-email-david@protonic.nl>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:26341 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbaKFIeF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Nov 2014 03:34:05 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Alexander Stein <alexander.stein@systec-electronic.com>, David Jander <david@protonic.nl>

This is the whole patch series again, adding the original rx-fifo framework
from Marc Kleine-Budde as well as the morphing into IRQ-offload mode and a
sample implementation using the flexcan driver.

The new flexcan driver supports full fifo abstraction mode for V10 and newer
peripherals, and simple irq-offloading for older parts.

Changes from V3:
 - Moved rx-fifo patches to beginning of series
 - Fixed accessing cf->can_dlc after buffer had been freed in
   can_rx_fifo_read_napi_frame()
 - Call can_led_event() only once per NAPI invocation.
 - Fixed missing { } on else branch in can_rx_fifo_add().
 - Documented ring buffer and overflow mailbox mechanism.
 - Remove NULL check before calling kfree() in can_rx_fifo_del().
 - Renamed second_first to scan_high_first.
 - Documented struct can_rx_fifo.
 - Replaced the BUG() in can_rx_fifo_irq_offload() with WARN().
 - Documented the difference between poll_can_state() and poll_bus_error().
 - Enabled support for leaving poll_*() handlers NULL if not needed.
 - Squashed two flexcan patches to avoid having a half-broken driver in
   between.
 - Consolidated can_rx_fifo_add_simple() and can_rx_fifo_irq_offload_simple()
   with a flag in struct can_rx_fifo, removing the need for those two
   functions.

David Jander (10):
  can: rx-fifo: Increase MB size limit from 32 to 64
  can: rx-fifo: Change to do controller off-load in interrupt and NAPI
    poll
  can: rx-fifo: fix long lines
  can: rx-fifo: Add can_rx_fifo_reset() function
  can: rx-fifo: remove obsolete comment
  can: rx-fifo: Add support for can state tracking and error polling
  can: rx-fifo: Add support for simple irq offloading
  can: rx-fifo: Add documentation to struct can_rx_fifo.
  can: flexcan: Add support for RX-FIFO
  can: flexcan: Add MB/Fifo specific column to comment table of IP
    versions

Marc Kleine-Budde (4):
  can: dev: add preliminary rx-fifo
  can: flexcan: add documentation about mailbox organizaiton
  can: flexcan: rename crl2 -> ctrl2
  can: flexcan: replace open coded mailbox code by proper defines

 drivers/net/can/dev.c     | 329 +++++++++++++++++++++++++++++++++
 drivers/net/can/flexcan.c | 452 ++++++++++++++++++++++++++++++++--------------
 include/linux/can/dev.h   |  90 +++++++++
 3 files changed, 736 insertions(+), 135 deletions(-)

-- 
1.9.1

