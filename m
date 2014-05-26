From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: j1939 for linux 3.12 problem
Date: Mon, 26 May 2014 20:34:40 +0200
Message-ID: <20140526183440.GC14242@vandijck-laurijssen.be>
References: <CALoSW66s1aWz6g=RRLebh_Le6j7Br1Phet_tuisC2oWbGwQzJA@mail.gmail.com>
 <CALoSW65MXVzugeZVyi7q1znDWgbxxLiUE-apUcgSLRU+XmN9Bw@mail.gmail.com>
 <20140525181834.GB1055@vandijck-laurijssen.be>
 <20140526080733.GB479@vandijck-laurijssen.be>
 <CALoSW669EExgOkXAHGTOMBLvCpCuNpX7PH9bR686kwafjcHwXQ@mail.gmail.com>
 <CALoSW65_Q9if9ZRo69e+q2CHFkN=d4_izDCNyZWOz0DFrGF3Cw@mail.gmail.com>
 <CALoSW66YyTb0uOjKhTLftM6ycMT-zw79SYKkZ-zwVCH550kXsA@mail.gmail.com>
 <20140526130355.GC479@vandijck-laurijssen.be>
 <CALoSW67Gtiz5yae-NFEh1yB6A0DbogNX27e3FXTK8ReYW0+x9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay003.isp.belgacom.be ([195.238.6.53]:3046 "EHLO
	mailrelay003.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751603AbaEZSet (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 May 2014 14:34:49 -0400
Content-Disposition: inline
In-Reply-To: <CALoSW67Gtiz5yae-NFEh1yB6A0DbogNX27e3FXTK8ReYW0+x9g@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Nimai Mahajan <nimaim@gmail.com>
Cc: linux-can@vger.kernel.org

Hey Nimai,

On Mon, May 26, 2014 at 09:28:53AM -0400, Nimai Mahajan wrote:
> Kurt,
> 
> Had some time to play around with this at home and ... success! Pulled
> down the linux-stable git repo, checked out the 3.12.20 tag, merged in
> your 3.12-rc1 linux-j1939 changes, did a make menuconfig to enable SAE
> J1939 and CAN support, and it now builds successfully.

Great!

> Another
> request: before I start testing this, is it possible for you to update
> the iproute2 (https://www.kernel.org/pub/linux/utils/net/iproute2/
> 3.14.0 is the latest and very recently updated) and can-utils
> (git://gitorious.org/linux-can/can-utils.git which has changes as
> recent as 5/24) packages to the latest with your J1939 changes as
> well? Merging fails for me if I grab these latest packages and try to
> merge in your changes, probably because what you are using as the base
> are very old versions. That would be a great start into merging this
> into mainline I would think and would make for a better test since
> 3.12.x is rather new and probably relies on newer packages.

Well, 3.12.x or any recent version does not really rely on
newer iproute or can-utils packages. You would need newer versions
of those only when you use newer features.
For CAN, an example of such new feature is the CANFD support.
For ethernet, which is addressed by iproute, I don't know the new features,
mainly because I'm not so deep into ethernet.
So, with regard to j1939, the latest j1939 branch of iproute & can-utils
will still be convenient for more recent kernels.
The magic here is that API's should stay backward compatible.

> 
> I do not actually have the hardware in yet to really test out the
> J1939 stuff, but I figured it'd be nice to get something to build
> until then to play around with. I am still new when it comes to CAN
> but trying to learn it reading all your documentation.

vcan is your friend when hardware has gone.

	$ modprobe vcan
	$ ip link add vcan0 type vcan

And off you go. It's not like real hardware, but you can simulate pretty
much.

Kind regards,
Kurt
