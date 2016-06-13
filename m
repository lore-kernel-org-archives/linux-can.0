From: Hubert Denkmair <xor@xor.wtf>
Subject: Re: "user id" for can usb adapters
Date: Mon, 13 Jun 2016 21:01:04 +0200
Message-ID: <575F02F0.6070600@xor.wtf>
References: <575C0C0A.60903@xor.wtf> <575DB26E.2050306@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.xor.wtf ([46.38.236.187]:46992 "EHLO mail.xor.wtf"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752138AbcFMTBO (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 13 Jun 2016 15:01:14 -0400
In-Reply-To: <575DB26E.2050306@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

Thanks Oliver,

>> I am aware that there is a file /sys/class/net/<device>/dev_id - but no idea if that would be the right place.
> 
> Why not?

Hrm, I'm not sure.
Kernel documentation says:

---
What:           /sys/class/net/<iface>/dev_id
Description:
		Indicates the device unique identifier. Format is an hexadecimal
		value. This is used to disambiguate interfaces which might be
		stacked (e.g: VLAN interfaces) but still have the same MAC
		address as their parent device.
---

Unfortunately, the description is clearly targeted to devices with MAC-Addresses;
Anyways, I would read it as "for net devices sharing the same physical device, use dev_id to distinguish them".
Even if it isn't specified anywhere, as a application developer I would also presume that all the child devices of one parent would be numbered continuously from 0.
The user id, on the other hand, would be a random number that the device owner can choose on its own.

Also, if the dev_id is already used in socketcan context (the pcan pro driver seems to do), one might break existing applications by using the new feature.

Then, I don't know if a write to the dev_id attribute would be hard to implement / need changes in the network subsystem.
Using a new sysfs attribute would be easy-going, I guess.

Anyways, I'm by no means a experienced kernel developer and I will leave these decisions to people who are :-)

Cheers,

Hubert
