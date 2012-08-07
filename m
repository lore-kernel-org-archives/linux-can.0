From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 3.6-rc1] canfd: remove redundant CAN FD flag
Date: Tue, 07 Aug 2012 10:33:16 +0200
Message-ID: <5020D2CC.6040106@hartkopp.net>
References: <501FEA95.3060906@hartkopp.net> <5020CEF7.9080809@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:62157 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124Ab2HGIdL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 7 Aug 2012 04:33:11 -0400
In-Reply-To: <5020CEF7.9080809@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 07.08.2012 10:16, Marc Kleine-Budde wrote:

> On 08/06/2012 06:02 PM, Oliver Hartkopp wrote:

>> The former flags definition turned out to be hard to use and is redundant in
>> the case of the CANFD_EDL flag.
>>
>> Do you want to take that patch in your linux-can tree to be pulled for 3.6-rc2
>> or should i send it to Dave/netdev-ML directly?
>> The patch is based on Linus' 3.6-rc1 tree.
> 
> I'll take the patch. As I'm the single point of contact, David will
> probably refuse to take it directly from you. I hope no one will blame
> us hard for modifying the ABI of the kernel for canfd frames. However I
> think it's okay as there are probably no users of the canfd frame out there.


Yes. We are the only users now and if you look at the patch in detail, i
removed these lines:

- * Btw. as long as there's no real implementation for CAN FD network driver
- * these bits are only preliminary.

Just if there's a discussion coming up.

From reading the CAN FD specs and the first controller register layout of the
M_CAN IP core the picture just settles :-)

> BTW: warning: 1 line adds whitespace errors.
> I've fixed this.


Many thanks!

Oliver

