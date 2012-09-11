From: Mahesh.Maharjan-EXT@continental-corporation.com
Subject: Antwort: Re: problem with adding socketcan isotp " frreescale imx"
Date: Tue, 11 Sep 2012 11:32:38 +0200
Message-ID: <OF00E617F7.E1525EED-ONC1257A76.0033FAFA-C1257A76.00346CF5@continental-corporation.com>
References: <OF888EFFE9.4D2BD1DC-ONC1257A75.002CF71F-C1257A75.002DDB22@continental-corporation.com> <504E34E9.7020108@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailout65.rmx.de ([62.134.45.45]:49055 "EHLO mailout65.rmx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756674Ab2IKJcs (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 11 Sep 2012 05:32:48 -0400
Received: from [10.64.70.33] (HELO kdin65.retarus.de)
  by mailout65.rmx.de (CommuniGate Pro SMTP 5.2.13 _community_)
  with ESMTP id 37259413 for linux-can@vger.kernel.org; Tue, 11 Sep 2012 11:32:46 +0200
Received: from sbas141a.vs.de.conti.de ([10.215.251.127])
	by kdin65.retarus.de (8.14.2/8.14.2/retarus.custom) with ESMTP id q8B9WimS000815
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-can@vger.kernel.org>; Tue, 11 Sep 2012 11:32:46 +0200
Received: from sbas141a.cw01.contiwan.com (sbas141a.vs.de.conti.de [158.92.186.140])
	by sbas141a.vs.de.conti.de (8.13.8/8.13.8) with ESMTP id q8B9Wikl020995
	for <linux-can@vger.kernel.org>; Tue, 11 Sep 2012 11:32:44 +0200
In-Reply-To: <504E34E9.7020108@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Thanks Oliver for reply.

As far , I do not see  can-isotp 

But when I tried with modprobe.. the module do not exist in system...
 But it compile comletely




Von:    Oliver Hartkopp <socketcan@hartkopp.net>
An:     Mahesh.Maharjan-EXT@continental-corporation.com
Kopie:  linux-can@vger.kernel.org
Datum:  10.09.2012 20:44
Betreff:        Re: problem with adding socketcan isotp " frreescale imx"



On 10.09.2012 10:20, Mahesh.Maharjan-EXT@continental-corporation.com 
wrote:

>  I am trying to use SocketCAN  ISOTP in freescale imx board. I added 
isotp 
> source file in freescale BSP (linux 2,638 imx ). It compile properly , 
but 
> when I trying use in application it is not supported. As socket and 
> binding with isotp is not with  working with it.


Did you see some can-isotp banner in dmesg?
Have you tried 'modprobe can-isotp'?
Does it appear in lsmod?

Regards,
Oliver



