From: Christian Bendele <Christian.Bendele@gmx.net>
Subject: Re: [RFC v3 0/7] =?utf-8?b?cGNoX2Nhbi9jX2Nhbjo=?= fix races and add PCH support to =?utf-8?b?Y19jYW4=?=
Date: Wed, 12 Dec 2012 12:51:43 +0000 (UTC)
Message-ID: <loom.20121212T131741-530@post.gmane.org>
References: <1355260735-18994-1-git-send-email-wg@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:58606 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751891Ab2LLMwD (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 12 Dec 2012 07:52:03 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1TilnF-00057Q-Uu
	for linux-can@vger.kernel.org; Wed, 12 Dec 2012 13:52:09 +0100
Received: from irdmzpr02-ext.ir.intel.com ([192.198.151.37])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 12 Dec 2012 13:52:09 +0100
Received: from Christian.Bendele by irdmzpr02-ext.ir.intel.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 12 Dec 2012 13:52:09 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Wolfgang Grandegger <wg <at> grandegger.com> writes:

> 
> Hello,
> 
> here is v3 of my patches for the C_CAN drivers.

What are those patches against? They don't apply against current mainstream
kernel (3.7)... 


> Anyway, we now know that the handling of reveive objects is not water-
> proof. To fix out-of-order receipten we should implement an improved
> algorithm as suggested by Marc here:
> 
>   http://marc.info/?l=linux-can&m=135487418225533&w=2

I'd like to take a look at this, but unfortunately that link consistently times
out for me.


> I will not have time to look into that befoer Xmas. Volunteers are
> welcome.

Pfffffft.... Personally I wouldn't be opposed to investing some time in this,
but I don't think I could get this cleared through legal in any useful time 
frame. 
Definitely not before next year. If there's still a lot of work left in January
I'll give it a try.

Christian

