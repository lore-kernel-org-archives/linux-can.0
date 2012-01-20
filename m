From: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
Subject: Re: [PATCH 2/3 V3.1] can/usb: PEAK-System Technik PCAN-USB specific
 part
Date: Fri, 20 Jan 2012 14:37:30 +0100
Message-ID: <4F196E1A.9020005@volkswagen.de>
References: <Pine.LNX.4.44L0.1201191004540.1447-100000@iolanthe.rowland.org> <4F191D44.9080101@hartkopp.net> <4F195E08.5010504@volkswagen.de> <4F195F46.6080102@grandegger.com> <4F195FD7.9070808@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mr1.volkswagen.de ([194.114.62.75]:52581 "EHLO
	mr1.volkswagen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419Ab2ATNhg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 20 Jan 2012 08:37:36 -0500
In-Reply-To: <4F195FD7.9070808@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

On 20.01.2012 13:36, Wolfgang Grandegger wrote:
> On 01/20/2012 01:34 PM, Wolfgang Grandegger wrote:
>> Hi Oliver,
>>
>> On 01/20/2012 01:28 PM, Oliver Hartkopp wrote:
>>
>>> @Wolfgang: I always get "RTNETLINK answers: Device or resource busy"
>>> when the device is up - even on the EMS PCMCIA card. Should the manual
>>> restart generally be also possible even when the device is up??
>>
>> The restart is only for bus-off recovery. It will *not* restart if you
>> are not in bus-off.

Ah, ok. Reading the *open* source helps :-))

>>> I think the automatic restart (with restart-ms) has no preconditions to
>>> the device up/down state.
>>
>> But it only triggers in case of bus-off. It has nothing to do with up/down.
> 
> If you are at it, please also test the bus-off and bus-off recovery...
> Thanks...

Yes. Good point.

I set the PCAN-USB adapter (can2) to 100000 bit/s and let the two other
nodes at 500kbit/s.

With low traffic at 500kbit and sending one frame from the PCAN-USB 
(cansend can2 123#00) the bus-off is easy to reach on can2.

But the effect is:

I get every second(!) an error msg with

  can2  20000044  [8] 00 30 00 00 00 00 00 00   ERRORFRAME
    controller-problem{rx-error-passive,tx-error-passive}
    bus-off

But the state displayed in

ip -details -statistics link show can2 

always says 

15: can2: <NO-CARRIER,NOARP,UP,ECHO> mtu 16 qdisc pfifo_fast state DOWN qlen 10
    link/can
    can state ERROR-ACTIVE restart-ms 0 

... with increasing bus-off counter every second.

After setting the two other nodes at 100kbit/s too and do some traffic there, the
state of the PCAN-USB should get back to work - but is does not.

The error msgs every second remain from can2.

Regards,
Oliver
