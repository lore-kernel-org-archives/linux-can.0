From: =?UTF-8?Q?Andrejus_Fal=C4=8Dikas?= <andrejus.f@8devices.com>
Subject: Re: Fwd: usb_8dev - WARN_ON(in_irq()) Ticket #00560
Date: Thu, 9 Apr 2020 16:00:09 +0300
Message-ID: <CAFnz-BWGWEVOmZL825otpjr+tiYaFm4M2Fm7SuyVPWb6BdxoQA@mail.gmail.com>
References: <CAFnz-BWK_c63YyZ2KzMq=EWn6yfEQyyX+Vo7WSh4SddyY7PCfQ@mail.gmail.com>
 <f17f8d95-96b4-4d51-4390-1fb6a1e47fc8@grandegger.com> <871rp4he0s.fsf@steelpick.2x.cz>
 <CAFnz-BUVcSwN6tFUS6W3Y9HUKsbf5am2x=BccSXzX-pRSh9G6w@mail.gmail.com>
 <44255c9f-9c22-7bbf-4426-34506bf8a2b0@grandegger.com> <CAFnz-BU1hKPzMyXqgYw82Nt-z2rw+BRNGLvU38BBm-h84d1ztA@mail.gmail.com>
 <fe34ce85-3cee-4623-5b20-194510f3d38c@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ed1-f50.google.com ([209.85.208.50]:35822 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgDINAV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 9 Apr 2020 09:00:21 -0400
Received: by mail-ed1-f50.google.com with SMTP id c7so13179503edl.2
        for <linux-can@vger.kernel.org>; Thu, 09 Apr 2020 06:00:20 -0700 (PDT)
In-Reply-To: <fe34ce85-3cee-4623-5b20-194510f3d38c@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Michal Sojka <michal.sojka@cvut.cz>, socketcan@hartkopp.net, linux-can@vger.kernel.org

Hello,
fix tested and committed to 8devices repository, a pending pull
request https://github.com/krumboeck/usb2can/pull/12 created..

Best regards,
Andrejus F

On Thu, Apr 9, 2020 at 1:43 PM Wolfgang Grandegger <wg@grandegger.com> wrot=
e:
>
> Hello Andrejus,
>
> thanks for testing. Can I have your
>
> Tested-by: Andrejus Fal=C4=8Dikas <andrejus.f@8devices.com> ?
>
> Wolfgang
>
> Am 09.04.20 um 12:37 schrieb Andrejus Fal=C4=8Dikas:
> > Hello,
> >
> > Thank you Mr. Wolfgang Grandegger for the patch. I checked and the
> > problem disappeared, any warnings do not appear in dmesg after the
> > "interface down".
> >
> > Best regards,
> > Andrejus F.
> >
> > On Thu, Apr 9, 2020 at 1:25 PM Wolfgang Grandegger <wg@grandegger.com> =
wrote:
> >>
> >>
> >> Am 09.04.20 um 08:46 schrieb Andrejus Fal=C4=8Dikas:
> >>> Hello,
> >>>
> >>> this Ticket #00560 is closed.
> >>
> >> Which does not mean that the problem is gone ;)
> >>
> >> Wolfgang
> >>
> >>> On Fri, Apr 3, 2020 at 4:53 PM Michal Sojka <michal.sojka@cvut.cz> wr=
ote:
> >>>>
> >>>> Hello Wolfgang,
> >>>>
> >>>> On Fri, Apr 03 2020, Wolfgang Grandegger wrote:
> >>>>> Hello Andrejus,
> >>>>>
> >>>>> please do not remove the history of this conversation! It's very
> >>>>> difficult to follow what you are speaking about...
> >>>>>
> >>>>> Am 03.04.20 um 15:04 schrieb Andrejus Fal=C4=8Dikas:
> >>>>>> Hello Mr. Oliver Hartkopp,
> >>>>>>
> >>>>>> I would like to notify you that the case described as the issue is
> >>>>>> caused by non-standard use of the device and protocol.
> >>>>
> >>>> [...]
> >>>>
> >>>>>
> >>>>> I observe a similar problem with the GS_USB CAN controller and I ha=
ve
> >>>>> posted a patch recently here:
> >>>>>
> >>>>>   https://marc.info/?l=3Dlinux-can&m=3D158504888512764&w=3D2
> >>>>>
> >>>>> Could you please give the patch for your device below a try:
> >>>>
> >>>> It would be great if Andrejus can try the patch. If not, I'll try it
> >>>> after I get back to work where I have the device. Unfortunately, due=
 to
> >>>> current situation, I'm not sure when it will happen.
> >>>>
> >>>> Thanks.
> >>>> -Michal
> >>>
> >>>
> >
> >
