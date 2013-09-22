From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: adding can4linux to drivers/char
Date: Sun, 22 Sep 2013 13:01:21 +0200
Message-ID: <523ECE01.40401@hartkopp.net>
References: <1881932.U1kQQJkqCz@heinz.site> <523DA147.7090403@pengutronix.de> <CADGMhsU2fD3VnSkRqCJ9AT3SCmKRaX_965i6Kr-gdaFFwDejvw@mail.gmail.com> <523DD2C3.7000505@pengutronix.de> <523DE2C9.4020407@hartkopp.net> <CADGMhsXaJOpbdCgEAoOguZWX2rS_P0a-H5UDZwUWiHD4Nj=upw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:55623 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752919Ab3IVLB1 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 22 Sep 2013 07:01:27 -0400
In-Reply-To: <CADGMhsXaJOpbdCgEAoOguZWX2rS_P0a-H5UDZwUWiHD4Nj=upw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sebastian Haas <dev@sebastianhaas.info>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, =?ISO-8859-1?Q?Heinz-J=FCrgen_Oertel?= <hj.oertel@t-online.de>, Wolfgang Grandegger <wg@grandegger.com>

On 22.09.2013 08:39, Sebastian Haas wrote:
> Am 21.09.2013 20:17 schrieb "Oliver Hartkopp" <socketcan@hartkopp.net
> <mailto:socketcan@hartkopp.net>>:
>>
>> On 21.09.2013 19:09, Marc Kleine-Budde wrote:
>> > On 09/21/2013 06:37 PM, Sebastian Haas wrote:
>> >> As Oliver already pointed out there are a bunch of applications outside
>> >> which may require a can4linux-like chardev API.
>> >>
>> >> But I also agree that merging an additional CAN framework makes not
>> >> much sense. I prefer to port can4linux drivers to SocketCAN for not
>> >> yet supported devices. But we may also think about an emulation of
>> >> chardev based APIs like can4linux to support legacy applications.
>> >
>> > The emulation could probably be done in userspace. I'll ask our
>> > userspace graphics guys how they emulate legacy /dev/fbX on top of drm.
>> >
>>
>> Oh yes!
>>
>> If there would be a solution to handle all this within a user-space driver
>> this would be my favorite solution too.
> Just found CUSE made by Tejun. It is in mainline since 2.6.31. I'm going to
> implement a demo for this.

CUSE really looks promising for legacy CAN APIs!

With that idea every vendor(!) can implement an own CUSE driver to support
_their_ costumers to run legacy apps the customers are not able/willing to
port to native SocketCAN. And then vendor becomes the correct contact person
for his own CAN API and his own CUSE adapter too. A good separation!

I agree with Wolfgang that porting applications to Linux-CAN is the strongly
recommended way. Especially because of the simple SocketCAN API this should be
easy to do in the vast majority of cases.

And adding the few missing drivers (like the Xilinx) as a netdevice driver to
drivers/net/can should be no big deal at all. I assume Xilinx would also be
happy to have their hardware supported by the Linux mainline standard.

Best regards,
Oliver

ps. A prominent project which is using the CUSE concept is the 'OSS proxy'
which creates e.g. legacy /dev/dsp devices used by the Open Sound System.
OSS was the former sound system API standard in Linux 2.4.

https://fedoraproject.org/wiki/Features/OSSProxy
http://sourceforge.net/projects/osspd/


