From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Kernel Oops with: ip link set can0 type can
Date: Tue, 21 Jun 2016 15:28:36 +0200
Message-ID: <0c80e255-f0d5-182a-b9ef-b2c385bb8092@hartkopp.net>
References: <loom.20160621T095606-63@post.gmane.org>
 <loom.20160621T105023-651@post.gmane.org>
 <53a1d68d-6267-e3fc-af7d-ba4d49f8124a@hartkopp.net>
 <loom.20160621T142652-138@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:35511 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbcFUNdW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 21 Jun 2016 09:33:22 -0400
In-Reply-To: <loom.20160621T142652-138@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: ajneu <ajneu1@gmail.com>, linux-can@vger.kernel.org

On 06/21/2016 02:31 PM, ajneu wrote:

>>> Question:
>>> How should one add and set a can device???
>>
>> You do can not add a CAN device.
>>
>> A 'real' CAN netdevice is detected and initialized automatically.
>
> Well ok, I hear you.
>
> But how is the netdevice detected and initialized automatically?

Usually at driver loading time (e.g. USB plug-in) the driver initializes 
the USB adapter and creates the CAN network device.

> Is this from udev somewhere? Where? Can you point me to where that is?
> What if I want to issue commands myself -- that possible?

It's like Ethernet network devices. They are available or not.
And sometimes they are assigned in device tree descriptions for S-o-Cs 
or are hotplugged like USB.

>
>
> Note also:
> I can still do this:
>    sudo ip link delete can0   ## also removes /sys/class/net/can0
>
> Is this "legal"??

No. Definitely not.

> As mentioned in another post -- If I still have the can0 interface
> connected, and remove it from the PC AFTER that 'ip link delete' command,
> then the whole system hangs.

Yes I've seen that posting.

I just wondered why you can delete 'can0' when there's no callback in

	static struct rtnl_link_ops can_link_ops __read_mostly = {

in linux/drivers/net/can/dev.c ??

Looks like the default for rtnl dellink is to do something - instead of 
doing nothing %-(

http://lxr.free-electrons.com/source/include/net/rtnetlink.h#L51

Obviously we need a similar handling for rtnl dellink as we had for
rtnl newlink for can here:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=993e6f2fd

I will send a patch for testing ...

Best regards,
Oliver

