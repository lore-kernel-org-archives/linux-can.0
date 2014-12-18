From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: [PATCH v5 0/5] Consolidate and unify state change handling
Date: Thu, 18 Dec 2014 06:09:43 +0000 (UTC)
Message-ID: <loom.20141218T070747-796@post.gmane.org>
References: <a0f69b4e-b1d5-4c3e-b960-b9f2b34a4e1a@GRBSR0089.marel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:41459 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751700AbaLRGPH (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 18 Dec 2014 01:15:07 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1Y1UMZ-000091-WA
	for linux-can@vger.kernel.org; Thu, 18 Dec 2014 07:15:04 +0100
Received: from motec6.motec.com.au ([115.70.189.243])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 18 Dec 2014 07:15:03 +0100
Received: from tom_usenet by motec6.motec.com.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 18 Dec 2014 07:15:03 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Andri Yngvason <andri.yngvason <at> marel.com> writes:
> Tested on sja1000 using
>  cangen -Ii -g 100 can0
> and
>  candump -ta -e can0,0:0,#FFFFFFFF
> 
> Disconnected bus:
>  (1417614605.207964)  can0  07D   [6]  49 6E A1 7A 2A 3D
>  (1417614605.308206)  can0  07E   [8]  5F 18 AA 0F E5 82 CA 11
>  (1417614605.408107)  can0  07F   [5]  3E 12 B0 68 1A
>  (1417614605.514235)  can0  20000004   [8]  00 08 00 00 00 00 60 00  
ERRORFRAME
> 	controller-problem{tx-error-warning}
> 	error-counter-tx-rx{{96}{0}}

Is the version of candump that supports "-e" and prints the errors
available? It would be very useful in my current testing.

Thanks.


