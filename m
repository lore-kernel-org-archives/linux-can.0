From: Stefano Babic <sbabic@denx.de>
Subject: [PATCH v1 0/3] Adding support for CAN busses via SPI interface
Date: Fri, 21 Mar 2014 13:25:55 +0100
Message-ID: <1395404758-21977-1-git-send-email-sbabic@denx.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp2.ngi.it ([88.149.128.113]:37866 "EHLO smtp2.ngi.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755604AbaCUMe3 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 21 Mar 2014 08:34:29 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, socketcan@hartkopp.net, Stefano Babic <sbabic@denx.de>


Hi all,

this patches wants to add support for CAN busses managed by
separate microcontrollers, connected to the main processor via
the SPI interface.

Firstly, I beg your pardon. I know that it would be really better
to send a RFC proposal how to support it. However, it was not possible
when this project was started and I am trying now, after the project is finished,
to send back these enhancements to the community.

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

Patch 3/3, "Introduce can_get_echo_skb_ni() when TX is not in interrupt",
was already sent for merging:

https://lists.berlios.de/pipermail/socketcan-core/2011-May/005752.html

However, in that time there was no use case for it - that is, this driver
is the user of it.



Stefano Babic (3):
  Add documentation for SPI to CAN driver
  CAN: CAN driver to support multiple CAN bus on SPI interface
  Introduce can_get_echo_skb_ni() when TX is not in interrupt

 Documentation/networking/spi_can.txt |  707 ++++++++++++++++
 drivers/net/can/Kconfig              |   11 +
 drivers/net/can/Makefile             |    1 +
 drivers/net/can/dev.c                |   21 +
 drivers/net/can/spi_can.c            | 1533 ++++++++++++++++++++++++++++++++++
 include/linux/can/dev.h              |    1 +
 include/linux/can/platform/spican.h  |   36 +
 7 files changed, 2310 insertions(+)
 create mode 100644 Documentation/networking/spi_can.txt
 create mode 100644 drivers/net/can/spi_can.c
 create mode 100644 include/linux/can/platform/spican.h

-- 
1.7.9.5

