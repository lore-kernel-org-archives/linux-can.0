From: Nimai Mahajan <nimaim@gmail.com>
Subject: Re: j1939 for linux 3.12 problem
Date: Mon, 26 May 2014 09:28:53 -0400
Message-ID: <CALoSW67Gtiz5yae-NFEh1yB6A0DbogNX27e3FXTK8ReYW0+x9g@mail.gmail.com>
References: <CALoSW66s1aWz6g=RRLebh_Le6j7Br1Phet_tuisC2oWbGwQzJA@mail.gmail.com>
 <CALoSW65MXVzugeZVyi7q1znDWgbxxLiUE-apUcgSLRU+XmN9Bw@mail.gmail.com>
 <20140525181834.GB1055@vandijck-laurijssen.be> <20140526080733.GB479@vandijck-laurijssen.be>
 <CALoSW669EExgOkXAHGTOMBLvCpCuNpX7PH9bR686kwafjcHwXQ@mail.gmail.com>
 <CALoSW65_Q9if9ZRo69e+q2CHFkN=d4_izDCNyZWOz0DFrGF3Cw@mail.gmail.com>
 <CALoSW66YyTb0uOjKhTLftM6ycMT-zw79SYKkZ-zwVCH550kXsA@mail.gmail.com> <20140526130355.GC479@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-yh0-f44.google.com ([209.85.213.44]:59328 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbaEZN3O (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 May 2014 09:29:14 -0400
Received: by mail-yh0-f44.google.com with SMTP id b6so6402426yha.3
        for <linux-can@vger.kernel.org>; Mon, 26 May 2014 06:29:13 -0700 (PDT)
In-Reply-To: <20140526130355.GC479@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org, dev.kurt@vandijck-laurijssen.be

Kurt,

Had some time to play around with this at home and ... success! Pulled
down the linux-stable git repo, checked out the 3.12.20 tag, merged in
your 3.12-rc1 linux-j1939 changes, did a make menuconfig to enable SAE
J1939 and CAN support, and it now builds successfully. Another
request: before I start testing this, is it possible for you to update
the iproute2 (https://www.kernel.org/pub/linux/utils/net/iproute2/
3.14.0 is the latest and very recently updated) and can-utils
(git://gitorious.org/linux-can/can-utils.git which has changes as
recent as 5/24) packages to the latest with your J1939 changes as
well? Merging fails for me if I grab these latest packages and try to
merge in your changes, probably because what you are using as the base
are very old versions. That would be a great start into merging this
into mainline I would think and would make for a better test since
3.12.x is rather new and probably relies on newer packages.

I do not actually have the hardware in yet to really test out the
J1939 stuff, but I figured it'd be nice to get something to build
until then to play around with. I am still new when it comes to CAN
but trying to learn it reading all your documentation.

Thanks,
Nimai

On Mon, May 26, 2014 at 9:03 AM, Kurt Van Dijck
<dev.kurt@vandijck-laurijssen.be> wrote:
> On Mon, May 26, 2014 at 08:37:40AM -0400, Nimai Mahajan wrote:
>> Nevermind I think the vger.linux.org is just rejecting HTML emails ...
>> resending in plain text. This is just a test ...
>
> A successfull test, I might say.
