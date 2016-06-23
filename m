From: ajneu <ajneu1@gmail.com>
Subject: Re: programatically determine netlink-type: can or vcan ...
Date: Thu, 23 Jun 2016 07:09:30 +0000 (UTC)
Message-ID: <loom.20160623T090620-429@post.gmane.org>
References: <loom.20160621T163010-819@post.gmane.org> <loom.20160621T171750-409@post.gmane.org> <loom.20160621T224622-469@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:50174 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751241AbcFWHJj (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 23 Jun 2016 03:09:39 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1bFyld-0005cT-8x
	for linux-can@vger.kernel.org; Thu, 23 Jun 2016 09:09:37 +0200
Received: from 195.50.142.51 ([195.50.142.51])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 23 Jun 2016 09:09:37 +0200
Received: from ajneu1 by 195.50.142.51 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 23 Jun 2016 09:09:37 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

ajneu <ajneu1 <at> gmail.com> writes:

> OK, it turns out that it was quite manageable, to add the desired
> functionality to libsocketcan.
> See 
> https://github.com/ajneu/libsocketcan
> https://github.com/ajneu/libsocketcan/commit/26ef

Added another commit, that adds function: device_is_up()

Why? The existing can_get_state() is limited only to can devices. It does
not work for vcan.

I hope Marc Kleine-Budde can integrate these changes into the official git.

Regards,
ajneu

