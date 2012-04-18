From: Michael Economides <mecono@gmail.com>
Subject: Re: read() question from newbie
Date: Wed, 18 Apr 2012 14:21:24 -0700
Message-ID: <CABHoAvk1ZxEPbMbF9P50n3K4ONescW1-D0jCHzpV7EEXFgMxLQ@mail.gmail.com>
References: <CABHoAvngDnUfh6w7NXQksrmeLq52_cRp809rFZ+HriwYpZqo9w@mail.gmail.com>
	<CABHoAvmTvVfVKfwiZdf_=htKHYa554wpcPCRoEFujqwnxp9tkg@mail.gmail.com>
	<4F51DEF0.9060501@hartkopp.net>
	<CABHoAvmiu2JY70zJ8K20n8b=ahCDe8owRRWaSLMJoTd36ub7iw@mail.gmail.com>
	<4F553BDA.8060106@hartkopp.net>
	<4F553CA5.8080704@hartkopp.net>
	<CABHoAv=WuK0WZWNyi7jgBTNUbHub8AuGtPzbjL4dYaQ1ZGpu_g@mail.gmail.com>
	<4F56701E.3020104@hartkopp.net>
	<CABHoAv=FhULnAY+a2CbNjdyEEOoBKdEAezL7NQLo+PdfeyRTow@mail.gmail.com>
	<4F8D08D2.3090701@hartkopp.net>
	<CABHoAvmwCbAUfNBocHiUOHypN1uHMi9BrSREG-Yt=K=i3Wfn_w@mail.gmail.com>
	<4F8F2B14.7060207@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:42024 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311Ab2DRVVZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 18 Apr 2012 17:21:25 -0400
Received: by qcro28 with SMTP id o28so4811282qcr.19
        for <linux-can@vger.kernel.org>; Wed, 18 Apr 2012 14:21:24 -0700 (PDT)
In-Reply-To: <4F8F2B14.7060207@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

On Wed, Apr 18, 2012 at 1:59 PM, Marc Kleine-Budde <mkl@pengutronix.de>=
 wrote:
> On 04/18/2012 10:13 PM, Michael Economides wrote:
>> Hi Oliver,
>>
>> Looking on my scope, it does seem like the baudrate is a little off.
>>
>> Here are the commands I use to set up my CAN interface on my Linux b=
oard:
>>
>> insmod -m candev;
>> insmod -m mscan-mpc52xx;
>> insmod -m can;
>> insmod -m can-raw
>> ifconfig can0 up;
>
> With mainline it's not possible to ifup an interface without setting =
the
> bitrate first.
>
>> ./cantest can0 baud 1000000;
>>
>> This "cantest" program uses:
>>
>> =A0ifr.ifr_ifru.ifru_ivalue =3D baudrate;
>> ret =3D ioctl(s, SIOCSCANBAUDRATE, &ifr);
>>
>> to set the baudrate. =A0But it seems from reading other discussions,
>> that this is not the correct way to set baud rate.
>
> This ioctl isn't supported anymore, as Wolfgang pointed out you're
> probably not using a mainline socketcan.
>
>> I am using the MPC5121 from Freescale, in case that is relevant.
>
> Marc
>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| Marc Kleine-Bud=
de =A0 =A0 =A0 =A0 =A0 |
> Industrial Linux Solutions =A0 =A0 =A0 =A0| Phone: +49-231-2826-924 =A0=
 =A0 |
> Vertretung West/Dortmund =A0 =A0 =A0 =A0 =A0| Fax: =A0 +49-5121-20691=
7-5555 |
> Amtsgericht Hildesheim, HRA 2686 =A0| http://www.pengutronix.de =A0 |

Ok thanks Marc.

I'm using Linux BSP for Freescale MPC5121EADS.  It is quite old
(2009/06/02).  It was designed for the Freescale ADS5121 evaluation
board.  The board I'm using is similar.

I suppose the task now is to update this BSP with the latest socketCAN =
stuff?

-Mike
