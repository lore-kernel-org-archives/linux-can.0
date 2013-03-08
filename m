From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: Informations About CAN API of the Linux Kernel
Date: Fri, 8 Mar 2013 14:27:18 +0100
Message-ID: <CAGm1_kuBZGMxQ2m97fE8EimDKj-exy7Xto2TVEgbqv8Ns4R-JA@mail.gmail.com>
References: <2B7D120CFC15DC438D721B998AD9D9E9097105AB@SEGOTNC5180-N2.vcn.ds.volvo.net>
 <513763CC.1070507@pengutronix.de> <20130307124012.GC603@vandijck-laurijssen.be>
 <5139A78D.9060005@pengutronix.de> <20130308100548.GA496@vandijck-laurijssen.be>
 <5139D3D8.2020305@volkswagen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:48707 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932120Ab3CHN1j (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 8 Mar 2013 08:27:39 -0500
Received: by mail-bk0-f46.google.com with SMTP id j5so699356bkw.33
        for <linux-can@vger.kernel.org>; Fri, 08 Mar 2013 05:27:38 -0800 (PST)
In-Reply-To: <5139D3D8.2020305@volkswagen.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Kurt Van Dijck <kurt.van.dijck@eia.be>, Sako Youssouf <youssouf.sako@renault-trucks.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Fri, Mar 8, 2013 at 1:04 PM, Oliver Hartkopp
<oliver.hartkopp@volkswagen.de> wrote:
> Am 08.03.2013 11:05, schrieb Kurt Van Dijck:
>
>
>>>> The J1939 API that is available on gitorious[1] is waiting for
>>>> acceptance.
>>>> The API has not changed for almost a year now, and is working.
>>>> The J1939 API is quite different from raw CAN, since J1939 adds an
>>>> addressing scheme. This makes it hard for non-J1939 users to
>>>> judge about the usefullness of the API.
>
>
> Yes. Unfortunately.
>
>
>>>> Therefore, it's important that users of the J1939 stack share their
>>>> opinion about it.
>>>> Therefore, also your opinion matters and may contribute to the
>>>> acceptance.
>>>> If you find the J1939 stack usefull of course :-)
>
>
> Indeed user feedback is really required.
>
>
>>>
>>> Would it be possible to add the j1939 support to staging? I mean from
>>> the technical and from the political (is staging reserved for drivers
>>> only?) point of view.
>>
>>
>> That is a good idea.
>> Technically, staging is underneath drivers/, which answers the political
>> question: yes, it's for drivers probably.
>
>
> Please check:
>
> http://www.kroah.com/log/linux/linux-staging-update.html
>
> It's for "drivers" and "filesystems".
>
> You don't need to modify the kernel infrastructure to add drivers and
> filesystems - but you need to change infrastructure to add new networking
> functionalities.
>
> Therefore i don't think, that this would work with the staging approach.
>
> Btw. how can we gain more interest and users to the evaluation of Kurts
> j1939
> stack?

What about creating a small k1939 howto here http://elinux.org/CAN_Bus
Then we could at least try G+ channel to get attention. There are many
automation engineers.

Yegor
