From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v4] can/peak_usb: add support for PEAK new CANFD USB adapters
Date: Wed, 14 Jan 2015 19:55:27 +0100
Message-ID: <54B6BB9F.2050007@hartkopp.net>
References: <1420538446-8336-1-git-send-email-s.grosjean@peak-system.com> <54AD66C5.10908@pengutronix.de> <54B64B41.2040500@peak-system.com> <54B64DDF.5050909@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:34972 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbbANSzw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 14 Jan 2015 13:55:52 -0500
In-Reply-To: <54B64DDF.5050909@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Stephane Grosjean <s.grosjean@peak-system.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 14.01.2015 12:07, Marc Kleine-Budde wrote:

> Same here:
>> =E2=9E=9C (pts/32) frogger@hardanger:/tmp git clone https://gitoriou=
s.org/linux-can/linux-can.git
>> Cloning into 'linux-can'...
>> error: RPC failed; result=3D22, HTTP code =3D 504
>> fatal: The remote end hung up unexpectedly
>
> 504 is Gateway timeout - maybe the kernel is too big to clone :D
>
> I'd suggest to add can and can-next as a remote to an existing linux =
git tree.
>

It already gets stuck, when you just try to open the Linux-CAN project =
start=20
page at https://gitorious.org/linux-can ...

What about trying to host linux-can and linux-can-next on kernel.org ?

The userspace stuff can remain on gitorious - as these are small repos.

Regards,
Oliver
