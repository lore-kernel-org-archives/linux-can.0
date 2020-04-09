From: =?UTF-8?Q?Andrejus_Fal=C4=8Dikas?= <andrejus.f@8devices.com>
Subject: Re: Fwd: usb_8dev - WARN_ON(in_irq()) Ticket #00560
Date: Thu, 9 Apr 2020 09:46:48 +0300
Message-ID: <CAFnz-BUVcSwN6tFUS6W3Y9HUKsbf5am2x=BccSXzX-pRSh9G6w@mail.gmail.com>
References: <CAFnz-BWK_c63YyZ2KzMq=EWn6yfEQyyX+Vo7WSh4SddyY7PCfQ@mail.gmail.com>
 <f17f8d95-96b4-4d51-4390-1fb6a1e47fc8@grandegger.com> <871rp4he0s.fsf@steelpick.2x.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ed1-f51.google.com ([209.85.208.51]:40017 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgDIGrD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 9 Apr 2020 02:47:03 -0400
Received: by mail-ed1-f51.google.com with SMTP id w26so11962874edu.7
        for <linux-can@vger.kernel.org>; Wed, 08 Apr 2020 23:47:02 -0700 (PDT)
In-Reply-To: <871rp4he0s.fsf@steelpick.2x.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michal Sojka <michal.sojka@cvut.cz>
Cc: Wolfgang Grandegger <wg@grandegger.com>, socketcan@hartkopp.net, linux-can@vger.kernel.org

Hello,

this Ticket #00560 is closed.

Best regards,
Andrejus F.

On Fri, Apr 3, 2020 at 4:53 PM Michal Sojka <michal.sojka@cvut.cz> wrote:
>
> Hello Wolfgang,
>
> On Fri, Apr 03 2020, Wolfgang Grandegger wrote:
> > Hello Andrejus,
> >
> > please do not remove the history of this conversation! It's very
> > difficult to follow what you are speaking about...
> >
> > Am 03.04.20 um 15:04 schrieb Andrejus Fal=C4=8Dikas:
> >> Hello Mr. Oliver Hartkopp,
> >>
> >> I would like to notify you that the case described as the issue is
> >> caused by non-standard use of the device and protocol.
>
> [...]
>
> >
> > I observe a similar problem with the GS_USB CAN controller and I have
> > posted a patch recently here:
> >
> >   https://marc.info/?l=3Dlinux-can&m=3D158504888512764&w=3D2
> >
> > Could you please give the patch for your device below a try:
>
> It would be great if Andrejus can try the patch. If not, I'll try it
> after I get back to work where I have the device. Unfortunately, due to
> current situation, I'm not sure when it will happen.
>
> Thanks.
> -Michal
