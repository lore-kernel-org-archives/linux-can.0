From: =?ISO-8859-1?Q?Fran=E7ois?= <fbeaulier@orange.fr>
Subject: Re: SocketCAN over Ethernet
Date: Thu, 03 Apr 2014 22:54:16 +0200
Message-ID: <533DCA78.7030906@orange.fr>
References: <loom.20140403T134741-892@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:53550 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753549AbaDCUyZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 Apr 2014 16:54:25 -0400
In-Reply-To: <loom.20140403T134741-892@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Daniel_Bostr=F6m?= <daniel.bostrom@maximatecc.com>, linux-can@vger.kernel.org

Hello Daniel,

Have a look at socketcand :
https://github.com/dschanoeh/socketcand

It might be exactly what you are looking for...

=46. Beaulier

Le 03/04/2014 13:52, Daniel Bostr=F6m a =E9crit :
> Hello,
>
> I am going to try to explain our scenario briefly.
>
> We want to setup a simulation environment for our system running on U=
buntu
> so that we can use it together with our Windows based simulation tool
> suite. Currently we are running Ubuntu in a virtual machine using
> VirtualBox on a Windows host. In Ubuntu we use SocketCAN and we would=
 like
> to continue to do so but instead of using real CAN hardware somehow s=
etup
> CAN communication over Ethernet to the Windows host.
>
> I am new to CAN on Linux but I have been reading about SocketCAN and =
was
> wondering if we could use virtual can (vcan) somehow?
>
> I appreciate any help clarifying if, and if so, how SocketCAN over
> Ethernet could be achieved. If you need additional information about =
our
> scenario please let me know.
>
> Best regards
> Daniel
>  =20
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

