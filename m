From: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
Subject: Re: exclusive access to can interface
Date: Tue, 08 Jan 2013 11:09:28 +0100
Message-ID: <50EBF058.5050400@volkswagen.de>
References: <2412937.XVpYjfC7zz@ws-stein> <2293513.Wi876mfY7y@ws-stein> <50EBE7A9.3050809@pengutronix.de> <1943558.lxo8ZHFGuj@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mr1.volkswagen.de ([194.114.62.75]:36921 "EHLO
	mr1.volkswagen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755138Ab3AHKJi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Jan 2013 05:09:38 -0500
In-Reply-To: <1943558.lxo8ZHFGuj@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

Am 08.01.2013 10:48, schrieb Alexander Stein:
> Hello,
>
> On Tuesday 08 January 2013 10:32:25, Marc Kleine-Budde wrote:
>> On 01/08/2013 10:23 AM, Alexander Stein wrote:
>>> Hello Marc,
>>>
>>> On Monday 07 January 2013 19:16:20, Marc Kleine-Budde wrote:
>>>> On 01/07/2013 05:52 PM, Alexander Stein wrote:
>>>>> is there a way to get exclusive (write) access to a CAN interface, so
>>>>> that only one bound socket can write CAN frames on the bus?
>>>>
>>>> No, what's the use case?
>>>
>>> This was a customers request in order to prevent multiple applications (or
>>> instances) to send CAN frames on a specific CAN interface at the same time
>>> with the very same CAN-IDs. Concurrent reads shall still be allowed!
>>
>> Sending CAN frames is proper serialized by the networking subsystem :)
>> If back to back CAN frames are a problem it seems the design of the
>> application is fishy.
>
> I don't think serializaton or back to back frames are the problem. Think of CANopen there would be the same Node-ID twice on the bus.
>

This should be solved by the system setup.

E.g. if you start two applications using/providing identical resources at the 
same time, you'll always get into trouble.

If you start two inetd daemons, the second one would fail as he would like to 
bind the same IP ports. But this kind of mechanic is not available with CAN 
sockets.

I would tend to make sure that the Node-ID is always unique in your system.
What would happen, if you start a Node-ID on your host that already exists on 
the CAN networks attached to the system? You have to deal with that too:
E.g. terminate myself with some error logging if i see my own Node-ID

Even if i don't think you should go that way, you can use the can-gw routings 
and let the applications work on different (virtual) CAN interfaces.

One CAN interface, that can write to the real CAN and one that only reads from 
the real CAN:

ip link add dev can0_rw type vcan
ip link add dev can0_ro type vcan

cangw -A -s can0 -d can0_rw -e
cangw -A -s can0_rw -d can0 -e
cangw -A -s can0 -d can0_ro -e

Then let the sending app run on can0_rw and the others on can0_ro.

You might also add CAN filters to these routing rules.

Regards,
Oliver

