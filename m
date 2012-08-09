From: "Bernhard Thiele" <bernhard-thiele@web.de>
Subject: Any chance to get the Softing CAN-AC PCI card to run with
 socketcan?
Date: Thu, 9 Aug 2012 16:40:28 +0200 (CEST)
Message-ID: <trinity-fd24c49d-69e3-4dee-9d03-b9b8ac39f610-1344523228553@3capp-webde-bs20>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:52400 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030385Ab2HIOpc (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 9 Aug 2012 10:45:32 -0400
Received: from 3capp-webde-bs20 ([172.19.170.20]) by mriweb.server.lan
 (mriweb001) with ESMTPA (Nemesis) id 0MRhSR-1TAA4q0Nw1-00Sk5Q for
 <linux-can@vger.kernel.org>; Thu, 09 Aug 2012 16:40:29 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello,

I wonder if anyone could give me an answer whether there is way to get the Softing-AC PCI card running with the current code base.

The card has an SJA1000 chip that seems to be supported by linux-can for some devices. However, for Softing devices I've only found support for the Softing PCMCIA cards in the source tree.

Is there are a way to get a Softing-AC PCI card running with linux-can?

Best regards,

Bernhard


P.S.: I hope this post is not off-topic for this list that seems mainly to be used by developers. If there is an active forum or mailing list for users, I'll gladly take any pointers to that address and repost there.
