From: ajneu <ajneu1@gmail.com>
Subject: Re: programatically determine netlink-type: can or vcan ...
Date: Tue, 21 Jun 2016 20:48:50 +0000 (UTC)
Message-ID: <loom.20160621T224622-469@post.gmane.org>
References: <loom.20160621T163010-819@post.gmane.org> <loom.20160621T171750-409@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:42051 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751454AbcFUVWk (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 21 Jun 2016 17:22:40 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1bFSba-0000hW-7e
	for linux-can@vger.kernel.org; Tue, 21 Jun 2016 22:49:06 +0200
Received: from HSI-KBW-091-089-244-194.hsi2.kabel-badenwuerttemberg.de ([91.89.244.194])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 21 Jun 2016 22:49:06 +0200
Received: from ajneu1 by HSI-KBW-091-089-244-194.hsi2.kabel-badenwuerttemberg.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 21 Jun 2016 22:49:06 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

ajneu <ajneu1 <at> gmail.com> writes:

> 
> This would be nice in libsocketcan, but it's not in there. Somewhat limited...
> 
> Missing also, from libsocketcan, is the ability to determine if a device
> such as can1 exists.
> (What I do now, is to just check if /sys/class/net/can1 exists.)
> 

OK, it turns out that it was quite manageable, to add the desired
functionality to libsocketcan.
See 
https://github.com/ajneu/libsocketcan
https://github.com/ajneu/libsocketcan/commit/26ef


