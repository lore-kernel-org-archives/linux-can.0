From: Wolfgang <wutz@unterderbruecke.de>
Subject: Re: using j1939: userspace binaries
Date: Thu, 8 Dec 2011 14:27:23 +0000 (UTC)
Message-ID: <loom.20111208T150123-262@post.gmane.org>
References: <20111206104432.91170@gmx.net> <20111206121403.GB322@e-circ.dyndns.org> <loom.20111206T131950-88@post.gmane.org> <20111206131815.GD322@e-circ.dyndns.org> <loom.20111207T093827-478@post.gmane.org> <20111207143333.GD373@e-circ.dyndns.org> <20111207145032.GE373@e-circ.dyndns.org> <loom.20111208T120006-91@post.gmane.org> <20111208123004.GA964@e-circ.dyndns.org> <loom.20111208T134455-791@post.gmane.org> <20111208133213.GB964@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:55402 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750781Ab1LHO1n (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 8 Dec 2011 09:27:43 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1RYewk-0001jd-Vb
	for linux-can@vger.kernel.org; Thu, 08 Dec 2011 15:27:39 +0100
Received: from fire.makon-engineering.de ([80.152.230.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 08 Dec 2011 15:27:38 +0100
Received: from wutz by fire.makon-engineering.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 08 Dec 2011 15:27:38 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

> that sounds not good.
> can-j1939-utils should have binaries like candump, can..., jspy, jacd=
, ...

^^yes, that is true


=20
> iproute2-j1939 should have (at least) ip.

gosh, it seems that I was a bit puzzled.

I wanted to make

$ make KERNEL_INCLUDE=3D<KERNEL_HEADER_PATH> CC=3Dpowerpc-603e-linux-gn=
u-gcc
then=20

utils.c: In function =E2=80=98rt_addrpr_n2a=E2=80=99:
utils.c:518: error: =E2=80=98AF_CAN=E2=80=99 undeclared (first use in t=
his function)
utils.c:518: error: (Each undeclared identifier is reported only once
utils.c:518: error: for each function it appears in.)
make[1]: *** [utils.o] Error 1
make: *** [all] Error 2

occured




