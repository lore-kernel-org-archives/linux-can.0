From: Sebastian Haas <dev@sebastianhaas.info>
Subject: Re: adding can4linux to drivers/char
Date: Sat, 21 Sep 2013 18:37:31 +0200
Message-ID: <CADGMhsU2fD3VnSkRqCJ9AT3SCmKRaX_965i6Kr-gdaFFwDejvw@mail.gmail.com>
References: <1881932.U1kQQJkqCz@heinz.site>
	<523DA147.7090403@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtprelay05.ispgateway.de ([80.67.31.94]:49155 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225Ab3IUQoI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 21 Sep 2013 12:44:08 -0400
Received: from [209.85.216.52] (helo=mail-qa0-f52.google.com)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.68)
	(envelope-from <dev@sebastianhaas.info>)
	id 1VNQBY-0003X5-Jc
	for linux-can@vger.kernel.org; Sat, 21 Sep 2013 18:37:32 +0200
Received: by mail-qa0-f52.google.com with SMTP id k4so479010qaq.11
        for <linux-can@vger.kernel.org>; Sat, 21 Sep 2013 09:37:31 -0700 (PDT)
In-Reply-To: <523DA147.7090403@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: =?ISO-8859-1?Q?Heinz=2DJ=FCrgen_Oertel?= <hj.oertel@t-online.de>, linux-can@vger.kernel.org

As Oliver already pointed out there are a bunch of applications outside
which may require a can4linux-like chardev API.

But I also agree that merging an additional CAN framework makes not
much sense. I prefer to port can4linux drivers to SocketCAN for not
yet supported devices. But we may also think about an emulation of
chardev based APIs like can4linux to support legacy applications.

-Sebastian

2013/9/21 Marc Kleine-Budde <mkl@pengutronix.de>:
> On 09/21/2013 01:03 AM, Heinz-J=FCrgen Oertel wrote:
>> long before SocketCAN, which now is part of the Linux kernel drivers=
,
>> can4linux was available as the CAN device driver for Linux.
>>
>> I now like to add it to the kernel source tree as well. What to you
>> think about it. And how should I start and proceed?
>
> I suggest to port you existing applications to linux-can. I'm sure
> you'll find help here and there are several companies out there who
> offer commercial support on this.
>
> From my point of view, it quite unlikely that this code will be merge=
d
> to mainline, as there is already a working solution.
>
> regards,
> Marc
>
> --
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
>
