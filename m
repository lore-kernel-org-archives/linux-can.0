From: Pavel Kirienko <pavel.kirienko.list@gmail.com>
Subject: Precise timestamping
Date: Wed, 1 Jan 2014 19:25:36 +0400
Message-ID: <CAGfq0uu2mEemora+4RZD8P_DWK=zHL8Y2=-A8=0VJe=RL=o7ZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:61770 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754286AbaAAPZi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Jan 2014 10:25:38 -0500
Received: by mail-bk0-f42.google.com with SMTP id w11so4409919bkz.1
        for <linux-can@vger.kernel.org>; Wed, 01 Jan 2014 07:25:37 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi Linux CAN,

I am looking for an optimal way to implement two CAN interfaces for a
carrier board for COM Express 2.0 computer-on-module (arch AMD64). The
CAN network this computer will be connected to has few nodes that will
periodically publish sensor measurements, and the application running
on the computer will need to receive these measurements with precise
timestamps (desired precision is around 1 ms).

The computer has the following interfaces: USB 2.0/3.0, PCIe, SPI, I2C.

Note that this device is going to work in a space constrained
environment prone to intensive vibrations, thus solutions like an
external PCIe board are unfeasible; external USB-CAN adapters (e.g.
Peak System PCAN) are undesirable.

Most obvious and most simple solution is to put a CAN-enabled
microcontroller on the board, connect in to the computer via USB and
use slcan transport (i.e. typical USB-CAN adapter embedded on the
board). I like this approach for its straightforwardness. What kind of
resolution I can expect in this case with stock Ubuntu kernel (12.04
and higher)?

Other options I considered are to use an SPI CAN controller, like
MCP251x or whatever supported by the Linux CAN backends. This should
significantly reduce the read latency, but downside is that I'll need
to use a custom built driver (with custom platform description files
for SPI interface) (correct me if I am wrong). How much better the
timestamping resolution can be with this approach, compared to slcan?

Essentially, my question is: What are my options to implement
low-latency (under 1 ms) CAN interface for a COM Express 2.0 device?

Thanks in advance,
Pavel.
