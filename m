From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: detect auto baud rate on can bus in linux driver.
Date: Sun, 27 Apr 2014 20:01:35 +0200
Message-ID: <20140427180135.GB21176@vandijck-laurijssen.be>
References: <53590FB6.6090707@tataelxsi.co.in>
 <20140427094418.GB28319@griso.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay005.isp.belgacom.be ([195.238.6.171]:15778 "EHLO
	mailrelay005.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750733AbaD0SBv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 27 Apr 2014 14:01:51 -0400
Content-Disposition: inline
In-Reply-To: <20140427094418.GB28319@griso.site>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ratheendran <ba.rsrajeshwaran@tataelxsi.co.in>
Cc: John Whitmore <arigead@gmail.com>, linux-can@vger.kernel.org

Hey,

On Sun, Apr 27, 2014 at 10:44:22AM +0100, John Whitmore wrote:
> On Thu, Apr 24, 2014 at 06:50:54PM +0530, Ratheendran wrote:
> > Hi All,
> > 
> > Need you help in understanding detecting auto baud rate of CAN bus.
> > please share your valuable experience.

The baudrate detection principle is: configure your CAN chip, and if you receive
something, then the baudrate was good. This can only work when there is traffic.
The CAN chip should be set in a mode that does not disturb the bus.
This mode is called 'listen-only' for CAN.

Be sure to read
http://www.can-cia.org/fileadmin/cia/files/icc/9/koppe.pdf
I did only read it quickly, and it appears most items have been explained
a bit.

John Whitmore explained his scenario very well.
I just want to add some comments with special regard to linux.

> > 
> > I am using imx6 processor which has flexcan hardware driver
> > implemented as socketcan stack.
> >

Theoretically/ideally, all linux-can drivers behave the same.
Practically, a required feature for baudrate detection on CAN is
the listen-only mode. linux-can provides the API, but not all
drivers/devices support it.
Look into the code for CAN_CTRLMODE_LISTENONLY. My 3.12 tree flexcan driver
seems to support it, but I clearly did not test with real hardware.

> 
> I've used auto baud rate detection with the Microchip MCP2515 CAN Controller
> connected to a PIC controller, but not with Linux, as yet.

> I'm working on my
> own CAN Bus network so have control of all the nodes. There is a "Ping"
> Protocol built into the nodes so that if there is no network traffic in a
> certain period of time a random node will fire a "Ping" frame onto the CAN
> Bus. That way I'm guaranteed that there will be network traffic to listen to.
> 
> In addition to network traffic my network uses a fixed number of baud rates:
> 
> 10K, 20K, 50K, 125K, 250K, 500, 800K, and 1M
> 
> Now given all that on the network I simply set the MCP2515 into listen only
> mode at a baud rate of 10K. If the Ping message is set for 10 seconds and I
> listen for 30 Seconds I should at least get 3 CAN Frames. If I've got the
> wrong baud rate I'll get MERRE errors in listen mode. My driver simply, when
> in listen mode, counts received good frames and errors. If after 30 seconds
> I've got good frames and no errors then I've found the baud rate being used by
> the network and I can drop out of listen mode. If there are any errors then
> simply move up to the next baud rate and start listening again.
> 
> This all works for me as I'm assured of traffic and have a limited number of
> baud rates to search through.
> 
> I keep meaning to look at this on Linux but I've been distracted with other
> work. I'll get back to it. Not sure how it would fit into the Linux can
> architecture.

Autobaud is, IMO, a userspace thing.
The principle has been explained, and with iproute2 & candump piping into
grep or wc, you could even make a shell script for that.

> The Driver code would have to count errors and userspace would
> have to look at the results and change baud rate, or connect.
> 
> Hope that's of some help.
>  
> > With Regards,
> > Ratheendran

Kurt

