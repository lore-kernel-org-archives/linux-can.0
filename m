From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: J1939 questions
Date: Wed, 5 Jun 2013 20:01:07 +0200
Message-ID: <20130605180107.GA755@vandijck-laurijssen.be>
References: <CAFu8-3CDw3Ab=fwseBfseazR0j-8qGrx6c1Nz0iXBYaJ-FW6wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay010.isp.belgacom.be ([195.238.6.177]:14090 "EHLO
	mailrelay010.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757057Ab3FESBX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 5 Jun 2013 14:01:23 -0400
Content-Disposition: inline
In-Reply-To: <CAFu8-3CDw3Ab=fwseBfseazR0j-8qGrx6c1Nz0iXBYaJ-FW6wA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Billy Muma <billymuma@3d-p.com>
Cc: linux-can@vger.kernel.org

Hi,

Thanks for your interest in j1939 on linux-can.

I replied with linux-can mailing list in CC. This is the main resource
for linux-can related development.

>   =E2=80=A2 The nature of the hardware for which the solution is bein=
g implemented.
>       =E2=96=A1 How is CAN implemented on your test board.  Is it SJA=
1000 based?
>       =E2=96=A1 What bus is used to interface the CAN hardware
We have an Isobus certified hardware board with an SJA1000 chip.
But I've also ran this on my host computer using a Softing Gmbh PCMCIA =
card,
as well as ESD (USB2) and later on PEAK.
Any linux-can supported controller with echo support will work.

>   =E2=80=A2 Would you be interested in porting the solution for a 3.4=
 kernel.
I've built some branches based on the past requirements.
If you're using git, you could easily merge j1939-v3.3 branch into your=
 3.4 kernel
by doing in git working directory:

	$ git remote add j1939 git://gitorious.org/~kurt-vd/linux-can/linux-ca=
n-j1939.git
	$ git remote update j1939
	$ git merge j1939/j1939-v3.3

I do not foresee any problems with this.
If you do not feel comfortable, I could create a j1939-v3.4 branch as w=
ell.

Kind regards,
Kurt

On Tue, Jun 04, 2013 at 04:34:01PM -0600, Billy Muma wrote:
> Hi Kurt,
>=20
> I was looking for J1939 solutions for linux when I came across the fo=
llowing
> wiki page.
>=20
> http://elinux.org/J1939
>=20
> I'm curious about the following, I was hoping you could share:
>=20
>   =E2=80=A2 The nature of the hardware for which the solution is bein=
g implemented.
>       =E2=96=A1 How is CAN implemented on your test board.  Is it SJA=
1000 based?
>       =E2=96=A1 What bus is used to interface the CAN hardware
>   =E2=80=A2 Would you be interested in porting the solution for a 3.4=
 kernel.
[...]
>=20
> Hope to hear from you.
>=20
> Cheers.
>=20
