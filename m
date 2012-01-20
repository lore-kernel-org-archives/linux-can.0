From: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
Subject: Re: [PATCH 2/3 V3.1] can/usb: PEAK-System Technik PCAN-USB specific
 part
Date: Fri, 20 Jan 2012 13:28:56 +0100
Message-ID: <4F195E08.5010504@volkswagen.de>
References: <Pine.LNX.4.44L0.1201191004540.1447-100000@iolanthe.rowland.org> <4F191D44.9080101@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mr1.volkswagen.de ([194.114.62.75]:46775 "EHLO
	mr1.volkswagen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352Ab2ATMep (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 20 Jan 2012 07:34:45 -0500
In-Reply-To: <4F191D44.9080101@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-can Mailing List <linux-can@vger.kernel.org>

Hi Stephane,

it also fails on 3.2.1 :-(

When the TX path get stuck the ip tool says:

root@box:/home/user# ip -details -statistics link show can2
15: can2: <NO-CARRIER,NOARP,UP,ECHO> mtu 16 qdisc pfifo_fast state DOWN qlen 10
     link/can
     can state ERROR-ACTIVE restart-ms 0
     bitrate 500000 sample-point 0.875
     tq 125 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
     pcan_usb: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
     clock 8000000
     re-started bus-errors arbit-lost error-warn error-pass bus-off
     0          0          0          4          351        2
     RX: bytes  packets  errors  dropped overrun mcast
     11642427   2023785  3       0       3       0
     TX: bytes  packets  errors  dropped carrier collsns
     5765840    1002590  0       0       0       0


When trying to restart the PCAN-USB adapter i got this:

root@box:/home/user# ip link set can2 type can restart
RTNETLINK answers: Device or resource busy

Checking for error msgs then:

user@box:~$ candump can2,0~0,#FFFFFFFF -e
   can2  20000004  [8] 00 30 00 00 00 00 00 00   ERRORFRAME
	controller-problem{rx-error-passive,tx-error-passive}
   can2  20000004  [8] 00 30 00 00 00 00 00 00   ERRORFRAME
	controller-problem{rx-error-passive,tx-error-passive}
   can2  20000004  [8] 00 30 00 00 00 00 00 00   ERRORFRAME
	controller-problem{rx-error-passive,tx-error-passive}
   can2  20000004  [8] 00 30 00 00 00 00 00 00   ERRORFRAME
	controller-problem{rx-error-passive,tx-error-passive}
(..)
(every second a new msg)

While RX of real CAN traffic is still possible ...

ifconfig can2 down/up makes it work again.

@Wolfgang: I always get "RTNETLINK answers: Device or resource busy" when the 
device is up - even on the EMS PCMCIA card. Should the manual restart 
generally be also possible even when the device is up??
I think the automatic restart (with restart-ms) has no preconditions to the 
device up/down state.

Regards,
Oliver


On 20.01.2012 08:52, Oliver Hartkopp wrote:
> On 19.01.2012 16:07, Alan Stern wrote:
>
>> On Thu, 19 Jan 2012, Stephane Grosjean wrote:
>
>>> +static int pcan_usb_send_cmd(struct peak_usb_device *dev, u8 f, u8 n, u8 *p)
>
>
>>> +	struct pcan_usb_parameter cmd = {
>>> +		.function = f,
>>> +		.number = n,
>>> +	};
>>> +
>>
>> Here, and in several other places in this patch series, you submit
>> requests using a transfer buffer that is allocated on the stack.  This
>> is forbidden because not all platforms can do DMA to stack or static
>> addresses.  The transfer buffers should be allocated dynamically.
>>
>> Alan Stern
>
>
> Hello Stephane,
>
> don't know if it could be related to that remark but i get sporadic tx stalls
> when sending at full speed. The RX is working then but to send again, i need
> to perform a ifconfig down/up sequence.
>
> When using
>
> 	ip link set can0 type can restart-ms 100
>
> with the adapter then the system entirely crashes after a while.
>
> As this may be related to the 3.3rc1 kernel and therefore i'll do some tests
> with a 3.2.1 today to.
>
> My testbed (all sja1000 based controllers) connected to one bus:
>
> can0: EMS PCMCIA channel 0
> can1: EMS PCMCIA channel 1
> can2: PEAK USB
>
> cangen -i -g0 can0
> cangen -i -g0 can2
>
> As the traffic has random IDs there could emerge the same tx ID (which is
> against CAN spec). At a certain point the PCAN USB creates some error-passive
> errors and finally increases a bus-off state. But it seam to not heal the tx
> path from this state due to the valid traffic from can0 ->  can1.
>
> And when configured "restart-ms 100" it kills the machine then.
>
> Btw.
>
> cangen -i -g0 can0 -I 400
> cangen -i -g0 can2 -I 600
>
> and
>
> cangen -i -g0 can0 -I 500
> cangen -i -g0 can2 -I 500
>
> (!!!)
>
> both run without problems for a long time.
>
> Best regards,
> Oliver
>
> ps. I reduced the number of lists to linux-can for the report.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

