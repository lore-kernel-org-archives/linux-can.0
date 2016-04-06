From: xor@xor.wtf
Subject: Re: Generic USB driver for small hardware projects?
Date: Wed, 06 Apr 2016 15:54:59 +0200
Message-ID: <a70ea0015a9c896afdfa7be4e7fa1bff@xor.wtf>
References: <5702C9C9.3050706@xor.wtf>
 <1459948981.31599.15.camel@schneidersoft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.xor.wtf ([46.38.236.187]:54673 "EHLO mail.xor.wtf"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751577AbcDFNzM (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 6 Apr 2016 09:55:12 -0400
In-Reply-To: <1459948981.31599.15.camel@schneidersoft.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Maximilain Schneider <max@schneidersoft.net>
Cc: linux-can@vger.kernel.org

Thanks Max,

thanks for your support, I wasn't aware of your device until now.
I'll take a closer look this weekend, for now the driver code looks nice 
& lean to me.

Greetings,

Hubert


Am 2016-04-06 15:23, schrieb Maximilain Schneider:
> Hello Hubert,
> 
> The Geschwister Schneider devices are open hardware and license free.
> You can build your device to be compatible with the gs_usb device
> driver. The source can be found at drivers/net/can/usb/gs_usb.c in the
> linux source code.
> 
> I realize there is no easy to follow spec available for the gs_usb
> protocol (I'm too lazy to write it), so implementing it will be a 
> little
> adventure. But if you have any questions, you can always ask me
> directly.
> 
> If you implement the protocol, your device should work plug and play
> with any uptodate and sufficiently configured kernel.
> 
> Of course, you could also write your own kernel module and load it
> manually as needed.
> 
> Regards,
> Max Schneider.
> 
> On Mon, 2016-04-04 at 22:08 +0200, Hubert Denkmair wrote:
>> Hi all,
>> 
>> I'm new to this list, so please excuse if my topic has been discussed
>> before. I didn't find anything like it in the recent archives, 
>> though...
>> 
>> I'm currently building - as others did before me - a small, cheap, 
>> open
>> hardware USB-CAN-Converter.
>> 
>> Now I have the same problem as everyone before me - how to get 
>> socketcan
>> support for it.
>> 
>> Of course, I can make a ACM device and implement the slcan protocol.
>> Which is, imho, a ugly hack and, besides needing a userspace daemon,
>> seems to have some shortcomings (e.g. not supporting the netlink 
>> config
>> interface, only a few supported bitrates...).
>> 
>> I'd much rather like to build a native socketcan usb driver for my
>> hardware. As this seems to be overkill for a small project like mine,
>> I'd propose to do something better:
>> 
>> Why not build a usb driver with a generic interface that all hardware
>> projects can implement if they want native socketcan support?
>> 
>> Though, before starting something like that, I'd like to know how you
>> think about it. Can I expect some support from the list?
>> Is there a existing usb driver to start from?
>> Do you think there is a chance to get such a driver into mainline 
>> kernel
>> in the near future?
>> 
>> If there is some interest, I'd like to discuss on the list how such a
>> interface should look like; E.g. provide all socketcan features, in a
>> way so that it's both easy to implement in firmware and the linux
>> driver, while making it possible for the hardware to also support 
>> other
>> protocols, e.g. the slcan interface.
>> 
>> Please let me know what you think of my proposal,
>> 
>> Cheers
>> 
>> Hubert
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-can" 
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

