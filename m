From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: CAN State Information
Date: Fri, 09 Dec 2011 15:49:50 +0100
Message-ID: <4EE2200E.4060403@grandegger.com>
References: <166589D0B9DD2547A1319599B9BADA1FC1960C@vsv-exchange.ixxat.intranet.priv> <4EDE342E.8030102@grandegger.com> <166589D0B9DD2547A1319599B9BADA1FC1981F@vsv-exchange.ixxat.intranet.priv> <4EE10CB4.2090604@grandegger.com> <166589D0B9DD2547A1319599B9BADA1FC19968@vsv-exchange.ixxat.intranet.priv> <4EE1C3BF.70104@grandegger.com> <4EE1C47A.7080507@grandegger.com> <166589D0B9DD2547A1319599B9BADA1FC1998A@vsv-exchange.ixxat.intranet.priv> <4EE1CE2B.6090909@grandegger.com> <166589D0B9DD2547A1319599B9BADA1FC19A38@vsv-exchange.ixxat.intranet.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:40345 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752158Ab1LIOty (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 9 Dec 2011 09:49:54 -0500
In-Reply-To: <166589D0B9DD2547A1319599B9BADA1FC19A38@vsv-exchange.ixxat.intranet.priv>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: kime@ixxat.de
Cc: socketcan-core@lists.berlios.de, linux-can@vger.kernel.org

On 12/09/2011 02:41 PM, kime@ixxat.de wrote:
> I noticed that when libsocketcan calls send_dump_request() it returns a message for me that has a length of 3424 with recvmsg().  This is not the full message, if I add a loop into the routine to again receive, I receive a second message this time with a length of 1424.  I added some prints into the routine to output strings and sizes:
> 
> First read:
> nl_msg:-1073753668  u_msglen:3424
> lo
> nl_msg:-1073752676  u_msglen:2432
> eth0
> nl_msg:-1073751668  u_msglen:1424
> can0
> nl_msg:-1073750956  u_msglen:712
> can1
> 
> Second read:
> nl_msg:-1073753668  u_msglen:1424
> can2
> nl_msg:-1073752956  u_msglen:712
> can3
> 
> With this loop, it seems to work.  Does this make sense?

Yes, could you send a patch (showing your modifications)?

Wolfgang.
