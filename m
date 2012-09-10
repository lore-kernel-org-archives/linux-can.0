From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: problem with adding socketcan isotp " frreescale imx"
Date: Mon, 10 Sep 2012 20:43:53 +0200
Message-ID: <504E34E9.7020108@hartkopp.net>
References: <OF888EFFE9.4D2BD1DC-ONC1257A75.002CF71F-C1257A75.002DDB22@continental-corporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:62395 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408Ab2IJSny (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 10 Sep 2012 14:43:54 -0400
In-Reply-To: <OF888EFFE9.4D2BD1DC-ONC1257A75.002CF71F-C1257A75.002DDB22@continental-corporation.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mahesh.Maharjan-EXT@continental-corporation.com
Cc: linux-can@vger.kernel.org

On 10.09.2012 10:20, Mahesh.Maharjan-EXT@continental-corporation.com wrote:

>  I am trying to use SocketCAN  ISOTP in freescale imx board. I added isotp 
> source file in freescale BSP (linux 2,638 imx ). It compile properly , but 
> when I trying use in application it is not supported. As socket and 
> binding with isotp is not with  working with it.


Did you see some can-isotp banner in dmesg?
Have you tried 'modprobe can-isotp'?
Does it appear in lsmod?

Regards,
Oliver

