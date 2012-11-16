From: Steffen Rose <ro@emtas.de>
Subject: Re: pch_can: Data transmission stops after dropped packet
Date: Fri, 16 Nov 2012 09:24:58 +0100
Message-ID: <2198824.y7jb65tpYb@lisa>
References: <loom.20121114T160521-534@post.gmane.org> <14870489.3crZoRWJoA@lisa> <loom.20121115T191324-6@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:49344 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765Ab2KPIZB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 16 Nov 2012 03:25:01 -0500
Received: from localhost (localhost [127.0.0.1])
	by kolab.emtas.de (Postfix) with ESMTP id F0E82563D9D
	for <linux-can@vger.kernel.org>; Fri, 16 Nov 2012 09:25:03 +0100 (CET)
Received: from kolab.emtas.de ([127.0.0.1])
	by localhost (kolab.emtas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vqdBm0ZtUtjt for <linux-can@vger.kernel.org>;
	Fri, 16 Nov 2012 09:25:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by kolab.emtas.de (Postfix) with ESMTP id 85062563DE1
	for <linux-can@vger.kernel.org>; Fri, 16 Nov 2012 09:25:03 +0100 (CET)
Received: from lisa.localnet (lisa.emtas.de [192.168.3.54])
	by kolab.emtas.de (Postfix) with ESMTPS id 4EAA1563B61
	for <linux-can@vger.kernel.org>; Fri, 16 Nov 2012 09:25:03 +0100 (CET)
In-Reply-To: <loom.20121115T191324-6@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello,

Am Donnerstag, 15. November 2012, 18:26:39 schrieb Michael Pellegrini:
> I saw your post and tried the solutions proposed by Marc, which are copied
> below:
> 
> "
> Your program probably produces CAN frames faster than they could be
> delivered by your CAN hardware. Your choices are:

The possible solutions had not solved my problem. I hope I wrote it. My idea 
was at this point, that I had a problem with the USB connection.

After I read this problem descrition I think, it is a general problem, that is 
not only involved in the pch_can driver, because I use a different one with the 
same problem (as seen from the users point of view ;-) ).

-- 
Best regards
Steffen Rose

