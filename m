From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: slcan2d
Date: Fri, 12 Jul 2013 08:19:02 +0200
Message-ID: <CAGm1_kuJD12E-rFncFtrh+yVxuTEnhCKAX_g65-pMaonpvFDGw@mail.gmail.com>
References: <CAGm1_kt9Pd_JjfBJSWMHMJaq3eyKE2LpBjk5323Waksz1vQYPg@mail.gmail.com>
 <51DE7B35.90807@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bk0-f54.google.com ([209.85.214.54]:43566 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660Ab3GLGTX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 12 Jul 2013 02:19:23 -0400
Received: by mail-bk0-f54.google.com with SMTP id it16so3661277bkc.13
        for <linux-can@vger.kernel.org>; Thu, 11 Jul 2013 23:19:22 -0700 (PDT)
In-Reply-To: <51DE7B35.90807@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Thu, Jul 11, 2013 at 11:30 AM, Marc Kleine-Budde <mkl@pengutronix.de=
> wrote:
> On 07/11/2013 10:38 AM, Yegor Yefremov wrote:
>> Trying to commit slcan2d.c
>> (https://github.com/yegorich/can-utils/commits/slcan2d) and my git
>> 1.7.7 renames slcand.c because it looks quite similar. How can I
>> prevent this? So far I found no option for git commit command.
>
> Do you mean commit "90c9b2f slcan2d: add new slcan daemon"? git doesn=
't
> rename Files if you don't tell git to do so. However git may optimize
> and treat your new slcan2d as a copy+modifications of slcand.
>
> If I check out commit 90c9b2f, there is slcand.c and slcan2d.c:
>
>> =E2=9E=9C (pts/25) frogger@hardanger:gitorious/can-utils (master) gi=
t checkout 90c9b2fcf644b9c5924983114f951b334039f665
>> Note: checking out '90c9b2fcf644b9c5924983114f951b334039f665'.
> [...]
>> HEAD is now at 90c9b2f... slcan2d: add new slcan daemon
>> =E2=9E=9C (pts/25) frogger@hardanger:gitorious/can-utils ((90c9b2f..=
=2E)) ll slcan*d.c
>> -rwxr-xr-x 1 frogger frogger 12022 Jul 11 11:27 slcan2d.c
>> -rw-r--r-- 1 frogger frogger  7777 Feb 12 17:57 slcand.c

ACK It was just misunderstanding. I still have both files too.

> You probably want to remove the executable bit from your slcan2d.c :)=
 So
> far everything looks good.

=46ixed.

Yegor
