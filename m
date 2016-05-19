From: Marek Vasut <marex@denx.de>
Subject: [RFC] K-Line protocol via SocketCAN
Date: Fri, 20 May 2016 01:15:42 +0200
Message-ID: <573E491E.1000906@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:57522 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932913AbcESXPo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 19 May 2016 19:15:44 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, davem@davemloft.net, Wolfgang Grandegger <wg@grandegger.com>

Hi!

My task now is implementing ISO9141-2 (K-Line) protocol [1] support for
mainline Linux. The protocol is quite simple, very close to standard
UART communication with a few details added to it (see below). In fact,
the K-Line tools often use UART with RX/TX lines tied together to talk
to K-Line devices. The differences from standard UART protocol are:

1) When negotiating the communication, one has to send special fixed
   pattern over the line. The pattern and it's speed should be
   configurable. By default, it's pattern 0x33 at 5Bd/s for K-Line,
   0x8f 0xf9 for KWP2000 protocol.
2) After the initial fixed pattern, line switches to 10400 Bd/s ,
   though the speed must be configurable due to some obscure K-Line
   extensions which run at 250kBd/s.
3) Inter-byte delay must be configurable.
4) The driver must allow configuring RX suppression (since the RX/TX
   lines are tied together, every transmitted byte will be received,
   which should be filtered away).
5) Error reporting should be available
6) Timestamping should be available

I was discussing the implementation internally and also revisited my
(failed) attempt to add arinc429 support to Linux. The idea boiled down
to the following:

I) Since the communication is often done via standard UART with RX/TX
   lines tied together, we could use TTY line discipline to handle the
   K-Line protocol specialties on the UART side.
II) Since the protocol uses rudimentary addressing, there is 1 byte of
    receiving address and 1 byte of transmitter address in each frame,
    it would make sense to support it via socketcan stack. This would
    make the driver very similar to slcan.c .
III) Since we need to configure multiple baudrates of the link, the echo
     suppression and the inter-byte delay, it would make sense to use
     rtnetlink for the configuration. This would need to borrow bits
     from drivers/net/can/dev.c .

To achieve the above, I think I would have to factor out common code
from drivers/net/can/dev.c and extend the netlink interface there with
a few new K-Line specific options to allow me to cater for the baudrate
setup.

I would then be able to register this K-Line device as a standard can
netdevice. I would likely use the .ndo_open() to send the link start
sequence 1).

I would also need some sort of sl_klined.c, similar to slcand.c in
can-utils, in userspace to configure the kline tty device.

Does it make sense to plug this K-Line support into the socketcan,
possibly by making socketcan more universal? What do you think ?

I believe I should be able to get RX and TX timestamps from socketcan,
is that correct ?

One thing which worries me is the rtnetlink. I will need to change the
K-Line linkspeed exactly after transmitting some K-Line data via the
socket and before transmitting more data. How can I assure that the
change done via the rtnetlink happens exactly after the first batch of
data were transmitted over the socket and before the next batch ?

Another option would be to possibly extend the linux tty interface
to allow the inter-byte delay, timestamping and error counting. I
don't like this option, it doesn't feel right.

I will also need to add support for the LIN protocol and SENT protocol
further down the line. I will also likely revisit the Arinc at some
point afterward. So I would like to know how to deal with this protocol
mess.

[1] https://en.wikipedia.org/wiki/On-board_diagnostics

Thanks!
-- 
Best regards,
Marek Vasut
