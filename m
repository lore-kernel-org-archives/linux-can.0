From: Hubert Denkmair <xor@xor.wtf>
Subject: Generic USB driver for small hardware projects?
Date: Mon, 4 Apr 2016 22:08:41 +0200
Message-ID: <5702C9C9.3050706@xor.wtf>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.xor.wtf ([46.38.236.187]:51462 "EHLO mail.xor.wtf"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932459AbcDDUoh (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 4 Apr 2016 16:44:37 -0400
Received: from p200300625f215700625718fffe9e6443.dip0.t-ipconnect.de ([2003:62:5f21:5700:6257:18ff:fe9e:6443])
	by mail.xor.wtf with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.84_2)
	(envelope-from <xor@xor.wtf>)
	id 1anAng-0005YY-6W
	for linux-can@vger.kernel.org; Mon, 04 Apr 2016 22:08:40 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi all,

I'm new to this list, so please excuse if my topic has been discussed
before. I didn't find anything like it in the recent archives, though...

I'm currently building - as others did before me - a small, cheap, open
hardware USB-CAN-Converter.

Now I have the same problem as everyone before me - how to get socketcan
support for it.

Of course, I can make a ACM device and implement the slcan protocol.
Which is, imho, a ugly hack and, besides needing a userspace daemon,
seems to have some shortcomings (e.g. not supporting the netlink config
interface, only a few supported bitrates...).

I'd much rather like to build a native socketcan usb driver for my
hardware. As this seems to be overkill for a small project like mine,
I'd propose to do something better:

Why not build a usb driver with a generic interface that all hardware
projects can implement if they want native socketcan support?

Though, before starting something like that, I'd like to know how you
think about it. Can I expect some support from the list?
Is there a existing usb driver to start from?
Do you think there is a chance to get such a driver into mainline kernel
in the near future?

If there is some interest, I'd like to discuss on the list how such a
interface should look like; E.g. provide all socketcan features, in a
way so that it's both easy to implement in firmware and the linux
driver, while making it possible for the hardware to also support other
protocols, e.g. the slcan interface.

Please let me know what you think of my proposal,

Cheers

Hubert
