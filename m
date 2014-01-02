From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Precise timestamping
Date: Thu, 02 Jan 2014 15:10:51 +0100
Message-ID: <52C5736B.2070501@hartkopp.net>
References: <CAGfq0uu2mEemora+4RZD8P_DWK=zHL8Y2=-A8=0VJe=RL=o7ZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:18970 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbaABOK4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 2 Jan 2014 09:10:56 -0500
In-Reply-To: <CAGfq0uu2mEemora+4RZD8P_DWK=zHL8Y2=-A8=0VJe=RL=o7ZA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pavel Kirienko <pavel.kirienko.list@gmail.com>
Cc: linux-can@vger.kernel.org

Hello Pavel,

On 01.01.2014 16:25, Pavel Kirienko wrote:

> I am looking for an optimal way to implement two CAN interfaces for a
> carrier board for COM Express 2.0 computer-on-module (arch AMD64). The
> CAN network this computer will be connected to has few nodes that will
> periodically publish sensor measurements, and the application running
> on the computer will need to receive these measurements with precise
> timestamps (desired precision is around 1 ms).

The Linux timestamps are generated in nano secs resolution when the CAN frame
gets processed in the networking subsystem. This is done independently from
the way the CAN controller is attached to the system.

> The computer has the following interfaces: USB 2.0/3.0, PCIe, SPI, I2C.

Of course PCIe will have the fastest connection here with the lowest latency.

> Note that this device is going to work in a space constrained
> environment prone to intensive vibrations, thus solutions like an
> external PCIe board are unfeasible; external USB-CAN adapters (e.g.
> Peak System PCAN) are undesirable.

You can also remove the housing of CAN USB interfaces and connect the USB
lines to the CPU board directly. Probably the easiest & cheapest solution.

> Most obvious and most simple solution is to put a CAN-enabled
> microcontroller on the board, connect in to the computer via USB and
> use slcan transport (i.e. typical USB-CAN adapter embedded on the
> board). I like this approach for its straightforwardness.

What is the difference of connecting a homebrew CAN hardware via USB to use an
existing CAN USB hardware??

A homebrew CAN hardware with SLCAN is not as powerful as a native USB
transport for CAN frames and CAN configurations you can get with, e.g.

http://www.peak-system.com/PCAN-USB.199.0.html?&L=1
http://8devices.com/usb2can
http://schneidersoft.net/node/2

... and all the others that are supported in Linux mainline.

Using SLCAN the CPU board has to parse and create the ASCII protocol and e.g.
the error message reporting and the CAN bitrate configuration interface is
not(!) applicable for SLCAN devices.

If you need to extend the USB CAN adapter firmware: The USB8DEV adapters
firmware is available at github. And the schematics is available also, if you
still think about a homebrew board. SLCAN is not a good option though ...

> What kind of
> resolution I can expect in this case with stock Ubuntu kernel (12.04
> and higher)?

See above: nano secs.

> Other options I considered are to use an SPI CAN controller, like
> MCP251x or whatever supported by the Linux CAN backends. This should
> significantly reduce the read latency, but downside is that I'll need
> to use a custom built driver (with custom platform description files
> for SPI interface) (correct me if I am wrong).

The SPI interface is usually not recommended for higher CAN busloads, as you
need to transfer every CAN controller register access via SPI which becomes a
bottleneck. There had been several discussions about the mcp251x issues here.
The platform description is an additional reason not to use the SPI with your
AMD64 board.

> How much better the
> timestamping resolution can be with this approach, compared to slcan?

There's no difference regarding the timestamping for SLCAN and SPI.

If you think about hardware timestamps there are some adapters that support
them in the hardware. But the hardware timestamping is usually not implemented
in the driver as the Linux network timestamp is sufficient for most use-cases.

> Essentially, my question is: What are my options to implement
> low-latency (under 1 ms) CAN interface for a COM Express 2.0 device?

The USB CAN adapters or a (mini)PCIe solution, e.g.
http://www.peak-system.com/PCAN-miniPCIe.285.0.html?&L=1
should fit your needs for your CPU board. I don't have a strong recommendation
for a specific CAN hardware but PCI(e) and USB are known to run very well in
x86 environments.

Regards,
Oliver

