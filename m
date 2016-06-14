From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: "user id" for can usb adapters
Date: Tue, 14 Jun 2016 08:39:16 +0200
Message-ID: <575FA694.4080709@hartkopp.net>
References: <575C0C0A.60903@xor.wtf> <575DB26E.2050306@hartkopp.net>
 <575F02F0.6070600@xor.wtf>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:30090 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbcFNGjY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 14 Jun 2016 02:39:24 -0400
In-Reply-To: <575F02F0.6070600@xor.wtf>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Hubert Denkmair <xor@xor.wtf>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Hubert,

On 06/13/2016 09:01 PM, Hubert Denkmair wrote:

>>> I am aware that there is a file /sys/class/net/<device>/dev_id - but no idea if that would be the right place.
>>
>> Why not?
>
> Hrm, I'm not sure.
> Kernel documentation says:
>
> ---
> What:           /sys/class/net/<iface>/dev_id
> Description:
> 		Indicates the device unique identifier. Format is an hexadecimal
> 		value. This is used to disambiguate interfaces which might be
> 		stacked (e.g: VLAN interfaces) but still have the same MAC
> 		address as their parent device.
> ---
>
> Unfortunately, the description is clearly targeted to devices with MAC-Addresses;

Really? It is indented to disambiguate interfaces with the same MAC.
All CAN interfaces have the same MAC (00:00:00:00:00:00) :-)

In linux/include/linux/netdev.h the comment for dev_id is:

@dev_id:
Used to differentiate devices that share the same link layer address

And still we have no differentiating link layer address for CAN.

> Anyways, I would read it as "for net devices sharing the same physical device, use dev_id to distinguish them".
> Even if it isn't specified anywhere, as a application developer I would also presume that all the child devices of one parent would be numbered continuously from 0.
> The user id, on the other hand, would be a random number that the device owner can choose on its own.

I would tend to a increasing numbering as default. But 'root' should be 
able to set a user specified value into this dev_id. Especially when the 
interface is capable to store this dev_id (e.g. in EEPROM) the next time 
this value could be read from EEPROM and set into dev_id.

> Also, if the dev_id is already used in socketcan context (the pcan pro driver seems to do), one might break existing applications by using the new feature.

No. So far this dev_id was intended to be used as described above - but 
no one pushed this idea further. Your request proves the need for some 
dev_id again.

> Then, I don't know if a write to the dev_id attribute would be hard to implement / need changes in the network subsystem.

I don't know too. I think we would need some new callbacks in 
linux/include/linux/can/dev.h :

int (*do_set_dev_id)(struct net_device *dev, int dev_id);
int (*do_get_dev_id)(struct net_device *dev);

To read/write the dev_id to the EEPROM when supported.

So it would be 'just' to check whether sysfs dev_id can be made writable 
for CAN interfaces like tx_queue_len already is.

> Using a new sysfs attribute would be easy-going, I guess.

Don't know if it would be simpler.

> Anyways, I'm by no means a experienced kernel developer and I will leave these decisions to people who are :-)

I don't claim to have 'the best solution' - but making use of dev_id 
looks better than creating 'just another' configuration option.

Best regards,
Oliver
