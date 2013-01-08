From: =?iso-8859-1?Q?Heinz-J=FCrgen_Oertel?= <oe@port.de>
Subject: Re: exclusive access to can interface
Date: Tue, 8 Jan 2013 10:18:27 +0000
Message-ID: <2287848.8ERXcjpij0@uschi>
References: <2412937.XVpYjfC7zz@ws-stein> <1943558.lxo8ZHFGuj@ws-stein>
 <50EBF058.5050400@volkswagen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from host24.networkinvest.de ([46.4.85.104]:39349 "EHLO
	host24.networkinvest.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755533Ab3AHK0E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Jan 2013 05:26:04 -0500
In-Reply-To: <50EBF058.5050400@volkswagen.de>
Content-Language: de-DE
Content-ID: <989DD8BBA9134F4F80FBCE918E54B0E4@portgmbh.local>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Am Dienstag, 8. Januar 2013, 11:09:28 schrieb Oliver Hartkopp:
> .....
> This should be solved by the system setup.
 +1
> E.g. if you start two applications using/providing identical resources at
> the same time, you'll always get into trouble.
> 
> If you start two inetd daemons, the second one would fail as he would like
> to bind the same IP ports. But this kind of mechanic is not available with
> CAN sockets.
>
> I would tend to make sure that the Node-ID is always unique in your system.
> What would happen, if you start a Node-ID on your host that already exists
> on the CAN networks attached to the system? You have to deal with that too:
> E.g. terminate myself with some error logging if i see my own Node-ID

that is the point, correct.
 
> .....

regards
   Heinz