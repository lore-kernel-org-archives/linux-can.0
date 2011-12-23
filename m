From: dev@sebastianhaas.info
Subject: Re: [PATCH] Add PEAK System USB adapters core driver
Date: Fri, 23 Dec 2011 12:48:09 +0100
Message-ID: <9ca914fe7e4c5fb6258f102903c2816f@sebastianhaas.info>
References: <871799.098418222-sendEmail@ubuntu-i386>
 <4EF3A40E.4080206@sebastianhaas.info> <4EF44AFC.60400@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtprelay02.ispgateway.de ([80.67.31.29]:35963 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756551Ab1LWLsL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 23 Dec 2011 06:48:11 -0500
In-Reply-To: <4EF44AFC.60400@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: s.grosjean@peak-system.com
Cc: Linux-can Mailing List <linux-can@vger.kernel.org>

Am 23.12.2011 10:33, schrieb Grosjean Stephane:
> - but what about the followings?
>
>> +    struct can_bittiming *bt =&dev->can.bittiming;
>                                  ^^^ remove whitespace
Add whitespace between = and &
> ...
>
>> +    if (sizeof_candev<  sizeof(struct peak_usb_device))
>                         ^^^^^^ cleanup
Add whitespace between candev and <
>
> ...
>
>> +    netdev->netdev_ops =&peak_usb_netdev_ops;
>                            ^^^^ whitespace
Add whitespace between = and &
> ...
>
>>> +
>>> +    SET_NETDEV_DEV(netdev,&intf->dev);
>>                              ^^^
Add whitespace between , and &
>>> +
>>> +        dev->state&= ~PCAN_USB_STATE_CONNECTED;
>>                          ^^^^
>>> +            if (*pc<  32 || *pc>  127)
>>                               ^^^^         ^^
Change whitespaces to pc < 32 and pc > 127
> It looks like missing whitespaces sometimes, and sometimes there were
> too in your text... which is different from the patch I sent
> yesterday. Or do I misunderstand your comments?
Yes, this is what I meant. On some places you have too many whitespaces 
when using operators, and sometimes they are completely missing.

>>> +
>>> +    /* Last chance do send some synchronous commands here */
>>> +    err = driver_for_each_device(&peak_usb_driver.drvwrap.driver, 
>>> NULL,
>>> +        NULL, peak_usb_do_device_exit);
>>> +    if (err)
>>> +        err = 0;
>> \err\ is neither checked nor printed, why not removing it?
>>
>
> Because of that (see <linux/device.h>):
>
> extern int __must_check driver_for_each_device(struct device_driver 
> *drv,
>            ~~~~~~~~~~~~
>
> ... Is there any other way to get around that?
Then I suggest to log it.

I hope to find time to review the other patches on evening.

Cheers,
  Sebastian
