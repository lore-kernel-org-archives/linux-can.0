From: wouter van herpen <wouter.van.herpen@prodrive-technologies.com>
Subject: Re: =?utf-8?b?Y19jYW46?= wrong frame order reception
Date: Wed, 21 Oct 2015 09:19:38 +0000 (UTC)
Message-ID: <loom.20151021T111146-165@post.gmane.org>
References: <2323199.vffRdFDsB5@ws-stein> <7234338.9RqiOdiLOY@ws-stein> <533B067A.3030609@hartkopp.net> <1451869.V7QBi99RiY@ws-stein> <cdaa71c3255e192a2dea2e4f3f26e49a@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:44481 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754243AbbJUJZQ (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 21 Oct 2015 05:25:16 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1Zopdp-0007P1-5p
	for linux-can@vger.kernel.org; Wed, 21 Oct 2015 11:25:05 +0200
Received: from prodrive.fiberspeed.claranet.nl ([prodrive.fiberspeed.claranet.nl])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 21 Oct 2015 11:25:05 +0200
Received: from wouter.van.herpen by prodrive.fiberspeed.claranet.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 21 Oct 2015 11:25:05 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi all,

I am currently working on the Intel atom platform with EG20T.

Using the c_can driver from the main line 4.1.10 kernel sources, I still see
frames received in a swapped order.

It looks like all the patches mentioned in the list above are already
applied in this main line c_can driver.

Is the frame order swapping still a known issue? Are there any additional
patches regarding this issue that I'm not aware off?








