From: Jimmy Assarsson <extja@kvaser.com>
Subject: Re: Associate physical device with device name
Date: Fri, 9 Feb 2018 16:35:17 +0100
Message-ID: <e5b62163-2ec7-eb89-e2a3-d8269292595f@kvaser.com>
References: <e8998556-5e13-1cec-f404-70c4679ca9c3@kvaser.com>
 <87ddf56f-c829-6aad-5b86-474359d282d4@pengutronix.de>
 <f1dbf319-eda5-6901-c5e4-d08651e2c1fe@kvaser.com>
 <464f89e6-82c8-a2fd-25e2-f847508b41a3@pengutronix.de>
 <35989d02-3134-1a84-8bec-61a863fa0bf3@kvaser.com>
 <771a0c6e-c94c-7dc2-ffa0-06507aab077d@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:37838 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbeBIPfV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 9 Feb 2018 10:35:21 -0500
Received: by mail-lf0-f48.google.com with SMTP id f137so11761471lfe.4
        for <linux-can@vger.kernel.org>; Fri, 09 Feb 2018 07:35:20 -0800 (PST)
In-Reply-To: <771a0c6e-c94c-7dc2-ffa0-06507aab077d@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 2018-02-09 14:24, Marc Kleine-Budde wrote:
> On 02/09/2018 12:21 PM, Jimmy Assarsson wrote:
>> All devices with the same EAN look identical, since we do not set serial
>> number in the USB descriptor.
> 
> That should be done on the next FW revision.

It is left out on purpose. I don't remember the details, but it had
something to do with Windows reinstalling the driver whenever a device
with different serial number is connected to the same USB port.

> Ok - I see two possibilities.
> 
> 1) sysfs file
> Add a file to sysfs that contains the serial number, see:
> http://lxr.bootlin.com/linux/latest/source/drivers/net/can/softing/softing_main.c#L718
> 
> 2) ethtool eeprom
> You can export the serial number via ethtool's dump eeprom functionality.
> 
> Better try 1).

Great :) Will try this next week.
Thanks!
