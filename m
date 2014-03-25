From: Stefano Babic <sbabic@denx.de>
Subject: [PATCH v2 0/3] Adding support for CAN busses via SPI interface
Date: Tue, 25 Mar 2014 15:30:19 +0100
Message-ID: <1395757822-22283-1-git-send-email-sbabic@denx.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp2.ngi.it ([88.149.128.113]:52563 "EHLO smtp2.ngi.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752597AbaCYOam (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 25 Mar 2014 10:30:42 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: socketcan@hartkopp.net, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Stefano Babic <sbabic@denx.de>


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

Patch 3/3 in V1: "Introduce can_get_echo_skb_ni() when TX is not in interrupt",
not required anymore (it was not used also in V1). Dropped.


Changes in v2:
- added patch to move SPI drivers into a separate directory
- drop all references to i.MX35 and HCS12

Stefano Babic (3):
  Add documentation for SPI to CAN driver
  CAN: moved SPI drivers into a separate directory
  CAN: CAN driver to support multiple CAN bus on SPI interface

 Documentation/networking/spi_can.txt |  707 ++++++++++++++++
 drivers/net/can/Kconfig              |    8 +-
 drivers/net/can/Makefile             |    2 +-
 drivers/net/can/spi/Kconfig          |   20 +
 drivers/net/can/spi/Makefile         |    9 +
 drivers/net/can/{ => spi}/mcp251x.c  |    0
 drivers/net/can/spi/spi_can.c        | 1534 ++++++++++++++++++++++++++++++++++
 include/linux/can/platform/spican.h  |   36 +
 8 files changed, 2309 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/networking/spi_can.txt
 create mode 100644 drivers/net/can/spi/Kconfig
 create mode 100644 drivers/net/can/spi/Makefile
 rename drivers/net/can/{ => spi}/mcp251x.c (100%)
 create mode 100644 drivers/net/can/spi/spi_can.c
 create mode 100644 include/linux/can/platform/spican.h

-- 
1.7.9.5

