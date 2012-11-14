From: Michael Pellegrini <mikep86@gmail.com>
Subject: =?utf-8?b?cGNoX2Nhbjo=?= Data transmission stops after dropped packet
Date: Wed, 14 Nov 2012 15:39:18 +0000 (UTC)
Message-ID: <loom.20121114T160521-534@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:42389 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932713Ab2KNPpE (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 14 Nov 2012 10:45:04 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1TYf9D-0000FF-Nn
	for linux-can@vger.kernel.org; Wed, 14 Nov 2012 16:45:04 +0100
Received: from 96.45.208.254 ([96.45.208.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 14 Nov 2012 16:45:03 +0100
Received: from mikep86 by 96.45.208.254 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 14 Nov 2012 16:45:03 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi All,

I am trying to use the pch_can driver to interface with a CANopen system.
I am encountering a serious issue where, at random intervals, the CAN interface
will lock up and stop transmitting data.  Data reception continues normally.
The only way I've found to resolve the issue so far is to issue an
"ifconfig canx down" command followed by an "ifconfig canx up" command.
After the interface is reset through these commands, the TX packet dropped count
and the TX packet carrier count increment by 1.

I am running Ubuntu 12.04 with kernel version 3.2.0-23.

Has anyone else seen this problem or have a fix for it?

Thanks,
Mike



