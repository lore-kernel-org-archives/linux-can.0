From: "Sandro Anders | CarMedialab" <sandro.anders@carmedialab.com>
Subject: AW: AW: netlink error -95 (Operation not supported) with can-utils/cangw
Date: Tue, 4 Feb 2014 13:02:36 +0100
Message-ID: <18F8639CFC8C7C4D819AB347808079D4026C6A12@pluto.office.rac.de>
References: <18F8639CFC8C7C4D819AB347808079D4026C69FC@pluto.office.rac.de> <52F0D101.6050500@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.rac.de ([213.144.11.11]:46407 "EHLO mail.rac.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750937AbaBDMCn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Feb 2014 07:02:43 -0500
Content-class: urn:content-classes:message
In-Reply-To: <52F0D101.6050500@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

Hi Olli,

Hmm it wasn't clear to me that an additional module is necessary for us=
ing this feature. But anyway this explains the behaviour. Is there any =
documentation? I couldn't find anything about can-gw in the can.txt fil=
e.

Many thanks to you and best regards,
Sandro

> -----Urspr=FCngliche Nachricht-----
> Von: linux-can-owner@vger.kernel.org [mailto:linux-can-
> owner@vger.kernel.org] Im Auftrag von Oliver Hartkopp
> Gesendet: Dienstag, 4. Februar 2014 12:38
> An: Sandro Anders | CarMedialab; linux-can@vger.kernel.org
> Betreff: Re: AW: netlink error -95 (Operation not supported) with can=
-
> utils/cangw
>=20
> Hi Sandro,
>=20
> did you load the can-gw module?
>=20
> When can-gw is not loaded the netlink functions for cangw are not
> registered.
>=20
> Regards,
> Oliver
>=20
> On 04.02.2014 11:55, Sandro Anders | CarMedialab wrote:
> > Hi all,
> >
> > I was able to compile the can-utils/* apps without any errors and t=
he
> > most are working. But if I call the cangw command I get the followi=
ng
> > error message: cangw -A -s can1 -d can3
> > netlink error -95 (Operation not supported)
> >
> > Both CAN's are up and running. My assumption is that there is some
> > netlink support missing in my Kernel, isn't it? Thanks for your hel=
p.
> >
> > Sandro
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-can=
" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
