From: "krumboeck@universalnet.at" <krumboeck@universalnet.at>
Subject: Re: [PATCH v2] usb_8dev: Add support for USB2CAN interface from 8
 devices
Date: Mon, 03 Dec 2012 21:32:18 +0100
Message-ID: <50BD0C52.6010606@universalnet.at>
References: <50BBF73F.9080208@universalnet.at> <50BC5ECB.9070206@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp.xy24.at ([85.126.109.136]:32944 "EHLO renate.xy24.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751008Ab2LCTcd (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 3 Dec 2012 14:32:33 -0500
In-Reply-To: <50BC5ECB.9070206@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, linux-usb@vger.kernel.org, gediminas@8devices.com, info@gerhard-bertelsmann.de

Hi Wolfgang!

>
> And please also drop the remaining sysfs files for firmware and
> hardware. I thinks it's enough that the versions are printed when the
> device is probed.

Systemadministrators often use versions for configuration scripts.
If you insist I will remove.

>> +/*
>> + * CAN driver for UAB "8 devices" USB2CAN converter
>
> UAB means?
>

I don't know. I've taken from the homepage. Maybe it is a type of company.

I will remove...



Thanks for your comments and suggestions.

regards,
Bernd
