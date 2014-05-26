From: Nimai Mahajan <nimaim@gmail.com>
Subject: Re: j1939 for linux 3.12 problem
Date: Mon, 26 May 2014 16:14:45 -0400
Message-ID: <CALoSW66m0w4m=J1xRJhTpwei310GRJD+JBMxWuqK4aKZTzWBhw@mail.gmail.com>
References: <CALoSW66s1aWz6g=RRLebh_Le6j7Br1Phet_tuisC2oWbGwQzJA@mail.gmail.com>
 <CALoSW65MXVzugeZVyi7q1znDWgbxxLiUE-apUcgSLRU+XmN9Bw@mail.gmail.com>
 <20140525181834.GB1055@vandijck-laurijssen.be> <20140526080733.GB479@vandijck-laurijssen.be>
 <CALoSW669EExgOkXAHGTOMBLvCpCuNpX7PH9bR686kwafjcHwXQ@mail.gmail.com>
 <CALoSW65_Q9if9ZRo69e+q2CHFkN=d4_izDCNyZWOz0DFrGF3Cw@mail.gmail.com>
 <CALoSW66YyTb0uOjKhTLftM6ycMT-zw79SYKkZ-zwVCH550kXsA@mail.gmail.com>
 <20140526130355.GC479@vandijck-laurijssen.be> <CALoSW67Gtiz5yae-NFEh1yB6A0DbogNX27e3FXTK8ReYW0+x9g@mail.gmail.com>
 <20140526183440.GC14242@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:57045 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbaEZUPH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 May 2014 16:15:07 -0400
Received: by mail-yk0-f182.google.com with SMTP id 9so6353558ykp.41
        for <linux-can@vger.kernel.org>; Mon, 26 May 2014 13:15:05 -0700 (PDT)
In-Reply-To: <20140526183440.GC14242@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org, dev.kurt@vandijck-laurijssen.be

Thanks Kurt, I guess I just like to be up to date with all the "new
features" as you say, but also since I know they've squashed some more
of the bugs out with recent versions. Only reason I suggested using
newer packages as a base is just to be consistent with their
development cycles (iproute2 may not have another update for another
year now and it seems can-utils fixes things on a daily basis so would
be nice to have something more recent because J1939 merges never work
otherwise). Anyway, it's no problem and I will simply use what's
already there. It'll be a little work integrating all this and
cross-compiling it for our Buildroot application (our stuff runs on a
very small, stripped down buildroot-based embedded Linux OS) so that
will be the next step. Funny you say you're not so deep into Ethernet,
because I am, or at least try to be :-) I have to regularly write
TCP/IP and UDP servers/clients, some wrapped around OpenSSL and
whatnot, but we develop a lot of Ethernet based communication at work.

I heard about vcan and always build it into the kernel when I compile
it. That is the best way to test out the iproute2 package (adding a
vcan node) and can-utils (by using candump to read/write some
messages). I will have to use it to get familiar with J1939. From my
understanding, it is mainly a layer on top of CAN_RAW correct? So
technically you can implement all the J1939 stuff in BSD style with
CAN_RAW, but seems you've done most of the work wrapping them into
J1939 messages out of the box. Is that a correct assumption? I am
still trying to learn all of this.

Thanks again Kurt, over time I will test this update out and make sure
it doesn't break anything.

On Mon, May 26, 2014 at 2:34 PM, Kurt Van Dijck
<dev.kurt@vandijck-laurijssen.be> wrote:
> Hey Nimai,
>
> On Mon, May 26, 2014 at 09:28:53AM -0400, Nimai Mahajan wrote:
>> Kurt,
>>
>> Had some time to play around with this at home and ... success! Pulled
>> down the linux-stable git repo, checked out the 3.12.20 tag, merged in
>> your 3.12-rc1 linux-j1939 changes, did a make menuconfig to enable SAE
>> J1939 and CAN support, and it now builds successfully.
>
> Great!
>
>> Another
>> request: before I start testing this, is it possible for you to update
>> the iproute2 (https://www.kernel.org/pub/linux/utils/net/iproute2/
>> 3.14.0 is the latest and very recently updated) and can-utils
>> (git://gitorious.org/linux-can/can-utils.git which has changes as
>> recent as 5/24) packages to the latest with your J1939 changes as
>> well? Merging fails for me if I grab these latest packages and try to
>> merge in your changes, probably because what you are using as the base
>> are very old versions. That would be a great start into merging this
>> into mainline I would think and would make for a better test since
>> 3.12.x is rather new and probably relies on newer packages.
>
> Well, 3.12.x or any recent version does not really rely on
> newer iproute or can-utils packages. You would need newer versions
> of those only when you use newer features.
> For CAN, an example of such new feature is the CANFD support.
> For ethernet, which is addressed by iproute, I don't know the new features,
> mainly because I'm not so deep into ethernet.
> So, with regard to j1939, the latest j1939 branch of iproute & can-utils
> will still be convenient for more recent kernels.
> The magic here is that API's should stay backward compatible.
>
>>
>> I do not actually have the hardware in yet to really test out the
>> J1939 stuff, but I figured it'd be nice to get something to build
>> until then to play around with. I am still new when it comes to CAN
>> but trying to learn it reading all your documentation.
>
> vcan is your friend when hardware has gone.
>
>         $ modprobe vcan
>         $ ip link add vcan0 type vcan
>
> And off you go. It's not like real hardware, but you can simulate pretty
> much.
>
> Kind regards,
> Kurt
