From: Jeff Holtz <jeff.holtz@movimentogroup.com>
Subject: Re: Rebuild Drivers for Ubuntu
Date: Mon, 12 May 2014 06:54:57 +0000 (UTC)
Message-ID: <loom.20140512T085000-3@post.gmane.org>
References: <loom.20140512T070934-65@post.gmane.org> <537068BB.5040901@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:59485 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754133AbaELGzO (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 12 May 2014 02:55:14 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1Wjk8j-0008Es-NQ
	for linux-can@vger.kernel.org; Mon, 12 May 2014 08:55:09 +0200
Received: from c-69-246-11-150.hsd1.mi.comcast.net ([69.246.11.150])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 12 May 2014 08:55:09 +0200
Received: from jeff.holtz by c-69-246-11-150.hsd1.mi.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 12 May 2014 08:55:09 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org


BRILLIANT!!

Thanks.  This worked.  I had tried to simply do a make and it wasn't

working.  Found the error since I am on Trusty 3.13 and PDE is no longer

valid (need to use PDE_DATA)
 

I'd love to figure out how to simply place can-modules into source and

rebuild everything but seeing as I have what I'm looking for now I'm good to

do.  THANKS AGAIN!!!


