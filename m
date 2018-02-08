From: Jimmy Assarsson <extja@kvaser.com>
Subject: Re: Associate physical device with device name
Date: Thu, 8 Feb 2018 14:04:08 +0100
Message-ID: <f1dbf319-eda5-6901-c5e4-d08651e2c1fe@kvaser.com>
References: <e8998556-5e13-1cec-f404-70c4679ca9c3@kvaser.com>
 <87ddf56f-c829-6aad-5b86-474359d282d4@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:43873 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbeBHNEO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 8 Feb 2018 08:04:14 -0500
Received: by mail-lf0-f42.google.com with SMTP id o89so6277076lfg.10
        for <linux-can@vger.kernel.org>; Thu, 08 Feb 2018 05:04:14 -0800 (PST)
In-Reply-To: <87ddf56f-c829-6aad-5b86-474359d282d4@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 2018-02-08 13:45, Marc Kleine-Budde wrote:
> On 01/26/2018 03:38 PM, Jimmy Assarsson wrote:
>> We would like to be able to associate physical (Kvaser) USB devices with
>> their device names (can0 etc.).
>> The interface's EAN (article number) combined with serial number, form a
>> unique identifier.
>>
>> It is not possible to do this from the USB descriptor. Since the serial
>> number is not provided in the USB descriptor. And the same PID is reused
>> for multiple EAN numbers. It is preferable with a solution that is
>> independent of interface type (USB etc.), since we may support other
>> devices in the future.
>>
>> This is somewhat similar to '"user id" for can usb adapters',
>> https://marc.info/?l=linux-can&m=146565019622100
>>
>> What is the preferable way of solving this kind of problem? Is sysfs
>> suitable?
> 
> Are your adaptors 100% idential? Then there is no way to tell them apart
> in software. However you should be possible to write a custom udev rule
> to rename the adapter depending on the physical USB-Port you are using.

No, they are not identical. The EAN and serial number is stored on the
device. Which makes a single device unique. It is possible to fetch
these from the device. And same applies to all Kvaser CAN interfaces,
regardless if they are connected via USB, PCI-express or ethernet.
