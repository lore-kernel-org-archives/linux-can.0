From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: can-utils: usage with kernels prior to 3.6
Date: Fri, 1 Feb 2013 14:33:17 +0100
Message-ID: <CAGm1_ktQKcCd29xP2NMwhkt+pAL2vwBem76S_Ai1UMvyNfQdfw@mail.gmail.com>
References: <CAGm1_kvzT8e7_7JNt6NUyHUccpFb0c9v8XP3RStOWw6uKhObtA@mail.gmail.com>
 <510BB1C6.40000@volkswagen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:40816 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754063Ab3BANdj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 1 Feb 2013 08:33:39 -0500
Received: by mail-bk0-f43.google.com with SMTP id jm19so1820598bkc.16
        for <linux-can@vger.kernel.org>; Fri, 01 Feb 2013 05:33:38 -0800 (PST)
In-Reply-To: <510BB1C6.40000@volkswagen.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
Cc: linux-can@vger.kernel.org

On Fri, Feb 1, 2013 at 1:15 PM, Oliver Hartkopp
<oliver.hartkopp@volkswagen.de> wrote:
> Am 01.02.2013 08:30, schrieb Yegor Yefremov:
>> I've looked at the source code of the latest can-utils and it seems
>> like one cannot use them with the kernels prior to 3.6 because of
>> missing CAN FD support. The "struct can_frame" was replaced with the
>> new one, so that candump, cangen etc. are using only the CAN FD frame
>> structure.
>>
>> Am I missing something?
>
> Hello Yegor,
>
> of course the tools can be used with older kernels too.
>
> The struct canfd_frame is capable to contain a CAN frames as well as a CAN FD
> frame. Therefore e.g. candump internally uses struct canfd_famres to handle
> both frame types in the same manner.
>
> The idea and a visualisation can be found here:
>
> http://can-newsletter.org/engineering/standardization/nr_stand_can-fd_linux3.6_120703/
>
> Does this answer your question?

Yes, it does. Thanks for explanation.

Yegor
