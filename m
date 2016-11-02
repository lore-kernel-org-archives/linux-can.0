From: =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?=
        <remigiusz.kollataj@mobica.com>
Subject: Re: Adding new CAN driver
Date: Wed, 2 Nov 2016 08:23:48 +0100
Message-ID: <CAKT-o-d_tLkZgAuJz7rrRaDPxmi3hDiLmVhLcpjNBc1weDLvyg@mail.gmail.com>
References: <CAKT-o-cOb0sqRmvH+BKjX4yvBLp5_GqVd6=ifr2jm5T75-hcZA@mail.gmail.com>
 <c8ba150c-11d2-176c-f3b7-936d89f54de2@hartkopp.net> <CAKT-o-cDp0vUY12=Tyv909QC-ZcGpxFKxzSAuf0mrzAojS38Jw@mail.gmail.com>
 <ce34a9f7-d310-00aa-6d53-ad08b45cfa3f@hartkopp.net> <CAKT-o-cZryPfqkU2rOPu1SdEp8imkTke_NzVgwgghOY6RxrZmg@mail.gmail.com>
 <22552.25820.453841.413376@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ua0-f178.google.com ([209.85.217.178]:33562 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751625AbcKBHYK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Nov 2016 03:24:10 -0400
Received: by mail-ua0-f178.google.com with SMTP id 20so5781366uak.0
        for <linux-can@vger.kernel.org>; Wed, 02 Nov 2016 00:24:09 -0700 (PDT)
In-Reply-To: <22552.25820.453841.413376@gargle.gargle.HOWL>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
Cc: linux-can@vger.kernel.org

Hi Uwe,

Not sure if you are asking about termination or about the driver
itself, so let me give two answers.

I'll try to send the patch till end of this week. In the meantime you
may still use the driver from the github repository
(https://github.com/rkollataj/mcba_usb). I am keeping it up to date.

I didn't get a chance to work on adding support for termination to
"ip". Before investing any effort I would prefer to get confirmation
from Oliver of Marc that the direction is right. Anyway setting up
termination via sysfs works just fine. It is described in readme file
in repository.

Regards,
Remik


On 1 November 2016 at 10:48, Uwe Bonnes
<bon@elektron.ikp.physik.tu-darmstadt.de> wrote:
>>>>>> "Ko=C5=82=C5=82=C4=85taj," =3D=3D Ko=C5=82=C5=82=C4=85taj, Remigiusz=
 <remigiusz.kollataj@mobica.com> writes:
>
>     Ko=C5=82=C5=82=C4=85taj,> If you will find this feature reasonable en=
ough I could
>     Ko=C5=82=C5=82=C4=85taj,> probably spend some effort to work on it.
>
> Any news on adding the Microchip CAN driver?
>
> Thanks
> --
> Uwe Bonnes                bon@elektron.ikp.physik.tu-darmstadt.de
>
> Institut fuer Kernphysik  Schlossgartenstrasse 9  64289 Darmstadt
> --------- Tel. 06151 1623569 ------- Fax. 06151 1623305 ---------



--=20
________________________

Remigiusz Ko=C5=82=C5=82=C4=85taj

Mobica Ltd

Software Consultant, CTO Team

Tel:  +48 91 881 95 18

Skype: remigiusz.kollataj

www.mobica.com


Mobica is a provider of software engineering, testing and consultancy
services based in the UK, Poland and the USA, with a worldwide
customer base. We have a proven track record in delivering innovative
solutions to some of the world=E2=80=99s best-known companies in a range of
sectors including Automotive, Mobile, Semiconductor, Finance, TV,
Marine and Aviation.
