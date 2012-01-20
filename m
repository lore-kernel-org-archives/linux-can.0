From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 2/3 V3.1] can/usb: PEAK-System Technik PCAN-USB specific
 part
Date: Fri, 20 Jan 2012 08:52:36 +0100
Message-ID: <4F191D44.9080101@hartkopp.net>
References: <Pine.LNX.4.44L0.1201191004540.1447-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:17297 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836Ab2ATHwm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 20 Jan 2012 02:52:42 -0500
In-Reply-To: <Pine.LNX.4.44L0.1201191004540.1447-100000@iolanthe.rowland.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-can Mailing List <linux-can@vger.kernel.org>

On 19.01.2012 16:07, Alan Stern wrote:

> On Thu, 19 Jan 2012, Stephane Grosjean wrote:

>> +static int pcan_usb_send_cmd(struct peak_usb_device *dev, u8 f, u8 n, u8 *p)


>> +	struct pcan_usb_parameter cmd = {
>> +		.function = f,
>> +		.number = n,
>> +	};
>> +
> 
> Here, and in several other places in this patch series, you submit
> requests using a transfer buffer that is allocated on the stack.  This
> is forbidden because not all platforms can do DMA to stack or static
> addresses.  The transfer buffers should be allocated dynamically.
> 
> Alan Stern


Hello Stephane,

don't know if it could be related to that remark but i get sporadic tx stalls
when sending at full speed. The RX is working then but to send again, i need
to perform a ifconfig down/up sequence.

When using

	ip link set can0 type can restart-ms 100

with the adapter then the system entirely crashes after a while.

As this may be related to the 3.3rc1 kernel and therefore i'll do some tests
with a 3.2.1 today to.

My testbed (all sja1000 based controllers) connected to one bus:

can0: EMS PCMCIA channel 0
can1: EMS PCMCIA channel 1
can2: PEAK USB

cangen -i -g0 can0
cangen -i -g0 can2

As the traffic has random IDs there could emerge the same tx ID (which is
against CAN spec). At a certain point the PCAN USB creates some error-passive
errors and finally increases a bus-off state. But it seam to not heal the tx
path from this state due to the valid traffic from can0 -> can1.

And when configured "restart-ms 100" it kills the machine then.

Btw.

cangen -i -g0 can0 -I 400
cangen -i -g0 can2 -I 600

and

cangen -i -g0 can0 -I 500
cangen -i -g0 can2 -I 500

(!!!)

both run without problems for a long time.

Best regards,
Oliver

ps. I reduced the number of lists to linux-can for the report.
