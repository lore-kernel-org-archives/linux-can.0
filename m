From: Jimmy Assarsson <extja@kvaser.com>
Subject: Re: Associate physical device with device name
Date: Fri, 9 Feb 2018 08:50:41 +0100
Message-ID: <d673896b-300d-14b0-30a5-c59db29c4f5e@kvaser.com>
References: <e8998556-5e13-1cec-f404-70c4679ca9c3@kvaser.com>
 <87ddf56f-c829-6aad-5b86-474359d282d4@pengutronix.de>
 <f1dbf319-eda5-6901-c5e4-d08651e2c1fe@kvaser.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:35687 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbeBIHup (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 9 Feb 2018 02:50:45 -0500
Received: by mail-lf0-f50.google.com with SMTP id a204so9964456lfa.2
        for <linux-can@vger.kernel.org>; Thu, 08 Feb 2018 23:50:45 -0800 (PST)
In-Reply-To: <f1dbf319-eda5-6901-c5e4-d08651e2c1fe@kvaser.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 2018-02-08 14:04, Jimmy Assarsson wrote:
> On 2018-02-08 13:45, Marc Kleine-Budde wrote:
>> On 01/26/2018 03:38 PM, Jimmy Assarsson wrote:
>>> We would like to be able to associate physical (Kvaser) USB devices with
>>> their device names (can0 etc.).
>>> The interface's EAN (article number) combined with serial number, form a
>>> unique identifier.
>>>
>>> It is not possible to do this from the USB descriptor. Since the serial
>>> number is not provided in the USB descriptor. And the same PID is reused
>>> for multiple EAN numbers. It is preferable with a solution that is
>>> independent of interface type (USB etc.), since we may support other
>>> devices in the future.
>>>
>>> This is somewhat similar to '"user id" for can usb adapters',
>>> https://marc.info/?l=linux-can&m=146565019622100
>>>
>>> What is the preferable way of solving this kind of problem? Is sysfs
>>> suitable?
>>
>> Are your adaptors 100% idential? Then there is no way to tell them apart
>> in software. However you should be possible to write a custom udev rule
>> to rename the adapter depending on the physical USB-Port you are using.
> 
> No, they are not identical. The EAN and serial number is stored on the
> device. Which makes a single device unique. It is possible to fetch
> these from the device. And same applies to all Kvaser CAN interfaces,
> regardless if they are connected via USB, PCI-express or ethernet.

Maybe the initial question was fuzzy. We want to achieve the following:
The user got two devices, one with SN (serial number) 5 and one with SN
6. The device with SN 5 is connected to CAN bus 'A' and the one with SN
6 is connected to CAN bus 'B'. The user connects the devices in
arbitrary order. And starts a user space application that should
communicate on CAN bus 'B'. The application should find and use the
netdev (can0 or can1) for the device with SN 6.
