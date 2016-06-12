From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: "user id" for can usb adapters
Date: Sun, 12 Jun 2016 21:05:18 +0200
Message-ID: <575DB26E.2050306@hartkopp.net>
References: <575C0C0A.60903@xor.wtf>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:42246 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932081AbcFLTFb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 12 Jun 2016 15:05:31 -0400
In-Reply-To: <575C0C0A.60903@xor.wtf>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Hubert Denkmair <xor@xor.wtf>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Maximilian Schneider <max@schneidersoft.net>

Hello Hubert, Max,

On 06/11/2016 03:03 PM, Hubert Denkmair wrote:
> for my candleLight adapter (gs_usb driver), I would like to implement a feature which is afaik currently not used in linux / socketcan:
>
> A device ID that the user can assign and store permanently on CAN interfaces, e.g. a USB CAN interface.
> This is not new - e.g. Peak System implements this in their Windows API.
>
> One use case would be to build multiple measurement setups, each with more than one CAN adapter.
>
> For example, at my company, we build test racks with several CAN interfaces.
> Each test rack should run with the same (unmodified) software image.
> To be able to build a stable environment, devices shall have a predictable name in each rack.
>
> One way to achieve this would be to
> - assign "user IDs" to the CAN interfaces (e.g. CAN A = 0, CAN B = 1, ...)
> - have this id exported, e.g. as a sysfs attribute
> - use udev to assign defined names for can interfaces with a certain id
>
> Implementing a sysfs attribute for one driver is easy - and I did that for testing purposes.
> But since this is (imho) a feature which could be useful for the whole socketcan infrastructure,
> I would like to see a standardized method for the functionality.
> We should also implement this in the pcan_usb linux driver.
>
> I am aware that there is a file /sys/class/net/<device>/dev_id - but no idea if that would be the right place.

Why not?

So far the dev_id is already used in some CAN drivers to identify 
instances/interfaces in CAN adapters that contain more than one CAN 
interface.

As this dev_id is established and already available e.g. for udev 
scripts I wonder if we only have to provide an interface to write this 
value (to set a specific value).

Is there a way to implement a handler that sets the dev_id into the 
hardware by writing to the sysfs entry??

This could be used e.g. for the PEAK USB interfaces too.

Regards,
Oliver


> Seems to me as if adding a new sysfs attribute like /sys/class/net/<device>/user_id would be a better way to go.
>
> So - any opinions on this?
>
> Greetings,
>
> Hubert
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
