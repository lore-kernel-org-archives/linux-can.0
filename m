From: Steffen Rose <ro@emtas.de>
Subject: Re: socketCan build fails
Date: Mon, 27 Feb 2012 10:12:46 +0100
Message-ID: <9642069.LSMGlbII5g@lisa>
References: <4F4654F6.8010201@wegmannusa.com> <4F4675B7.4040605@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:63158 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674Ab2B0JMv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 27 Feb 2012 04:12:51 -0500
Received: from localhost (localhost [127.0.0.1])
	by kolab.emtas.de (Postfix) with ESMTP id 7810E561C13
	for <linux-can@vger.kernel.org>; Mon, 27 Feb 2012 10:12:53 +0100 (CET)
Received: from kolab.emtas.de ([127.0.0.1])
	by localhost (kolab.emtas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wLwdN6eVk+N1 for <linux-can@vger.kernel.org>;
	Mon, 27 Feb 2012 10:12:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by kolab.emtas.de (Postfix) with ESMTP id 97CAE561E10
	for <linux-can@vger.kernel.org>; Mon, 27 Feb 2012 10:12:52 +0100 (CET)
In-Reply-To: <4F4675B7.4040605@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Gabriel Manriquez <gmanriquez@wegmannusa.com>

Hi,

> The content of the kernel/2.6 directory is mainly needed for older Ke=
rnels
> that do not have SocketCAN support (which was introduced in 2.6.25).

differ the kernel socketCAN path from our used socketCAN?

Of course, I know, this both are different repositories. But I was the =
meaning,=20
that at the first the changes comes in our repository and later our pat=
ches are=20
copied to the kernel.

Additional question:
Are there a Kernel list with information, which socketCAN feature is in=
cluded=20
(e.g. 3.2 - gateway functionality)?
Is there a "TAG" in our repository to see, which software state was cop=
ied to=20
which kernel version?

--=20
Mit freundlichen Gr=FC=DFen / Regards
Steffen Rose
emtas - your embedded solution partner

