From: Wolfgang Wagner <wutz@unterderbruecke.de>
Subject: how to apply j1939
Date: Thu, 1 Dec 2011 20:55:36 +0000 (UTC)
Message-ID: <loom.20111201T214040-329@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:39802 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753633Ab1LAVAK (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 1 Dec 2011 16:00:10 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1RWDjk-0001Ci-M5
	for linux-can@vger.kernel.org; Thu, 01 Dec 2011 22:00:08 +0100
Received: from p549CB4C3.dip.t-dialin.net ([84.156.180.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 01 Dec 2011 22:00:08 +0100
Received: from wutz by p549CB4C3.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 01 Dec 2011 22:00:08 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Good evening together,

I want to run the j1939-linux-can on my phycore MPC5121e-tiny.
I am using the OSELAS.BSP-Phytec-phyCORE-MPC512x-tiny-PD10.1.1,
Powerpc-603e-linux-gnu, ptxdist-2011.10.1.

I got the kernel module 'can-j1939-modules', usertools 
'can-j1939-utils' and the 'iproute2-j1939'. According to Mr Van Dijck,
these 3 are necessary - thanks to you.

I am an absolutely newbie, is there anywhere a documentation
how to apply this 3 things that CAN j1939 is enabled on my board?
Or would be anybody so kind and tell me which steps I have to 
do - I would be really thankful.

Kind regards,

Wolfgang


