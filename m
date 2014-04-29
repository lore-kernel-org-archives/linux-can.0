From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: am335x: d_can: rx issue
Date: Tue, 29 Apr 2014 09:30:03 +0200
Message-ID: <CAGm1_ks=xU3tomPy+YhFtACqsbPLSP6D-hocC=pkhdtA5L_cQQ@mail.gmail.com>
References: <CAGm1_ktbB6SOGd5PygOrh4FOZU1fofAK4omAur-VHeo1Tw9tJQ@mail.gmail.com>
 <alpine.DEB.2.02.1404281510170.6261@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:59953 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932678AbaD2HaY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 29 Apr 2014 03:30:24 -0400
Received: by mail-pb0-f48.google.com with SMTP id md12so6820338pbc.35
        for <linux-can@vger.kernel.org>; Tue, 29 Apr 2014 00:30:23 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1404281510170.6261@ionos.tec.linutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>

On Mon, Apr 28, 2014 at 4:37 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Mon, 28 Apr 2014, Yegor Yefremov wrote:
>> I'm testing 3.15.0-rc3-00006-gd497c20-dirty with latest commit:
>>
>> Merge tag 'linux-can-fixes-for-3.15-20140401' of
>> git://gitorious.org/linux-can/linux-can
>>
>>     linux-can-fixes-for-3.15-20140401
>>
>>     Marc Kleine-Budde says:
>>
>>     ====================
>>     this is a pull request of 16 patches for the 3.15 release cycle.
>>
>>     Bjorn Van Tilt contributes a patch which fixes a memory leak in usb_8dev's
>>     usb_8dev_start_xmit()s error path. A patch by Robert Schwebel
>> fixes a typo in
>>     the can documentation. The remaining patches all target the c_can
>> driver. Two
>>     of them are by me; they add a missing netif_napi_del() and return value
>>     checking. Thomas Gleixner contributes 12 patches, which address several
>>     shortcomings in the driver like hardware initialisation,
>> concurrency, message
>>     ordering and poor performance.
>>     ====================
>>
>> TX is working, but rx not. Am I missing any patches, that fix this issue?
>
> I bet, TX is not working either. You probably fall over the issue with
> the startup logic.
>
> Does the following patch fix your issue?
>
>     http://patchwork.ozlabs.org/patch/342518/

Yes, it does.

Thanks.

Are these patches going to hit 3.15-rc4?

Yegor
