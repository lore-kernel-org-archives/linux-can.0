From: Stefano Babic <sbabic@denx.de>
Subject: [PATCH v5 0/2] Adding support for CAN busses via SPI interface
Date: Mon, 28 Jul 2014 18:38:28 +0200
Message-ID: <1406565510-10783-1-git-send-email-sbabic@denx.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp2.ngi.it ([88.149.128.113]:52635 "EHLO smtp2.ngi.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750825AbaG1Qi5 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 28 Jul 2014 12:38:57 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Stefano Babic <sbabic@denx.de>


Hi all,

after some time, I post an updated version of the spi_can driver.
Sorry for that, but I had to wait for the requested modifications
on the microcontroller's firmware to test it again.

The majork change is the GET_CFG message to query the remote
CAN microcontroller for the CAN bittiming. I hope also I have fixed
all issues from previous reviews.


Changes in v5:
- drop Patch 2/3, already applied.
- sort include headers
- match open parenthesis (globally fixed)
- add newline to dev_err() in insert_cfg_msg()
- use sizeof(*p)
- drop unused variable val in ISR
- proper return code instead of -1
- move device ids after probe/remove
- drop #ifdef CONFIG_OF (not needed anymore)
- use devm_ API
- use module_spi_driver()

Changes in v4:
- added GET_CFG message to query bit timing to the remote controller.
- implement GET_CFG message to ask the microcontroller
  for bittiming consts.
- drop set_mode (never called)
- drop echo_index (never used)
- fix inconsistencies using int variable (int/u32)
- add reference to documentation in Kconfig help
- s/refTime/ref_time/
- move module parameters on the top
- use variable to get sizeof inside kzalloc/memset
- fix missing close_candev() in open entry point
- fix return values (spi_can_fill_skb_msg())
- not access skb after calling net_receive_skb()
- fix minor coding style issues
- add missing free_irq() and gpio_free() in probe when fails

Changes in v3:
- format documentation, check for lines > 80 chars (O. Hartkopp)
- patch 2/3 already aqpplied to can-next, removed from patchset
- spican.h renamed to spi_can.h
- drop further references to i.MX and HCS12, not yet cleaned
- drop CAN_DEV depend from Kconfig
- drop debug stuff via sysfs, not required in production code
- drop debug module parameter, use CAN_DEBUG_DEVICES
- drop unused bittiming constant
- chksum on as default. It could still be disabled via
  DT/pdata, but not via module parameter.

Changes in v2:
- drop all references to i.MX35 and HCS12

Stefano Babic (2):
  Add documentation for SPI to CAN driver
  CAN: CAN driver to support multiple CAN bus on SPI interface

 Documentation/networking/spi_can.txt |  774 +++++++++++++++++
 drivers/net/can/spi/Kconfig          |   11 +
 drivers/net/can/spi/Makefile         |    1 +
 drivers/net/can/spi/spi_can.c        | 1506 ++++++++++++++++++++++++++++++++++
 include/linux/can/platform/spi_can.h |   33 +
 5 files changed, 2325 insertions(+)
 create mode 100644 Documentation/networking/spi_can.txt
 create mode 100644 drivers/net/can/spi/spi_can.c
 create mode 100644 include/linux/can/platform/spi_can.h

-- 
1.9.1

