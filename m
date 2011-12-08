From: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
Subject: Re: using j1939: AF_CAN missing
Date: Thu, 08 Dec 2011 16:34:09 +0100
Message-ID: <4EE0D8F1.6040501@volkswagen.de>
References: <loom.20111206T131950-88@post.gmane.org> <20111206131815.GD322@e-circ.dyndns.org> <loom.20111207T093827-478@post.gmane.org> <20111207143333.GD373@e-circ.dyndns.org> <20111207145032.GE373@e-circ.dyndns.org> <loom.20111208T120006-91@post.gmane.org> <20111208123004.GA964@e-circ.dyndns.org> <loom.20111208T134455-791@post.gmane.org> <20111208133213.GB964@e-circ.dyndns.org> <loom.20111208T150123-262@post.gmane.org> <20111208151725.GD964@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mr1.volkswagen.de ([194.114.62.75]:39683 "EHLO
	mr1.volkswagen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972Ab1LHPeM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 8 Dec 2011 10:34:12 -0500
In-Reply-To: <20111208151725.GD964@e-circ.dyndns.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

Am 08.12.2011 16:17, schrieb Kurt Van Dijck:
>
> utils.c: In function =E2=80=98rt_addrpr_n2a=E2=80=99:
> utils.c:518: error: =E2=80=98AF_CAN=E2=80=99 undeclared (first use in=
 this function)
> It appears your toolchain isn't even aware of CAN.
> I'm not sure how to solve that one.
>
> Anyone?

Yep. As i written before the include files of the BSP itself are outdat=
ed.

You need to specifiy the Kernel includes directory to be taken from the=
=20
cross built Kernel.

---
in the directory 'build-target/linux-2.6.xx' your Linux kernel is=20
unpacked, patched and compiled.

=46or a quick hack you can just try to update the files in

build-target/linux-2.6.xx/net/can/*
build-target/linux-2.6.xx/include/linux/can/*
---

This kernel supports CAN.

Your modules will not match (and load) if you build the modules against=
=20
a different kernel.

And also the can-utils are happy when having the 'right' kernel include=
s ;-)

Regards,
Oliver

