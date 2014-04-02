From: Stefano Babic <sbabic@denx.de>
Subject: [PATCH v3 0/2] Adding support for CAN busses via SPI interface
Date: Wed,  2 Apr 2014 09:18:39 +0200
Message-ID: <1396423121-28949-1-git-send-email-sbabic@denx.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp1.ngi.it ([88.149.128.112]:42565 "EHLO smtp1.ngi.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757983AbaDBHTE (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 2 Apr 2014 03:19:04 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, socketcan@hartkopp.net, Wolfgang Grandegger <wg@grandegger.com>, Stefano Babic <sbabic@denx.de>


Hi all,

this patches wants to add support for CAN busses managed by
separate microcontrollers, connected to the main processor via
the SPI interface.

The use case for this driver is when the main controller has not enough
interfaces as required and/or, due to power consumption, it is better
to use additional low-cost microcontrollers to handle the CAN busses.
These microcontrollers can be on for all time, and they turn on the
main controller when they start to receive CAN packets.

In my specific project, I had an i.MX 35 as main controller, connected via
SPI to a HCS-12 (16 bit Freescale low-power controller), that is able
to manage up to 5 CAN busses. The 16-bit controller manages the CAN busses
and sends the received packets to the i.MX35 on the SPI bus. A protocol
was designed for the exchanged frames on the SPI bus (described in first patch)
to allow the multiplexing and demultiplexing of multiple channels.
The slave-part of the protocol (firmware running on the microcontroller)
is outside this scope. The microcontroller has no OS running on it.
I would like to have this driver as a way to "remotize" CAN busses on the SPI -
I think there are more other projects that did or are doing the same.


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

 Documentation/networking/spi_can.txt |  725 +++++++++++++++++
 drivers/net/can/spi/Kconfig          |    9 +
 drivers/net/can/spi/Makefile         |    1 +
 drivers/net/can/spi/spi_can.c        | 1448 ++++++++++++++++++++++++++++++++++
 include/linux/can/platform/spi_can.h |   33 +
 5 files changed, 2216 insertions(+)
 create mode 100644 Documentation/networking/spi_can.txt
 create mode 100644 drivers/net/can/spi/spi_can.c
 create mode 100644 include/linux/can/platform/spi_can.h

-- 
1.7.9.5

