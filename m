From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: Associate physical device with device name
Date: Sat, 10 Feb 2018 10:58:46 +0100
Message-ID: <A7A363A1-BBA6-4460-A84A-9681AD872594@vandijck-laurijssen.be>
References: <e8998556-5e13-1cec-f404-70c4679ca9c3@kvaser.com> <87ddf56f-c829-6aad-5b86-474359d282d4@pengutronix.de> <f1dbf319-eda5-6901-c5e4-d08651e2c1fe@kvaser.com> <464f89e6-82c8-a2fd-25e2-f847508b41a3@pengutronix.de> <35989d02-3134-1a84-8bec-61a863fa0bf3@kvaser.com> <771a0c6e-c94c-7dc2-ffa0-06507aab077d@pengutronix.de> <e5b62163-2ec7-eb89-e2a3-d8269292595f@kvaser.com> <16bc3c4c-4013-9d9c-4afe-4cbffc2d8ad7@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b01.edpnet.be ([212.71.1.221]:39921 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbeBJJ6x (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 10 Feb 2018 04:58:53 -0500
In-Reply-To: <16bc3c4c-4013-9d9c-4afe-4cbffc2d8ad7@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Jimmy Assarsson <extja@kvaser.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Beware that you should have added the sysfs property before you register the can device. Doing it after may be too late since udev is reading the properties already.
I remember that netdev's can add a limited # groups, else you add the serial to de device, not the netdev.
Kurt

On 9 February 2018 18:09:36 CET, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>
>
>On 02/09/2018 04:35 PM, Jimmy Assarsson wrote:
>> On 2018-02-09 14:24, Marc Kleine-Budde wrote:
>>> On 02/09/2018 12:21 PM, Jimmy Assarsson wrote:
>>>> All devices with the same EAN look identical, since we do not set
>serial
>>>> number in the USB descriptor.
>>>
>>> That should be done on the next FW revision.
>> 
>> It is left out on purpose. I don't remember the details, but it had
>> something to do with Windows reinstalling the driver whenever a
>device
>> with different serial number is connected to the same USB port.
>> 
>>> Ok - I see two possibilities.
>>>
>>> 1) sysfs file
>>> Add a file to sysfs that contains the serial number, see:
>>>
>http://lxr.bootlin.com/linux/latest/source/drivers/net/can/softing/softing_main.c#L718
>
>>>
>>>
>>> 2) ethtool eeprom
>>> You can export the serial number via ethtool's dump eeprom
>functionality.
>>>
>>> Better try 1).
>> 
>> Great :) Will try this next week.
>
>Would it make sense to provide a common sysfs infrastructure in
>
>	linux/drivers/net/can/dev.c
>
>to populate
>
>	/sys/class/net/<can-interface-name>/<serial-num-whatever>
>
>instead of maintaining this stuff in each single driver?
>
>We have this requirement in the softing/kvaser/peak adapters so far.
>
>We could provide some pointer in struct can_priv which points to a 
>struct which contains the sysfs content - or something like this.
>
>Any thoughts?
>
>Best,
>Oliver
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-can" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

Sent from a small mobile device
